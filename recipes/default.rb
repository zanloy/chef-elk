#
# Cookbook:: elk
# Recipe:: default
#
# Copyright:: 2018, Zan Loy
#

include_recipe 'java'
include_recipe 'elasticsearch'
include_recipe 'simple-logstash'

elasticsearch_user 'elasticsearch'
elasticsearch_install 'elasticsearch'
elasticsearch_configure 'elasticsearch'
elasticsearch_service 'elasticsearch'
elasticsearch_plugin 'x-pack'

#logstash_instance 'logstash'
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
