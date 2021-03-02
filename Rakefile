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

    task :inc_draft do
      sh('BUNDLE_GEMFILE=Gemfile-dev bundle exec jekyll s -l -H 0.0.0.0 --incremental --watch --drafts')
    end
  end

  desc 'Push blog to repo source'
  task :push do
    sh('git push -u origin source; git push -u gitlab source')
    puts """
    d8888b.  .d88b.  d8b   db d88888b db
    88  `8D .8P  Y8. 888o  88 88'     88
    88   88 88    88 88V8o 88 88ooooo YP
    88   88 88    88 88 V8o88 88~~~~~
    88  .8D `8b  d8' 88  V888 88.     db
    Y8888D'  `Y88P'  VP   V8P Y88888P YP
    """
  end
end
