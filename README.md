#### Purpose

This Terraform deployment will set up a floating IP, 2 nodes with Nginx configures as load balancers, and 2 web nodes. Provisioning will be handled by Terraform and configuration will be done with Ansible.

#### Prerequisites

* You'll need to install [Terraform](https://www.terraform.io/downloads.html) which will be used to handle Droplet provisioning.
* In order to apply configuration changes to the newly provisioned Droplets, [Ansible](http://docs.ansible.com/ansible/intro_installation.html) needs to be installed.
* Ansible's inventory will be handled by Terraform, so you'll need [terraform-inventory](https://github.com/adammck/terraform-inventory).
* We're going to need a DigitalOcean API key. The steps to generate a DigitalOcean API key can be found [here](https://www.digitalocean.com/community/tutorials/how-to-use-the-digitalocean-api-v2#how-to-generate-a-personal-access-token).
* Use the included `gen_auth_key` script to generate an auth key for your load balancing cluster.

#### Configuring

Let's get Terraform ready to deploy. We're going to be using **terraform.tfvars** to store values required such as API key, project name, SSH data, the number of backend nodes you want, etc. The sample file **terraform.tfvars.sample** has been supplied, just remember to remove the appended _.sample_. Once you have your all of the variables set, Terraform should be able to authenticate and deploy your Droplets.

Next we need to get Ansible set up by heading over to **group\_vars/all**. You can start by renaming **group\_vars/all/load\_balancer.sample** as **group\_vars/all/load\_balancer** and uncomment **do\_token** and **lb\_auth\_token** inside the file.

We're going to be using ansible-vault to securely store your API key. At this point you should already be in **group\_vars/all**, so you can now execute the following command, or something similar, in your terminal.

    $ ansible-vault create keys

You will now be able to edit the file and set the values. The file should look something like this:

    ---
    vault_do_token: umvkl89wsxwuuz4a1nyzap5rsyk4un9fza5qokd7nzrn42owfclv8gdqk3k5gzqlz
    vault_lb_auth_key: 0dgivsxomvb80sx3uvd6u42j3920pbvveik007ec8

If needed, you can always go back in and edit the file by simply executing `$ ansible-vault create keys`. To prevent having to enter in `--ask-vault-pass` every time you execute your playbook, we'll set up your password file and store that outside of the repo. You can do so by running the following command.

    $ echo 'password' > ~/.vaultpass.txt

Okay, now everything should be set up and you're ready to start provisioning and configuring your Droplets.

#### Deploying

We'll start by using Terraform. Make sure you head back to the repository home. You can run a quick check and create an execution plan by running `terraform plan`.

Once you're ready, use `terraform apply` to build the Droplets and floating IP. This should take about a minute or two depending on how many nodes you're spinning up. Once it finishes up, wait about 30 seconds for the cloud-config commands that were passed in to complete.

We're ready to begin configuring the Droplets. Execute the Ansible playbook to configure your Droplets by running the following

    ansible-playbook -i /usr/local/bin/terraform-inventory site.yml

This playbook will install and configure heartbeat, your floating IP re-assignment script, install and configure ngingx load balancers, and your backend nodes. You should see a steady output which will state the role and step at which Ansible is currently running. If there are any errors, you can easily trace it back to the correct role and section of the task.

#### Follow-up steps

At this point, you will have two droplets with Nginx configured as load balancers, a floating IP to be re-assigned between the two at any time, and two web nodes which can be used to set up your application code base. Keep in mind that the app nodes configuration is very basic, but the template files and tasks can easily be altered to suit your needs. If you already have Droplets provisioned, you can import them into Terraform, as well as create an image from it and use the image ID to spin up additional nodes. Any additional configuration can simple by done by creating a simple Ansible role, or modifying the existing one.
