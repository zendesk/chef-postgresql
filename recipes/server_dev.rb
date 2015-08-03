#
# Cookbook Name:: postgresql
# Recipe:: server_dev
#

include_recipe "postgresql"

# install the package
package node["postgresql"]["packages"][node["platform_family"]]["pg"]["dev"]
