# haproxy load balancers with a floating IP
resource "digitalocean_droplet" "load_balancer" {
  count              = 2
  image              = "${var.image_slug}"
  name               = "${var.project}-lb-${count.index + 1}"
  region             = "${var.region}"
  size               = "${var.lb_size}"
  private_networking = true
  ssh_keys           = ["${split(",",var.keys)}"]
  user_data          = "${data.template_file.user_data.rendered}"

  connection {
    user     = "root"
    type     = "ssh"
    private_key = "${var.private_key_path}"
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

resource "digitalocean_floating_ip" "ha_fip" {
  region     = "${var.region}"
  droplet_id = "${digitalocean_droplet.load_balancer.0.id}"
}
