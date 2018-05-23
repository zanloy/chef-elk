# # encoding: utf-8

# Inspec test for recipe elk::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

# Java tests
describe file('/usr/bin/java') do
  it { should exist }
end

describe bash('/usr/bin/java -version 2>&1 | head -n 1') do
  its('stdout') { should match '1.8' }
end

# Elasticsearch tests
describe processes('/bin/java') do
  its('users') { should include 'elasticsearch' }
end

describe port('0.0.0.0', 9200) do
  it { should_not be_listening }
end

describe port('127.0.0.1', 9200) do
  it { should be_listening }
  its('processes') { should include 'java' }
end

#describe elasticsearch do
#  its('plugin_list.first') { should include 'x-pack' }
#end

describe http('http://localhost:9200/_cluster/health') do
  its('status') { should cmp 200 }
end

# TODO: Add http request with payload test and then a test to verify we can
# query it from ES

# Logstash tests
describe processes('/bin/java') do
  its('users') { should include 'logstash' }
end

describe bash(%Q(echo -n '{ "message": "testing-udp5000" }')) do
  its('exit_status') { should eq 0 }
end

http_request = http('http://localhost:9200/logstash-*/_doc/_count?q=message:testing-udp5000')
describe json(content: http_request.body) do
  its('count') { should be > 0 }
end

# Kibana tests
describe port('127.0.0.1', 5601) do
  it { should be_listening }
  its('processes') { should include 'node' }
end

describe http('http://localhost:5601') do
  its('status') { should cmp 200 }
end

# Nginx tests
describe port('0.0.0.0', 80) do
  it { should be_listening }
  its('protocols') { should cmp 'tcp' }
end
