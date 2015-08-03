#
# Cookbook Name:: postgresql
# Recipe:: default
#

case node["platform"]
when "ubuntu"
  include_recipe "postgresql::apt_repository"
  package "postgresql-common"  # install common files
when "debian"
  include_recipe "postgresql::debian_backports"
  include_recipe "postgresql::apt_repository"
when "rhel", "centos"
  include_recipe "postgresql::yum_repository"
end
