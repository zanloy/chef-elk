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

logstash_instance 'logstash'
logstash_service 'logstash'
logstash_config 'logstash' do
  action :create
  notifies :restart, 'logstash_service[logstash]'
end
