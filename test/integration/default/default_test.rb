# # encoding: utf-8

# Inspec test for recipe elk::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

# Java tests
describe file('/usr/bin/java') do
  it { should exist }
end

# Elasticsearch tests
describe processes('/bin/java') do
  its('users') { should eq ['elasticsearch'] }
end

describe port('0.0.0.0', 9200) do
  it { should_not be_listening }
end

describe port('127.0.0.1', 9200) do
  it { should be_listening }
end

describe elasticsearch do
  its('module_list.first') { should include 'x-pack' }
end

# Logstash tests

# Kibana tests

# Nginx tests
