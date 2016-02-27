#
# Cookbook Name:: bbwin
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
#

include_recipe 'bbwin'

bbwin_setting 'bbdisplay' do
  section 'bbwin'
  value '127.0.0.1'
  notifies :restart, 'service[bbwin]'
end

service 'bbwin' do
  action [:start, :enable]
end
