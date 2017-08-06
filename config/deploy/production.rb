role :app, %w{deploy@macain.com.ar}
role :web, %w{deploy@macain.com.ar}
role :db,  %w{deploy@macain.com.ar}

set :deploy_to, '/srv/rails/macain-web'

server 'macain.com.ar', user: 'deploy', roles: %w{web app}, my_property: :my_value
set :rails_env, 'production'

set :branch, 'production'

namespace :deploy do
  after :updated, "assets:precompile"
end

namespace :assets do
  desc "Precompile assets locally and then rsync to web servers"
  task :precompile do
    on roles(:web) do
      rsync_host = host.to_s # this needs to be done outside run_locally in order for host to exist
      run_locally do
        with rails_env: fetch(:stage) do
          execute :bundle, "exec rake assets:precompile"
        end
        execute "rsync -av --delete ./public/assets/ #{fetch(:user)}@#{rsync_host}:#{shared_path}/public/assets/"
        execute "rm -rf public/assets"
      end
    end
  end
end

