#
# Cookbook Name:: postgresql
# Recipe:: dbg
#

include_recipe "postgresql"

package node["postgresql"]["packages"][node["platform_family"]]["pg"]["dbg"]
