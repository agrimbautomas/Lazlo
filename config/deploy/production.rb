role :app, %w{deploy@macain.com.ar}
role :web, %w{deploy@macain.com.ar}
role :db,  %w{deploy@macain.com.ar}

set :deploy_to, '/srv/rails/macain-web'

server 'macain.com.ar', user: 'deploy', roles: %w{web app}, my_property: :my_value
set :rails_env, 'production'

set :branch, 'production'
