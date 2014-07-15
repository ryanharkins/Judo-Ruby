class String
  # Convert to camel case
  #
  #   "foo_bar".camel_case          #=> "fooBar"
  def camel_case
    return self if self !~ /_/ && self =~ /[A-Z]+.*/
    split('_').map { |e| e.capitalize }.join.uncapitalize
  end

  # Convert first letter to lower case
  #
  #   "BananaMan".uncapitalize      #=> "bananaMan"
  def uncapitalize
    self[0, 1].downcase + self[1..-1]
  end

  # Converts a camel_cased string to a underscored string
  # Replaces spaces with underscores, and strips whitespace
  #
  #   "BananaMan".underscore        #=> "banana_man"
  def underscore
    to_s.strip
      .gsub(' ', '_')
      .gsub(/::/, '/')
      .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
      .gsub(/([a-z\d])([A-Z])/, '\1_\2')
      .tr('-', '_')
      .squeeze('_')
      .downcase
  end
end
