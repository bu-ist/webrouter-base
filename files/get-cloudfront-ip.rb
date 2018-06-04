#!/usr/bin/ruby
#
#
require 'open-uri'
require 'json'

url = 'https://ip-ranges.amazonaws.com/ip-ranges.json'
buffer = open(url).read
result = JSON.parse(buffer)

result['prefixes'].each do |elem|
  #print "#{elem}\n"
  if elem['service'] == 'CLOUDFRONT'
    print "set_real_ip_from #{elem['ip_prefix']} ;\n"
  end
end

# At the end print our standard footer
#
print "\n# Set non-prod VPC subnet as trusted\nset_real_ip_from 10.57.252.0/22;\n"
print "\n# Set prod VPC subnet as trusted\nset_real_ip_from 10.58.0.0/22;\n"
print "\n# Set dsmk POC system as trusted\nset_real_ip_from 128.197.229.139/32 ;\n"
print "\n# Set lab F5 VIP as trusted\nset_real_ip_from 128.197.226.222/32 ;\n"
print "\n# Set test F5 VIP as trusted\nset_real_ip_from 128.197.70.9/32 ;\n"
print "\n# Set production F5 VIP as trusted\nset_real_ip_from 128.197.228.215/32 ;\n"
print "\n# Set the header we are looking at\nreal_ip_header X-Forwarded-For ;\n"
print "\n# Ignore all trusted IPs\nreal_ip_recursive on ;\n"

