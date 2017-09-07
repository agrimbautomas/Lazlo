role :app, %w{deploy@alomacain.com}
role :web, %w{deploy@alomacain.com}
role :db,  %w{deploy@alomacain.com}

set :deploy_to, '/srv/rails/macain-web'

server 'alomacain.com', user: 'deploy', roles: %w{web app}, my_property: :my_value

set :rails_env, 'production'
set :branch, 'production'
