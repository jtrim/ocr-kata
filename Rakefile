require 'pathname'
require 'bundler'

Bundler.require

$:.unshift Pathname.new(File.dirname(__FILE__)).join('lib').to_s

require 'character_reader'

begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec)

  task :default => :spec
rescue LoadError
  # no rspec available
end

task :console do
  pry
end

task :generate_valid_account_numbers_file do
  numbers = 10000.times.lazy.map { rand(1000000000).to_s.rjust(9, "0") }.lazy
  valid_numbers = numbers.select { |n| CharacterReader::AccountNumberChecksum.new(n).valid? }.take(30).force
  invalid_numbers = numbers.reject { |n| CharacterReader::AccountNumberChecksum.new(n).valid? }.take(10).force

  open(Pathname.new(File.dirname(__FILE__)).join('doc/example_account_numbers.txt'), 'w') do |f|
    f.puts (valid_numbers + invalid_numbers).shuffle.map { |n| CharacterReader::String.create(n) }.join("\n")
  end
end

task :validate_account_numbers_file do
  path = ENV["ACCOUNT_NUMBERS_FILE"] || "doc/example_account_numbers.txt"

  document = CharacterReader::AccountNumberDocument.new(File.read(path))

  puts document.valid_account_numbers + document.invalid_account_numbers.map { |entry| "#{entry.first.ljust(9, " ")} #{entry.last}" }
end
