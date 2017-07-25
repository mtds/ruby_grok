#!/usr/bin/env ruby

#
# Test Grok filter patterns (one or more) against a log file.
#
# ver. 0.2

# The skeleton base of this program came from:
# https://github.com/jordansissel/ruby-grok/blob/master/examples/test.rb

# So the idea is simple:
# ---------------------
# 1. Read every input line from the log file.
# 2. Read an array of patterns from a file.
# 3. Iterate through the log lines, applying the pattern rules one by one,
#    until we'll have a match (or not at all) and then shows the results.

require "rubygems"
require "grok-pure"
require "pp"

# Create a new instance for the filter.
grok = Grok.new

# **NOTE**: if you don't add all the pattern files used by your filter
#           Grok will raise an exception, due to the lack of defined 
#           base types used by your patterns.
#
# Example:  In your pattern you have used a regex which is included only
#           in another pattern file, not declared with grok.add_patterns(..).

#
# Load some default patterns: those are shipped usually with the Grok gem
# included with Logstash.
#
# Add as many patterns as you want, using the following directives.
grok.add_patterns_from_file("./patterns/grok-patterns")
grok.add_patterns_from_file("./patterns/linux-syslog")

# Read the log file name as the first command line argument:
logfile = ARGV.first

# Check if there's an argument:
if ARGV.empty?
  puts "Usage: grok_test.rb /path/test/logfile /path/pattern/file"
  puts "Pattern file example: %{SYSLOGBASE} (multiple patterns per line and/or multiple lines are allowed)"
  exit
end

# Empty array for the patterns:
patterns = []

# Read the patterns file name as the second cmd line argument:
patterns_file = ARGV[1]

# Check the length of ARGV:
unless ARGV.length == 2
  puts "Give me also the pattern file"
  exit
end

# Read the list of patterns to be applied on the logs from the file:
open(patterns_file, "r").each do |line|
  patterns << line.split('\n')[0] 
end

# Read the log file line by line:
File.open(logfile, "r").each_line do |input_line|
 patterns.length.times do |i|
  grok.compile(patterns[i].chomp)
  match = grok.match(input_line)
     if match
	puts "-----------"
	puts "Match found:"
	puts "-----------"
	pp match.captures
	puts
     else
	puts "------------------"
	puts "No match was found with #{patterns[i].chomp} for the log msg: #{input_line}"
	puts "------------------"
	puts
     end
 end
end
