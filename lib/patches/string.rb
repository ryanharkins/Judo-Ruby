class String
  ##
  # Convert to camel case.
  #
  #   "foo_bar".camel_case          #=> "fooBar"
  #
  # @return [String] Receiver converted to camel case.
  #
  # @api public
  def camel_case
    return self if self !~ /_/ && self =~ /[A-Z]+.*/
    split('_').map{|e| e.capitalize}.join.uncapitalize
  end

  def uncapitalize 
    self[0, 1].downcase + self[1..-1]
  end  
end