require_relative '../lib/acme.rb'
require 'minitest/autorun'

class AcmeTest < MiniTest::Unit::TestCase

  def test_find_alices
    assert_equal 87, Acme.find("alice").size
  end

end
