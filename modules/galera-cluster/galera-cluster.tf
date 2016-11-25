resource "digitalocean_droplet" "galera_cluster_node" {
  count              = "${var.db_node_count}"
  image              = "${var.image_slug}"
  name               = "${var.project}-galera-cluster-node-${count.index+1}"
  region             = "${var.region}"
  size               = "${var.db_node_size}"
  private_networking = true
  ssh_keys           = ["${split(",",var.keys)}"]
  user_data          = "${data.template_file.user_data.rendered}"

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
