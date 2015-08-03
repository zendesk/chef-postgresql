#
# Cookbook Name:: postgresql
# Recipe:: data_directory
#

# ensure data directory exists
directory node["postgresql"]["data_directory"] do
  owner  "postgres"
  group  "postgres"
  mode   "0700"
  recursive true
  not_if { ::File.exist?("#{node["postgresql"]["data_directory"]}/PG_VERSION") }
end

pg_init_command = nil

case node["platform_family"]
when "debian"
  pg_init_command = "/usr/lib/postgresql/#{node["postgresql"]["version"]}/bin/initdb #{node["postgresql"]["initdb_options"]} -U postgres -D #{node["postgresql"]["data_directory"]}"
  user = "postgres"
when "rhel"
  user = "root"
  pg_init_command = "/usr/pgsql-#{node["postgresql"]["version"]}/bin/postgresql#{node["postgresql"]["flat_version"]}-setup initdb"
  bash "postgresql systemd" do
    user user
    code <<-EOC
    systemctl enable postgresql-9.3
    EOC
  end
end

# initialize the data directory if necessary
bash "postgresql initdb" do
  user user
  code <<-EOC
  #{pg_init_command}
  EOC
  not_if { ::File.exist?("#{node["postgresql"]["data_directory"]}/PG_VERSION") }
end
