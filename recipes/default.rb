#
# Cookbook Name:: cakephp
# Recipe:: default
#
# Copyright 2010, Jason Ardell
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "apache2"

if node.has_key?("ec2")
  server_fqdn = node.ec2.public_hostname
else
  server_fqdn = node.fqdn
end

remote_file "#{Chef::Config[:file_cache_path]}/cakephp-#{node[:cakephp][:version]}.tar.gz" do
  source "http://github.com/cakephp/cakephp/tarball/#{node[:cakephp][:version]}"
  mode "0644"
end

directory "#{node[:cakephp][:dir]}" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

execute "untar-cakephp" do
  cwd node[:cakephp][:dir]
  command "tar --strip-components 1 -xzf #{Chef::Config[:file_cache_path]}/cakephp-#{node[:cakephp][:version]}.tar.gz"
  creates "#{node[:cakephp][:dir]}/index.php"
end

# Make the CakePHP tmp directory writable
execute "make tmp dir writable" do
  command "chown -R #{node[:apache][:user]}:#{node[:apache][:group]} #{node[:cakephp][:dir]}/app/tmp"
end
execute "make tmp dir writable" do
  command "chmod -R 755 #{node[:cakephp][:dir]}/app/tmp"
end

template "#{node[:cakephp][:dir]}/app/config/database.php" do
  source "database.php.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(
    :host            => node[:cakephp][:db][:host],
    :user            => node[:cakephp][:db][:user],
    :password        => node[:cakephp][:db][:password],
    :database        => node[:cakephp][:db][:database]
  )
end

# Create our user-specific salt
template "#{node[:cakephp][:dir]}/app/config/core.php" do
  source "core.php.erb"
  owner "root"
  group "root"
  mode "0644"
end

template "#{node[:apache][:dir]}/cakephp.conf" do
  source "cakephp.apache.conf.erb"
end
