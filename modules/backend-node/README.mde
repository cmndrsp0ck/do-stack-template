## Module Parameters

#### Required
* node_count
* project
* region
* keys
* private_key_path
* ssh_fingerprint
* public_key

#### Optional
* node_size -> *(default = 2gb)*
* image_slug -> *(default = ubuntu-16-04-x64)*

---

## Example Usage

#### main.tf

    module "backend-nodes" {
      source           = "./modules/backend_node"
      node_count       = "4"
      node_size        = "1gb"
      project          = "${var.project}"
      region           = "${var.region}"
      keys             = "${var.keys}"
      private_key_path = "${var.private_key_path}"
      ssh_fingerprint  = "${var.ssh_fingerprint}"
      public_key       = "${var.public_key}"
    }

**note**: The module *source* path used depends on how you've set up your directory structure. 
