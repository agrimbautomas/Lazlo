role :app, %w{deploy@lazlo.la}
role :web, %w{deploy@lazlo.la}
role :db, %w{deploy@lazlo.la}

set :deploy_to, '/srv/rails/lazlo-beta-web'

server 'lazlo.la', user: 'deploy', roles: %w{web app}

set :rails_env, 'staging'
set :branch, 'staging'
