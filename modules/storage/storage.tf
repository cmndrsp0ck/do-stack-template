# set up block storage volumes
resource "digitalocean_volume" "storage_volume" {
  count  = "2"
  name   = "${var.project}-volume-${count.index + 1}"
  region = "${var.region}"
  size   = "${var.volume_size}"
}

# set up storage nodes
resource "digitalocean_droplet" "storage_gateway" {
  count              = "2"
  image              = "${var.image_slug}"
  name               = "${var.project}-storage-${count.index + 1}"
  region             = "${var.region}"
  size               = "${var.storage_gateway_size}"
  private_networking = true
  ssh_keys           = ["${split(",",var.keys)}"]
  user_data          = "${data.template_file.user_data.rendered}"
  volume_ids         = ["${element(digitalocean_volume.storage_volume.*.id, count.index)}"]

  connection {
    user     = "root"
    type     = "ssh"
    key_file = "${var.private_key_path}"
    timeout  = "2m"
  }
}

# Passing in user-data to set up Ansible user for configuration
data "template_file" "user_data" {
  template = "${file("${path.root}/config/cloud-config.yaml")}"

  vars {
    public_key = "${var.public_key}"
  }
}

resource "digitalocean_floating_ip" "storage_fip" {
  region     = "${var.region}"
  droplet_id = "${digitalocean_droplet.storage_gateway.0.id}"
}
