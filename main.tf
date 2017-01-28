# Use modules to build stack

module "loadbalance" {
  source           = "./modules/ha-loadbalancer"
  lb_size          = "2gb"
  project          = "${var.project}"
  region           = "${var.region}"
  keys             = "${var.keys}"
  private_key_path = "${var.private_key_path}"
  ssh_fingerprint  = "${var.ssh_fingerprint}"
  public_key       = "${var.public_key}"
}

module "backend-nodes" {
  source           = "./modules/backend-node"
  node_count       = "2"
  node_size        = "1gb"
  project          = "${var.project}"
  region           = "${var.region}"
  keys             = "${var.keys}"
  private_key_path = "${var.private_key_path}"
  ssh_fingerprint  = "${var.ssh_fingerprint}"
  public_key       = "${var.public_key}"
}

module "galera-cluster" {
  source           = "./modules/galera-cluster"
  project          = "${var.project}"
  region           = "${var.region}"
  keys             = "${var.keys}"
  private_key_path = "${var.private_key_path}"
  ssh_fingerprint  = "${var.ssh_fingerprint}"
  public_key       = "${var.public_key}"
}


module "block-store" {
  source           = "./modules/storage"
  project          = "${var.project}"
  region           = "${var.region}"
  keys             = "${var.keys}"
  private_key_path = "${var.private_key_path}"
  ssh_fingerprint  = "${var.ssh_fingerprint}"
  public_key       = "${var.public_key}"
  volume_size      = "100"
}


