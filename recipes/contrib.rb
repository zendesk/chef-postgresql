#
# Cookbook Name:: postgresql
# Recipe:: contrib
#

include_recipe "postgresql"

package node["postgresql"]["packages"][node["platform_family"]]["pg"]["contrib"]
