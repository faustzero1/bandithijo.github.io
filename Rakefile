task :default do
  puts 'Running CI tasks...'

  # Runs the jekyll build command for production
  # TravisCI will now have a site directory with our
  # statically generated files.
  sh('JEKYLL_ENV=production bundle exec jekyll build')
  puts('Jekyll successfully built!')
end

# For Development Evironment
namespace :jekyll do
  desc 'Menjalankan Jekyll pada Environment Development'
  task :server do
    sh('BUNDLE_GEMFILE=Gemfile-dev bundle exec jekyll s -l -H 0.0.0.0')
  end

  namespace :server do
    desc 'Menjalankan Jekyll pada Environment Development dengan --incremental --watch'
    task :inc do
      sh('BUNDLE_GEMFILE=Gemfile-dev bundle exec jekyll s -l -H 0.0.0.0 --incremental --watch')
    end
  end

  desc 'Push blog to repo source'
  task :push do
    sh('git push -u origin source; git push -u gitlab source')
  end
end
