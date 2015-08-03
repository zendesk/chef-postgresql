#
# Cookbook Name:: postgresql
# Resource:: language
#

actions :create, :drop

default_action :create

attribute :name,         kind_of: String, name_attribute: true
attribute :database,     kind_of: String
attribute :db_version,   kind_of: String, default: node["postgresql"]["version"]
attribute :contrib_pkg,  kind_of: String, default: node["postgresql"]["packages"][node["platform_family"]]["pg"]["contrib"]
attribute :lang_map,     kind_of: Hash, default: node["postgresql"]["packages"][node["platform_family"]]["lang"]

attr_accessor :exists
