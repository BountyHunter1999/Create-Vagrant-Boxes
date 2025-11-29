# Preseed

- When we are installing an OS from a mounted iso as part of our Packer build, we need to provide a preseed file
- Packer needs the pressed file to handle any questions that would normally be answered interactively during a Debian Installation.
- The `-iso` builders have a `http_dir` or `http_content` option that allows us to serve a directory or a file over HTTP.
  - Any file inside of our `http_dir` or `http_content` will be served on local fileserver for our virtual machine to be able to access
  - We provide our preseed file here too, in boot command we provide `preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed_2.cfg<wait>`

