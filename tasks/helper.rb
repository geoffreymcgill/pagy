# frozen_string_literal: true

Rake.add_rakelib 'tasks'
require 'rake/testtask'

module TaskHelper
  module_function

  def def_test_task(name, pattern, exclude: nil) # accept also an array of excluded paths
    Rake::TestTask.new(name) do |t|
      t.libs = %w[gem/lib test]
      # Use FileList to allow for easy exclusion
      files = FileList[pattern]
      files.exclude(exclude) if exclude
      t.test_files = files
      t.warning    = true
    end

    # Directly prepend the print action to the task's execution list
    Rake::Task[name].actions.unshift(proc { puts "\nRunning #{_1.name}..." })
  end
end
