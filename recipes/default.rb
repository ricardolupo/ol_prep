#
# Cookbook Name:: oci_ol_prep
# Recipe:: default
#
# Copyright (c) 2014 Ricardo Lupo, All Rights Reserved
# 
# We will install a local yum repo and the chef-client

file "/etc/yum.repos.d/public-yum-ol6.repo" do
	action :delete
end

execute "clean-yum-cache" do
	command "yum clean all"
end

remote_file "/etc/yum/repos.d/gde-ol6.repo" do
	source "http://ocipd-file01.us.oracle.com/software/repo/OracleLinux/gde-ol6.repo"
 	action :create_if_missing
 	notifies :run, "execute[clean-yum-cache]", :immediately
end

package "screen" do 
	action :install
end

service "screen" do
	action [:enable, :start]
end