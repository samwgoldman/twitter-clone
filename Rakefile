require "rspec/core/rake_task"
RSpec::Core::RakeTask.new

require "cucumber/rake/task"
Cucumber::Rake::Task.new

desc 'Generate API request documentation from API specs'
RSpec::Core::RakeTask.new('docs:generate') do |t|
  t.pattern = 'spec/api/**/*_spec.rb'
  t.rspec_opts = ["--format RspecApiDocumentation::ApiFormatter"]
end

task :default => [:spec, :cucumber]
