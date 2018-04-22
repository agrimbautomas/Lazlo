module ViewsHelper

  def capitalize_first_letters text
	 text.split.map(&:capitalize)*' '
  end

  def get_image_size column, size
	 if column == 1
		if size == 1
		  image_size = :rectangular4
		else
		  image_size = :rectangular3
		end

	 elsif column == 2
		if size == 1
		  image_size = :rectangular5
		else
		  image_size = :rectangular4
		end

	 elsif column == 3
		if size == 1
		  image_size = :rectangular6
		else
		  image_size = :rectangular5
		end
	 end

	 image_size
  end

end
