require 'spec_helper'
require_relative '../../../lib/judopay/core_ext/hash'

describe Hash do
  it 'should convert hash keys to camel case' do
    original = {
      'under_score' => 123,
      'more_words_please' => 'value'
    }
    expected_result = {
      'underScore' => 123,
      'moreWordsPlease' => 'value'
    }
    expect(original.camel_case_keys!).to eq(expected_result)
  end

  it 'should convert a hash to a valid query string' do
    original = {
      'under_score' => 123,
      'more_words_please' => 'value'
    }
    expect(original.to_query_string).to eq('more_words_please=value&under_score=123')
  end
end
