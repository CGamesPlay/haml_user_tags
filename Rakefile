require "bundler/gem_tasks"
require 'cucumber/rake/task'

task :site => 'site:publish'
namespace :site do
  desc "Build web site and commit to gh-pages"
  task :publish do
    `git diff --exit-code && git diff --cached --exit-code`
    unless $?.success?
      warn "Publish the site from a clean working directory"
      raise "Exiting"
    end
    local_commit = `git rev-parse HEAD`
    cmd = [
      'cd site',
      'stasis',
      'cd ..',
      "( [ -d publish ] || git clone -sn --branch gh-pages #{File.dirname __FILE__} publish )",
      'cp -R site/public/ publish',
      'cd publish',
      'git add -A .',
      "git commit -m 'Exported site from #{local_commit}'",
      'git push origin gh-pages'
    ].join " &&\n"
    `#{cmd}`
  end

  desc "Spawn a local server for the site"
  task :dev do
    pid = spawn "cd site && ( stasis -d & python -m SimpleHTTPServer )"
    begin
      Process.wait pid
    rescue Interrupt
      Process.kill pid
    end
  end

  task :default => :publish
end

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format pretty"
end

task :default => :features
