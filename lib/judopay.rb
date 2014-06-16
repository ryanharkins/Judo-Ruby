require "judopay/version"
require File.expand_path('../judopay/api', __FILE__)
require File.expand_path('../judopay/payment', __FILE__)
require File.expand_path('../judopay/transaction', __FILE__)
require File.expand_path('../judopay/configuration', __FILE__)

module Judopay
  extend Configuration
end
