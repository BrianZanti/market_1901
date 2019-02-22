require 'minitest/autorun'
require 'minitest/pride'
require './lib/vendor'

class VendorTest < Minitest::Test
  def test_it_exists
    vendor = Vendor.new("Rocky Mountain Fresh")
    assert_instance_of Vendor, vendor
  end

  def test_it_has_a_name
    vendor = Vendor.new("Rocky Mountain Fresh")
    assert_equal "Rocky Mountain Fresh", vendor.name
  end

  def test_inventory_starts_as_empty_hash
    vendor = Vendor.new("Rocky Mountain Fresh")
    assert_equal ({}), vendor.inventory
  end

  def test_check_stock_returns_0_by_default
    vendor = Vendor.new("Rocky Mountain Fresh")
    assert_equal 0, vendor.check_stock("Peaches")
  end

  def test_we_can_stock_items
    vendor = Vendor.new("Rocky Mountain Fresh")
    vendor.stock("Peaches", 30)
    vendor.stock("Peaches", 25)

    assert_equal 55, vendor.check_stock("Peaches")
  end

  def test_the_inventory_is_updated_after_stocking
    vendor = Vendor.new("Rocky Mountain Fresh")
    vendor.stock("Peaches", 30)
    vendor.stock("Peaches", 25)
    vendor.stock("Tomatoes", 12)
    expected = {"Peaches"=>55, "Tomatoes"=>12}
    assert_equal expected, vendor.inventory
  end

  def test_it_can_sell_items_from_stock
    vendor = Vendor.new("Rocky Mountain Fresh")
    vendor.stock("Peaches", 30)
    vendor.sell("Peaches", 5)
    assert_equal 25, vendor.check_stock("Peaches")
  end

  def test_it_doesnt_sell_more_than_its_stock
    vendor = Vendor.new("Rocky Mountain Fresh")
    vendor.stock("Peaches", 30)
    vendor.sell("Peaches", 50)
    assert_equal 0, vendor.check_stock("Peaches")
  end

  def test_it_doesnt_sell_if_it_has_no_stock
    vendor = Vendor.new("Rocky Mountain Fresh")
    vendor.sell("Peaches", 50)
    assert_equal 0, vendor.check_stock("Peaches")
  end

  def test_sell_returns_amount_not_sold
    vendor = Vendor.new("Rocky Mountain Fresh")
    vendor.stock("Peaches", 30)
    assert_equal 20, vendor.sell("Peaches", 50)

    vendor.stock('Tomatoes', 10)
    assert_equal 0, vendor.sell("Tomatoes", 5)
  end
end
