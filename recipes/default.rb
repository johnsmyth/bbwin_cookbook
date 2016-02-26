#
# Cookbook Name:: bbwin
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
#

puts "!!!!!! #{node['bbwin']['source_url']}"
msi_file_name = "BBWIN_#{node['bbwin']['version']}.msi"

remote_file "#{Chef::Config['file_cache_path']}\\#{msi_file_name}" do
  source node['bbwin']['source_url']
end

windows_package node['bbwin']['package_name'] do
  action :install
  source "#{Chef::Config['file_cache_path']}\\#{msi_file_name}"
end

bbwin_setting 'bbdisplay' do
  section 'bbwin'
  value '127.0.0.1'
  notifies :restart, 'service[bbwin]'
end

service 'bbwin' do
  action [ :start, :enable ]
end
