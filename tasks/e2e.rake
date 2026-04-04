# frozen_string_literal: true

require_relative '../test/e2e/helpers/e2e_app'

namespace :test do
  # Task for E2E tests only
  TaskHelper.def_test_task(:e2e, 'test/e2e/**/*_test.rb')

  namespace :e2e do
    E2eApp::APPS.each_key do |app|
      TaskHelper.def_test_task(app, "test/e2e/#{app}_test.rb")
    end

    desc 'Download external assets for E2E tests'
    task :download_assets do
      require 'open-uri'

      assets_path = Pagy::ROOT.join('../test/e2e/assets')
      puts "Asset directory: #{assets_path}"
      mkdir_p(assets_path)

      assets = {
        'tailwind.js'       => 'https://cdn.tailwindcss.com?plugins=forms,typography,aspect-ratio',
        'bootstrap.min.css' => 'https://cdn.jsdelivr.net/npm/bootstrap@5/dist/css/bootstrap.min.css',
        'bulma.min.css'     => 'https://cdn.jsdelivr.net/npm/bulma@1/css/bulma.min.css'
      }

      assets.each do |filename, url|
        puts "Downloading #{filename}..."
        # Open-URI's 'open' can be called directly on the string... not a security concern in this context
        content = URI.open(url).read # rubocop:disable Security/Open
        File.write("#{assets_path}/#{filename}", content)
      end
    end
  end
end
