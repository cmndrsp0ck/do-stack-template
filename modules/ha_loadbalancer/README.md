## Module Parameters

#### Required
* project
* region
* keys
* private_key_path
* ssh_fingerprint
* public_key

#### Optional
* lb_size -> *(default = 4gb)*
* image_slug -> *(default = ubuntu-16-04-x64)*

---

## Example Usage

#### main.tf

    module "loadbalance" {
      source           = "./modules/ha_loadbalancer"
      lb_size          = "8gb"
      project          = "${var.project}"
      region           = "${var.region}"
      keys             = "${var.keys}"
      private_key_path = "${var.private_key_path}"
      ssh_fingerprint  = "${var.ssh_fingerprint}"
      public_key       = "${var.public_key}"
    }

**note**: The module *source* path used depends on how you've set up your directory structure.
