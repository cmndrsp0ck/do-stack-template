# Minio setup

### Features

- Install and configure minio
- Install and configure nginx

---

## Role Variables

* minio_url
* minio_host
* minio_bin
* minio_user
* minio_group
* minio_storage_dir
* minio_config_dir
* minio_access_key
* minio_secret_key

You'll notice that our *minio_access_key* and *minio_secret_key* are actually being assigned the value of another variable inside of **vars/keys.yml**. For this to work, you need to set up a file using `ansible-vault` and set the variables up. The command should look something like this `ansible-vault create group_vars/all/keys.yml` and you'll be prompted for a password.

You will now be able to edit the file and set the values. The file should look something like this:

    ---
    vault_do_token: fxazokwnyqh71oa5m2k4h1gqlxz4k5m50rkuw5ofn6ea6v9kfbb5me0qzi556eig
    vault_ha_auth_key: L7ZZ8Z2GVG851B64GTN3RON3CSWB5ODC1KM42T6

    vault_minio_ha_auth_key: M9D9RWKB0OOKMKGAWO1HUL5BVGUG086SXH4WK4O

    vault_minio_access_key: RPY75P6Z9PBFEQU0CVO6
    vault_minio_secret_key: ISHcsG97rkSoYE7kveJ0rXZGcMInWX6QOxL2w/as

You can use the following command to generate an authorization access and secret keys for minio. `LC_CTYPE=C; tr -dc 'A-Z0-9' < /dev/urandom | head -c 40`. The access key should be 20 characters long and start with an alphabetical character, and the secret key should be 40 characters.

If needed, you can always go back in and edit the file by simply executing `$ ansible-vault edit vars/keys.yml`. To prevent having to enter in `--ask-vault-pass` every time you execute your playbook, we'll set up your password file and store that outside of the repo. You can do so by running the following command.

    $ echo 'password' > ~/.vaultpass.txt

With that done, you can set `vault_password_file = ~/.vaultpass.txt` in **ansible.cfg** to read from your password file. Also, don't forget to set the filename you used in your *.gitignore* file.

Okay, now everything should be set up and you're ready to start provisioning and configuring your Droplets.

---

## Example

This has been written to work along with my [do-stack-template](https://github.com/barajasfab/do-stack-template). If you want to use it with your own terraform scripts, just remember to set the ansible hosts to the name you used for your *digitalocean_droplet* resource.

### Playbook

file: `site.yml`

    - hosts: storage_gateway
      roles:
        - blockstore_config
        - gluster_minio
        - minio
        - ha-minio
      become: True

### License

MIT

### Author Information

[barajasfab](https://github.com/barajasfab)
