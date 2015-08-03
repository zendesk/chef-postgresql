#
# Cookbook Name:: postgresql
# Recipe:: apt_repository
#

# pin default package preferences
apt_preference "pgdg" do
  glob "*"
  pin "release o=apt.postgresql.org"
  pin_priority "750"
end

# use `apt.postgresql.org` for primary package installation support
apt_repository node["postgresql"]["apt_repository"] do
  uri          node["postgresql"]["apt_uri"]
  distribution "#{node["postgresql"]["apt_distribution"]}-pgdg"
  components   node["postgresql"]["apt_components"]
  key          node["postgresql"]["apt_key"]
  keyserver    node["postgresql"]["apt_keyserver"]
end

# automatically get repository key updates
package "pgdg-keyring"
