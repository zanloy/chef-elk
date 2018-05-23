#
# Cookbook:: elk
# Recipe:: default
#
# Copyright:: 2018, Zan Loy
#

# Both ES and Logstash require Java
include_recipe 'java'

# Give me an 'E'!
include_recipe 'elasticsearch'
elasticsearch_user 'elasticsearch'
elasticsearch_install 'elasticsearch'
elasticsearch_configure 'elasticsearch'
elasticsearch_service 'elasticsearch'
#elasticsearch_plugin 'x-pack'

# Give me an 'L'!
include_recipe 'simple-logstash'
logstash_service 'logstash'
logstash_input 'udp5000' do
  notifies :restart, 'logstash_service[logstash]'
end
logstash_filter 'access_events' do
  notifies :restart, 'logstash_service[logstash]'
end
logstash_output 'elasticsearch' do
  notifies :restart, 'logstash_service[logstash]'
end

# Give me a 'K'!
include_recipe 'kibana5'

# Give me a 'N'?
include_recipe 'nginx'
