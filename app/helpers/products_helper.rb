module ProductsHelper

  def format_price price
	 "$" + number_with_delimiter(price.to_i, :delimiter => ".", :separator => ",") unless price.nil?
  end
end
