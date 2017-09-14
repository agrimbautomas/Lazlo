set :application, 'macain-web'
set :repo_url, 'git@gitlab.com:agrimbautomas/macain-web-rails.git'

set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets',
                                               'vendor/bundle', 'public/system', 'key', 'certificates', 'challenge')
set :keep_releases, 3
set :rvm_ruby_version, '2.4.0'