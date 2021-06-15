require 'rubygems'
require 'sitemap_generator'

SitemapGenerator::Sitemap.default_host = 'https://lazlo.boutique'
SitemapGenerator::Sitemap.create_index = false
SitemapGenerator::Sitemap.compress = :all_but_first
#SitemapGenerator::Sitemap.public_path = "#{Dir.pwd}/public/"

SitemapGenerator::Sitemap.create do
  # Auth needed excluded 
	# add '/cart', :changefreq => 'monthly', :priority => 0.3
  # add '/profile', :changefreq => 'monthly', :priority => 0.3
  add '/users/sign_in', :changefreq => 'monthly', :priority => 0.3
  add '/users/sign_up', :changefreq => 'monthly', :priority => 0.3
  Category.find_each do |category|
	 add category_path(category), :lastmod => category.updated_at, :changefreq => 'monthly', :priority => 0.9
  end
  Product.visible.find_each do |product|
	 add product_path(product), :lastmod => product.updated_at, :changefreq => 'weekly', :priority => 0.6
  end
end
