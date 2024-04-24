# Convert RestJson to RailsJson
# This is helpful for syncing the tests if there are any new ones.
# There are some minor adjustments that need to be made to the test cases.
# Last synced April 24, 2024

require 'fileutils'
require 'json'

FileUtils.rm_rf 'model/services'
FileUtils.rm_rf 'model/malformedRequests'
FileUtils.rm_rf 'model/validation'

def snake_case(string)
  string.gsub(/([a-z])([A-Z])/, '\1_\2').downcase
end

Dir.glob('model/**/*.smithy').each do |file|
  text = File.read(file)

  # general gsubs
  text.gsub!('aws.protocoltests.restjson',
             'smithy.ruby.protocoltests.railsjson')
  text.gsub!('aws.protocols#restJson1', 'smithy.ruby.protocols#railsJson')
  text.gsub!('RestJson', 'RailsJson')
  text.gsub('REST JSON', 'RAILS JSON')
  text.gsub!('restJson1', 'railsJson')
  text.gsub('@service(sdkId: "Rest Json Protocol")', '')
  text.gsub!('Rest Json', 'Rails Json')
  text.gsub!("use aws.api#service\n", '')
  text.gsub!("use aws.auth#sigv4\n", '')

  text.gsub!("@sigv4(name: \"restjson\")\n", '')

  # make test id unique
  text.gsub!(/id: "(?!RailsJson)/, 'id: "RailsJson')

  # TODO: snake casing the body and uri paths

  File.open(file, 'w') { |f| f.puts text }
end
