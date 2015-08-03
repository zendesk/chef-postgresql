#
# Cookbook Name:: postgresql
# Recipe:: service
#

case node["platform_family"]
when "debian"
  file "/usr/sbin/policy-rc.d" do
    action :delete
  end
  service_pg = "postgresql"
when "rhel"
  service_pg = "postgresql-#{node["postgresql"]["version"]}"
end

# define the service
service service_pg do
  supports reload: true, restart: true, status: true
  action Array(node["postgresql"]["service_actions"]).map(&:to_sym)
end
