set :application, 'lazlo-web'
set :repo_url, 'git@gitlab.com:agrimbautomas/lazlo-web-rails.git'

set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', 'key', 'certificates', 'challenge')

set :keep_releases, 2
set :rvm_ruby_version, '2.5.1'