role :app, %w{deploy@lazlo.boutique}
role :web, %w{deploy@lazlo.boutique}
role :db, %w{deploy@lazlo.boutique}

set :deploy_to, '/srv/rails/lazlo-web'

server 'lazlo.boutique', user: 'deploy', roles: %w{web app}

set :rails_env, 'production'
set :branch, 'production'

after 'deploy', 'sitemap:refresh'