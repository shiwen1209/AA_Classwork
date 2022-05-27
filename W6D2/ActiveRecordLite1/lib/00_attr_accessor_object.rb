class AttrAccessorObject
  def self.my_attr_accessor(*names)
    names.each {|name| define_method(name) {instance_variable_get("@#{name}".to_sym)} }  
    
    names.each do |name| 
        name2 = name.to_s + "="
        define_method(name2){|arg| instance_variable_set("@#{name}".to_sym, arg)}
    end
  end
end

