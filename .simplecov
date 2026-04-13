# frozen_string_literal: true

SimpleCov.formatter = SimpleCov::Formatter::SimpleFormatter

SimpleCov.start do
  track_files 'gem/lib/**/*.rb'
  add_filter %w[/test/]
  enable_coverage :branch
  command_name(ENV.fetch('COMMAND_NAME', ''))
end
