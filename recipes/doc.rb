#
# Cookbook Name:: postgresql
# Recipe:: doc
#

include_recipe "postgresql"

package node["postgresql"]["packages"][node["platform_family"]]["pg"]["doc"]
