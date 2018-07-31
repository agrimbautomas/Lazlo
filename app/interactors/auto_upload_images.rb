class AutoUploadImages < Interactor

	def self.upload_from_dir dir
		auto_upload_images = new dir: dir
		auto_upload_images.execute
	end

	def execute
		@images = Dir.glob(["#{dir}/*.jpg", "#{dir}/*.png", "#{dir}/*.gif"])

		if @images.present?
			add_images_by_model model: SiteConfig, image_method: :picture
			add_images_by_model model: Category, image_method: :image
			add_images_by_model model: Product, image_method: :image
			add_images_by_model model: ProductImage, image_method: :picture
		else
			console_log "No images found in #{dir}"
		end
	end

	def add_images_by_model model:, image_method:
		model.find_each do |model_instance|
			set_attachment model_instance, image_method
		end
	end

	def set_attachment model_instance, image_method
		if !model_instance.try(image_method).exists?
			update_images_count
			img_file = File.open(@images[@i])
			model_instance.update(image_method => img_file)
			model_instance.save!
			img_file.close
		end
	end

	def count
		@i ||= -1
		@i += 1
	end

	def update_images_count
		count
		if @images[@i].nil?
			@i = 0
		end
	end

	def console_log message
		Rails.logger = Logger.new(STDOUT)
		puts message
	end
end