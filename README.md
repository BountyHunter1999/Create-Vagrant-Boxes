# Create-Vagrant-Boxes

- We'll use Packer to create a base box for VirtualBox and AWS.
- Packer is a tool for creating virtual machine images, for multiple platforms.

## Stages

### Builder

- Responsible for creating the image
- Different platform have different builders
- When we want to create a custom image, we need a base image to start from
- Builder will go to our target website and get the base image
  - For example, if we are creating a custom AMI for AWS:
    - Builder will go to the AWS website and get the base AMI
    - It will spin up a EC2 instnace
    - After we then customize the instance

### Provisioner

- After the builder has spin up an instance, in the provisioner section we'll provide instructions to configure/modify the machine
- we then take snapshot of the instance and create an image from it

### Post Processors

- Post processros runafter builders and provisioner and can be used to upload artifacts, compress and repackage files/images

## Mutable Infrastructure

-> We create a server and we are mutating it over time.

1. Develop Code (Code)
2. Spin up Server (Deploy)
3. Configure Server (Configure)

- Install OS
- Install packages/dependencies
- Secure/Harden
- Install Application
- Upgrade/Patch

- As we mutate the server, there will be configuration drift:
  - We can use ansible to make changes but still there will still be a possibility of configuration drift

## Immutable Infrastructure

1. Develop Code (Code)
2. Configure the server (Configure)
3. Deploy the server (Deploy)

- We create a server and we are not mutating it over time.
- We create a server and we are not mutating it over time.

- Flow:

  1. We write v1.0.0 of our application
  2. We'll use packer to create an image that will have our source code as well as all the necessary configuration changes that we may need to make our server work
  3. When we deploy, we'll just use that image to deploy our server

- Same goes for v2, we just follow the same process and deploy the v2 image, we then remove the older version servers.

## Setup

- Install Plugins:
  - The Amazon plugin can be used with HashiCorp Packer to create custom images on AWS

## Resources

- [Github Resource From Bento](https://github.com/chef/bento)
