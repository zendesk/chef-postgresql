#
# Cookbook Name:: postgresql
# Recipe:: yum_repository
#

package "yum-plugin-versionlock"

#execute "version-pin-postgresql" do
#  command "yum versionlock add postgresql#{node["postgresql"]["flat_version"]}"
#  not_if "yum versionlock list postgresql#{node["postgresql"]["flat_version"]}"
#end

# use `yum.postgresql.org` for primary package installation support
yum_repository node["postgresql"]["yum_repository"] do
  baseurl     node["postgresql"]["yum_baseurl"]
  description node["postgresql"]["yum_description"]
  gpgkey      node["postgresql"]["yum_gpgkey"]
  action      :create
end

# automatically get repository key updates
package "pgdg-#{node["platform"]}#{node["postgresql"]["flat_version"]}"
