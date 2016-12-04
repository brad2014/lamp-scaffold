# Simple Development Environment for LAMP Applications

This is a scaffold for a simple environment that you can put on any laptop to do
LAMP (Linux, Apache, MySql, Php) stack development.

To set up your environment (Windows, MacOS, or Linux), install:

- VirtualBox (with Guest Extensions):
  https://www.virtualbox.org/wiki/Downloads

- Vagrant:
  https://www.vagrantup.com/downloads.html

- Atom (our favorite editor):
  https://atom.io/

Add your favorite atom packages:

```
apm install language-puppet markdown-preview-plus sort-lines
```

Before you configure your virtual LAMP machine, you need to pick some passwords
for its database. Read the file
`environments/vagrant/hiera/secrets_example.yaml` for instructions.

To create a fresh virtual machine:
```
% vagrant up
```

You may want to add the hostname and ip address listed in the Vagrantfile
to your local /etc/hosts file (no one else on your network will see it,
so it doesn't have to be unique.  But it must be on its own subnet).

```
# echo '192.168.10.10 dev.example.com' >> /etc/hosts
```

Then, in your browser, you can view http://dev.example.com/myphpapp.
