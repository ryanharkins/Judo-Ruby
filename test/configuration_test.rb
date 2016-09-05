require 'test/unit'
require_relative '../lib/judopay'
require_relative '../lib/judopay/error'

class ConfigurationTest < Test::Unit::TestCase
  # Fixture information.
  def setup
    @data = [
      ['', 'MYTOKEN', 'MYSECRET'],
      [nil, 'MYTOKEN', 'MYSECRET'],
      ['MYJUDOID', '', 'MYSECRET'],
      ['MYJUDOID', nil, 'MYSECRET'],
      ['MYJUDOID', 'MYTOKEN', ''],
      ['MYJUDOID', 'MYTOKEN', nil]
    ]
  end

  def test_invalid_configuration
    @data.each do |params|
      config = Judopay::Configuration.new
      config.judo_id, config.api_token, config.api_secret = params

      assert_raise(Judopay::ValidationError.new('SDK configuration variables missing')) { config.validate }
    end
  end

  def test_valid_configuration
    config = Judopay::Configuration.new
    config.judo_id = 'MYJUDOID'
    config.api_token = 'MYTOKEN'
    config.api_secret = 'MYSECRET'

    assert_true(config.validate)
  end
end
