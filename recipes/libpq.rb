#
# Cookbook Name:: postgresql
# Recipe:: libpq
#

include_recipe "postgresql"

case node["platform"]
when "debian", "ubuntu"
  package "libpq5" do
    options "-t #{node["postgresql"]["apt_distribution"]}-pgdg"
  end

  package "libpq-dev" do
    options "-t #{node["postgresql"]["apt_distribution"]}-pgdg"
  end
end
