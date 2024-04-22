# Convert RestJson to RailsJson

require 'fileutils'
require 'json'

FileUtils.rm_rf 'protocol-test/services'
FileUtils.rm_rf 'protocol-test/malformedRequests'
FileUtils.rm_rf 'protocol-test/validation'

def snake_case(string)
  string.gsub(/([a-z])([A-Z])/, '\1_\2').downcase
end

def deep_transform_keys(hash)
  hash.each_with_object({}) do |(k, v), acc|
    acc[snake_case(k)] = v.is_a?(Hash) ? deep_transform_keys(v) : v
  end
end

Dir.glob('protocol-test/**/*.smithy').each do |file|
  text = File.read(file)

  # general gsubs
  text.gsub!('aws.protocoltests.restjson', 'smithy.ruby.protocoltests.railsjson')
  text.gsub!('aws.protocols#restJson1', 'smithy.ruby.protocols#railsJson')
  text.gsub!('RestJson', 'RailsJson')
  text.gsub('REST JSON', 'RAILS JSON')
  text.gsub!('restJson1', 'railsJson')
  text.gsub!('Rest Json', 'Rails Json')

  # remove AWS API stuff
  text.gsub!("use aws.api#service\n", '')
  text.gsub!("use aws.auth#sigv4\n", '')
  text.gsub("@service(sdkId: \"Rest Json Protocol\")", '')
  text.gsub!("@sigv4(name: \"restjson\")\n", '')

  # make test id unique
  text.gsub!(/id: "(?!RailsJson)/, 'id: "RailsJson')

  # uri should be snake_case
  text.gsub!(/uri: "([^"]+)"/) { |m| "uri: \"#{snake_case($1)}\"" }

  File.open(file, "w") { |f| f.puts text }
end