require_relative '../model'
require_relative 'android_payment'

module Judopay
  class AndroidPreauth < AndroidPayment
    @resource_path = 'transactions/preauths'
  end
end
