require 'rake'

namespace :app do
	desc 'Add images for all resources'
	task :add_images => :environment do
		Rails.logger = Logger.new(STDOUT)
		AutoUploadImages.upload_from_dir 'site-images'
	end

end
