#
# Cookbook Name:: postgresql
# Recipe:: configuration
#

pg_version = node["postgresql"]["version"]
restart_action = node["postgresql"]["cfg_update_action"].to_sym

directory "/etc/postgresql/#{pg_version}/main/" do
  owner  "postgres"
  group  "postgres"
  recursive true
end

case node["platform_family"]
when "debian"
  service_pg = "postgresql"
when "rhel"
  service_pg = "postgresql-#{node["postgresql"]["version"]}"
end

# environment
template "/etc/postgresql/#{pg_version}/main/environment" do
  source "environment.erb"
  owner  "postgres"
  group  "postgres"
  mode   "0644"
  notifies restart_action, "service[#{service_pg}]"
end

# pg_ctl
template "/etc/postgresql/#{pg_version}/main/pg_ctl.conf" do
  source "pg_ctl.conf.erb"
  owner  "postgres"
  group  "postgres"
  mode   "0644"
  notifies restart_action, "service[#{service_pg}]"
end

# pg_hba
template node["postgresql"]["hba_file"] do
  source "pg_hba.conf.erb"
  owner  "postgres"
  group  "postgres"
  mode   "0640"
  notifies :reload, "service[#{service_pg}]"
  sensitive true
end

# pg_ident
template node["postgresql"]["ident_file"] do
  source "pg_ident.conf.erb"
  owner  "postgres"
  group  "postgres"
  mode   "0640"
  notifies :reload, "service[#{service_pg}]"
  sensitive true
end

# postgresql
if node["postgresql"]["conf_custom"]
  file "/etc/postgresql/#{pg_version}/main/postgresql.conf" do
    content node["postgresql"]["conf"].map { |k, v| "#{k} = '#{v}'" }.join("\n")
    owner  "postgres"
    group  "postgres"
    mode   "0644"
    notifies restart_action, "service[#{service_pg}]"
  end
else
  template "/etc/postgresql/#{pg_version}/main/postgresql.conf" do
    source "postgresql.conf.erb"
    owner  "postgres"
    group  "postgres"
    mode   "0644"
    notifies restart_action, "service[#{service_pg}]"
  end
end

# start
template "/etc/postgresql/#{pg_version}/main/start.conf" do # ~FC037 variable ok
  source "start.conf.erb"
  owner  "postgres"
  group  "postgres"
  mode   "0644"
  notifies restart_action, "service[#{service_pg}]", :immediately
end
