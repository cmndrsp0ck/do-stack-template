## Module Parameters

#### Required
* project
* region
* keys
* private_key_path
* ssh_fingerprint
* public_key

#### Optional
* db_node_count -> *(default = 3. Recommended value is 5 for production)*
* db_node_size -> *(default = 4gb)*
* image_slug -> *(default = ubuntu-16-04-x64)*

---

## Example Usage

#### main.tf

    module "galera-cluster" {
      source           = "./modules/galera-cluster"
      db_node_count    = "5"
      db_node_size     = "16gb"
      project          = "${var.project}"
      region           = "${var.region}"
      keys             = "${var.keys}"
      private_key_path = "${var.private_key_path}"
      ssh_fingerprint  = "${var.ssh_fingerprint}"
      public_key       = "${var.public_key}"
    }

**note**: The module *source* path used depends on how you've set up your directory structure.
