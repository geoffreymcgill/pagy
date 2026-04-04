# frozen_string_literal: true

require 'json'

next_test = 'test/unit/pagy/next_test.rb'

namespace :test do
  # Task for Unit tests only (excluding next)
  TaskHelper.def_test_task(:unit, 'test/unit/**/*_test.rb', exclude: next_test)

  # Isolated task for Next only
  TaskHelper.def_test_task(:next, next_test)

  desc 'Test all units (unit and next)'
  task units: %i[unit next]

  task(:cov_env) { ENV['COVERAGE'] = 'true' } # rubocop:disable Rake/Desc

  desc 'Test all units and coverage'
  task coverage: %i[cov_env unit next] do
    path   = Pagy::ROOT.join('../coverage')
    result = JSON.parse(path.join('.last_run.json').read)['result']
    line   = result['line']
    branch = result['branch']

    next if [line, branch].all?(100)  # next ends the task here

    miss_pct = -> { format('%7.2f%%', -100 + _1) }
    warn <<~MISS

      >>> MISSING COVERAGE!
      #{">>> LINE:   #{miss_pct.(line)}" if line < 100}
      #{">>> BRANCH: #{miss_pct.(branch)}" if branch < 100}
      >>> Report: file://#{path.join('index.html')}
    MISS
    exit 2
  end
end
