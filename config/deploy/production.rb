role :app, %w{deploy@alomacain.com}
role :web, %w{deploy@alomacain.com}
role :db,  %w{deploy@alomacain.com}

set :deploy_to, '/srv/rails/macain-web'

server 'alomacain.com', user: 'deploy', roles: %w{web app}

set :rails_env, 'production'
set :branch, 'production'

# For sitemap_generator
set :sitemap_roles, :web # default