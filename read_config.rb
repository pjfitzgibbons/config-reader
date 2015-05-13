#!/usr/bin/env ruby

require './lib/config_reader'

if file = ARGV[0]
  body = open(file, 'r').read
else
  body = $stdin.read
end

config = ConfigReader.new(body)

puts config.config