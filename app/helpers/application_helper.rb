module ApplicationHelper

  def active_class(link_path)
    current_page?(link_path) ? "active" : ""
  end

  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end


  # Fixes nested attribute params for strong_parameters (turns string keyed hash
  # into array of hashes)
  def repair_nested_params(obj = params)
    obj.each do |key, value|
      if value.is_a? Hash
        # If any non-integer keys
        if value.keys.find {|k, _| k =~ /\D/ }
          repair_nested_params(value)
        else
          obj[key] = value.values
          value.values.each {|h| repair_nested_params(h) }
        end
      end
    end
  end


end
