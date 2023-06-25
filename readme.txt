Terraform Concepts :
Variables
Count and count index
Locals
Data Sources
Functions
Provisioners
modules

As a part of the project implementation will apply the above Concepts

Steps : 

Create VPC
Create internet gateway
Attach internet gateway to VPC(like attaching modem to home net)
create public subnet
create public route table
create private subnet
create private route table
create database subnet
create database route table
connecting all associations
NAT gateway
attach NAT gateway


Terraform tile are declared configuration

tfstate = this is where Terraform track the resources it created.

declared configuration must match actual configuration

Terraform plan will cross check the existing configuration and notify if there are any additions/changes.