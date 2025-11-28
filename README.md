# Create-Vagrant-Boxes

- We'll use Packer to create a base box for VirtualBox and AWS.
- Packer is a tool for creating virtual machine images, for multiple platforms.

## 0. Install Packer

```bash
make install-packer
```

## 1. Create a Base Box

[Guide](https://developer.hashicorp.com/vagrant/docs/boxes/base)

- These boxes contain the bare minimum required for Vagrant to function, are generally not made by repackaging an existing Vagrant environment (hence the "base" in the "base box")
  - For example, the Ubuntu boxes provided by the Vagrant project (such as "bionic64") are base boxes.
    - They were created from a minimal Ubuntu install from an ISO, rather than repackaging an existing environment.
- Base Boxes are extremely useful for having a clean slate starting point from which to build future development environments.
- Base Box may contain only the following:
  - Package amanger
  - SSH
  - SSH user so Vagrant can connect
  - Chef, Puppet, etc. but not strictly required
  - If we are making a box for VirtualBox, we will want to include the VirtualBox Guest Additions, so that shared folders work properly.
    - But for AWS base box, it's not necessary.

### VirtualBox Base Box
- It is important to add `shutdown_command`.
- By default Packer halts the virtual machine and the file system may not be sync'd.
- Thus, changes made in a provisioner might not be saved

## VirtualBox Guest Additions

[Guide](https://developer.hashicorp.com/vagrant/docs/providers/virtualbox/boxes#virtualbox-guest-additions)
