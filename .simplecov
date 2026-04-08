# frozen_string_literal: true

SimpleCov.start do
  track_files 'gem/lib/**/*.rb'
  add_filter %w[/test/]
  command_name "##{$PROCESS_ID}"
  merge_timeout 30 unless ENV['CI']
  enable_coverage :branch
end
