# # encoding: utf-8

# Inspec test for recipe elk::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

# Java tests

# Elasticsearch tests
destribe port('0.0.0.0', 9200) do
  it { should_not be_listening }
end

describe port('127.0.0.1', 9200) do
  it { should be_listening }
end

# Logstash tests

# Kibana tests

# Nginx tests
