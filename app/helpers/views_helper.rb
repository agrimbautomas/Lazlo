module ViewsHelper

  def capitalize_first_letters text
	 text.split.map(&:capitalize)*' '
  end

end
