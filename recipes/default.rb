#
# Cookbook Name:: oci_ol_prep
# Recipe:: default
#
# Copyright (c) 2014 Ricardo Lupo, All Rights Reserved
# 
# We will install a local yum repo and the chef-client

orig_repo = "/etc/yum.repos.d/public-yum-ol6.repo"
new_repo = "/etc/yum.repos.d/public-yum-ol6.repo"
source_repo = "http://ocipd-file01.us.oracle.com/software/repo/OracleLinux/gde-ol6.repo"



file "#{orig_repo}" do
	action :delete
end

execute "clean-yum-cache" do
	command "yum clean all"
  action :nothing
end

remote_file "#{new_repo}" do
	source "#{source_repo}"
 	action :create_if_missing
 	notifies :run, "execute[clean-yum-cache]", :immediately
 	not_if { ::File.exists?("#{new_repo}") }
end

package "screen" do 
	action :install
end
