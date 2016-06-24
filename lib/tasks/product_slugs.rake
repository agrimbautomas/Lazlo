namespace :products do
  desc 'Generate Product Slugs'
  task :generate_slugs => :environment do
    Product.find_each(&:save)
  end
end
