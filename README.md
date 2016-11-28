#### Purpose

This repo can be used to stand up various parts of your deployment on DigitalOcean using Terraform modules. The current modules include:

* HAProxy load balancers (active-passive) with a floating IP
* Backend nodes
* Galera cluster

#### Prerequisites

* You'll need to install [Terraform](https://www.terraform.io/downloads.html) which will be used to handle Droplet provisioning.
* In order to apply configuration changes to the newly provisioned Droplets, [Ansible](http://docs.ansible.com/ansible/intro_installation.html) needs to be installed.
* Ansible's inventory will be handled by Terraform, so you'll need [terraform-inventory](https://github.com/adammck/terraform-inventory).
* We're going to need a DigitalOcean API key. The steps to generate a DigitalOcean API key can be found [here](https://www.digitalocean.com/community/tutorials/how-to-use-the-digitalocean-api-v2#how-to-generate-a-personal-access-token).
* Use the included **gen_auth_key** script to generate an auth key for your load balancing cluster.

#### Configuring

Use **terraform.tfvars** to store values required such as API key, project name, and SSH data. The sample file **terraform.tfvars.sample** has been supplied, just remember to remove the appended _.sample_. Once you have your all of the variables set, Terraform should be able to authenticate in order to deploy your Droplets.

Uncomment any blocks in **main.tf** for each module you want to use. You'll also be able to edit the module arguments for things like Droplet size and number of Droplets.

    module "galera-cluster" {
      source           = "./modules/galera-cluster"
      project          = "${var.project}"
      region           = "${var.region}"
      keys             = "${var.keys}"
      private_key_path = "${var.private_key_path}"
      ssh_fingerprint  = "${var.ssh_fingerprint}"
      public_key       = "${var.public_key}"
    }

This should allow you to spin up your Droplets and you'll be able to use `terraform-inventory` in order to to create your dynamic inventory listing to be used by Ansible. You'll be able to create **roles/**, then `cd` into it, and `git clone` a role you want to use such as [galera-cluster](https://github.com/barajasfab/ansible-galera-cluster).

#### Deploying

We'll start by using Terraform. Make sure you head back to the repository home. You can run a quick check and create an execution plan by running `terraform plan`.

Once you're ready, use `terraform apply` to build the Droplets and floating IP. This should take about a minute or two depending on how many nodes you're spinning up. Once it finishes up, wait about 30 seconds for the cloud-config commands that were passed in to complete.

When you're ready to begin configuring your Droplets, refer to the documentation for each Ansible role.

#### Follow-up steps

Keep in mind that this is a very basic setup, but the template files and tasks can easily be altered to suit your needs. If you already have Droplets provisioned, you can import them into Terraform, as well as create an image from it and use the image ID to spin up additional nodes. Any additional configuration can simple by done by creating a simple Ansible role, or modifying the existing ones.
