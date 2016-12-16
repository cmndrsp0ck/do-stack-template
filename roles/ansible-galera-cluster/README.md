# MariaDB Galera Cluster

### Features

- Setup mariadb galera cluster.
- Bootstrap new master and slaves.
- Install percona xtradb scripts and services. (@see https://github.com/olafz/percona-clustercheck)

---

## Role Variables

### Passwords

Passwords have to be stored on local ansible machine.

Set the path for the storage with `galera_password_lookup_dir` in **defaults/main.yml**. By default it's set as the following:

`galera_password_lookup_dir`: "storage/galera-cluster/{{ galera_cluster_name }}"

Keep in mind that the path must exist before the playbook can be executed.

### Group vars

`galera_server_package`: mariadb-server-10.1

`galera_cluster_name`: galera

`galera_bind_address`: 0.0.0.0

`galera_manage_users`: True


### Host vars


Set `galera_bootstrap` to true on one node, this will be the initial master node.

Set `galera_node_ip` for each host (@see example inventory. \**optional* )


### Monitor cluster via http
@see https://github.com/olafz/percona-clustercheck

Set `galera_check_scripts` to True if you like to install the percona clustercheck scripts

Set port for the xinetd service `galera_check_scripts_port`


### Checkuser for haproxy

Create a checkuser for HAproxy with no password:

Enable `galera_haproxy_user`-> True.

List all allowed hosts in `galera_haproxy_hosts`


## Dependencies

None

---
## Example


### Inventory

If you want to use a static inventory file, you can do so, and it should look something like the following.

    [galera_cluster_node]
    box1.mariadb galera_node_ip=10.0.1.23 galera_bootstrap=1
    box2.mariadb galera_node_ip=10.0.1.24
    box3.mariadb galera_node_ip=10.0.1.25

This role was modified to work with the galera-cluster module within the do-stack-template catalog. So if you've deployed using Terraform and stuck with the name *galera_cluster_node* for your DigitalOcean resource, you can simply use [terraform-inventory](https://github.com/adammck/terraform-inventory) and set up the following entry within a file with the Droplet's public IPv4 address as its name. (e.g. **host_vars/138.197.206.219**)

    ---
    galera_bootstrap: 1


### Playbook

    - hosts: galera_cluster_node
      roles:
        - galera-cluster
      become: true

### License

BSD

### Author Information

[netzwirt](https://github.com/netzwirt)

### Edited by

[barajasfab](https://github.com/barajasfab)
