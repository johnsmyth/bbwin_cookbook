#
# Cookbook Name:: bbwin
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
#

msi_file_name = "BBWIN_#{node['bbwin']['version']}.msi"

remote_file "#{Chef::Config['file_cache_path']}\\#{msi_file_name}" do
  source node['bbwin']['source_url']
  retries 5
end

package node['bbwin']['package_name'] do
  action :install
  source "#{Chef::Config['file_cache_path']}\\#{msi_file_name}"
end
