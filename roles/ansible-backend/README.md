# Ansible backend nodes

### Features

- Configure backend nodes with nginx

---

## Role Variables

This is a very basic Ansible role and is really more of a template which can be modified for your use-case. Currently, you just need to set up your application name, doc_root, and server_name inside of **vars/main.yml**. 

		sites:
		  myapp1:
		    doc_root: /var/www/html
		    server_name: example.com www.example.com

If you need to make any adjustments to nginx's configuration, you can do so using the template files inside **templates/**.

---

## Example

This has been written to work along with my [do-stack-template](https://github.com/barajasfab/do-stack-template). If you want to use it with your own terraform scripts, just remember to set the ansible hosts to the name you used for your *digitalocean_droplet* resource.

### Playbook

file: `site.yml`

    - hosts: backend_node
      roles:
        - ansible-backend
      become: true

### License

MIT

### Author Information

[barajasfab](https://github.com/barajasfab)
