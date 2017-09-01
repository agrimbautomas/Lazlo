# config valid only for current version of Capistrano
lock '3.7.1'

set :application, 'macain-web'
set :repo_url, 'git@bitbucket.org:agrimbautomas/macain-web-rails.git'

set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets',
                                               'vendor/bundle', 'public/system', 'key', 'certificates', 'challenge')
set :keep_releases, 3
