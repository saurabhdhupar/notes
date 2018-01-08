在centos系统添加用户，并加sudo权限

```bash
useradd -m chyroc
passwd chyroc
# userdel peter
echo -e "\nchyroc ALL=(ALL) ALL\n" >> /etc/sudoers
```
