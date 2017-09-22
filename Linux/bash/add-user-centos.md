在centos系统添加用户，并加sudo权限

> https://www.digitalocean.com/community/tutorials/how-to-create-a-sudo-user-on-centos-quickstart

```bash
adduser <username>
passwd <username>
```

出现:
```
passwd: all authentication tokens updated successfully.
```

```bash
usermod -aG wheel <username>
su - <username>
sudo ls -la /root
```

会列出`/root`目录即成功