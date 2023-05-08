# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/test_*.rb"]
end

require "rubocop/rake_task"

RuboCop::RakeTask.new

task default: %i[test rubocop]

namespace "gem" do
  desc "Build a gem package"
  task :build do
    sh "gem build goldman.gemspec"
  end

  desc "Push a gem package"
  task :push do
    Rake::Task["gem:build"].execute
    sh "gem push goldman-#{Goldman::VERSION}.gem"
  end

  desc "Clean built gem packages"
  task :clean do
    sh "rm goldman-*.gem"
  end
end
