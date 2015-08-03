#
# Cookbook Name:: postgresql
# Recipe:: client
#

include_recipe "postgresql"

package node["postgresql"]["packages"][node["platform_family"]]["pg"]["client"]
