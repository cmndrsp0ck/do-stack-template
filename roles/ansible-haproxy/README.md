# HAProxy load balancers

### Features

- Set up HAProxy on two DigitalOcean Droplets.
- Provision a floating IP.
- Configure floating IP re-assignment.

---

## Role Variables

You'll notice that our *do_token* and *ha_auth_key* are actually being assigned the value of another variable inside of **vars/main.yml**. For this to work, you need to set up a file using `ansible-vault` and set the variables up. The command should look something like this `ansible-vault create vars/keys.yml` and you'll be prompted for a password.

You will now be able to edit the file and set the values. The file should look something like this:

    ---
    vault_do_token: fxazokwnyqh71oa5m2k4h1gqlxz4k5m50rkuw5ofn6ea6v9kfbb5me0qzi556eig
    vault_ha_auth_key: L7ZZ8Z2GVG851B64GTN3RON3CSWB5ODC1KM42T6

You can use the `gen_auth_key` script to generate an authorization key for your haproxy cluster. If needed, you can always go back in and edit the file by simply executing `$ ansible-vault edit vars/keys`. To prevent having to enter in `--ask-vault-pass` every time you execute your playbook, we'll set up your password file and store that outside of the repo. You can do so by running the following command.

    $ echo 'password' > ~/.vaultpass.txt

With that done, you can set `vault_password_file = ~/.vaultpass.txt` in **ansible.cfg** to read from your password file. Also, don't forget to set the filename you used in your *.gitignore* file. If you've used a different name, it will need to be set in **vars/main.yml** and assigned to the `include_vars: ` statement.

Okay, now everything should be set up and you're ready to start provisioning and configuring your Droplets.

---

## Example

This has been written to work along with my [do-stack-template](https://github.com/barajasfab/do-stack-template). If you want to use it with your own terraform scripts, just remember to set the ansible hosts to the name you used for your *digitalocean_droplet* resource.

### Playbook

file: `site.yml`

    - hosts: load_balancer
      roles:
        - ansible-haproxy
      become: true

### License

MIT

### Author Information

[barajasfab](https://github.com/barajasfab)
