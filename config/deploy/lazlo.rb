role :app, %w{deploy@lazlo.la}
role :web, %w{deploy@lazlo.la}
role :db,  %w{deploy@lazlo.la}

set :deploy_to, '/srv/rails/lazlo-beta-web'

server 'lazlo.la', user: 'deploy', roles: %w{web app}, my_property: :my_value

set :rails_env, 'staging'
set :branch, 'lazlo'
