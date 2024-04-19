# Convert RestJson to RailsJson

require 'fileutils'

FileUtils.rm_rf 'protocol-test/services'

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

  File.open(file, "w") { |f| f.puts text }
end


