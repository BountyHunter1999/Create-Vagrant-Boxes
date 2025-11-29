build:
	packer build .

validate: 
	packer validate .

get-images:
	aws ec2 describe-images \
	--region us-east-1 \
	--owners amazon \
	--filters "Name=name,Values=ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server*" \
	--query 'reverse(sort_by(Images, &CreationDate))[*].{AMI:ImageId,Name:Name,CreationDate:CreationDate}' \
	--output table
