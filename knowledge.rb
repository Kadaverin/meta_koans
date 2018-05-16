def attribute(*attr_names, &block)
  attr_names.each do |atr|
    default_val = nil
    atr, default_val = atr.to_a.first if atr.is_a? Hash

    define_method("#{atr}=") { |value| instance_variable_set("@#{atr}", value) }

    define_method("#{atr}") do
      return instance_variable_get("@#{atr}") if instance_variable_defined?("@#{atr}")
      instance_variable_set("@#{atr}", block ? instance_eval(&block) : default_val)
    end

    define_method("#{atr}?") { !!send(atr) }
  end
end
