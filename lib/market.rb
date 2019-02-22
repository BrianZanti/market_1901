require 'pry'
class Market
  attr_reader :name,
              :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.check_stock(item) > 0
    end
  end

  def sorted_item_list
    items = @vendors.map do |vendor|
      vendor.inventory.keys
    end
    items.flatten.sort.uniq
  end

  def total_inventory
    # total = Hash.new(0)
    # sorted_item_list.each do |item|
    #   @vendors.each do |vendor|
    #     total[item] += vendor.check_stock(item)
    #   end
    # end
    # return total
    total = Hash.new(0)
    sorted_item_list.inject(total) do |total, item|
      @vendors.each do |vendor|
         total[item] += vendor.check_stock(item)
      end
      total
    end
  end

  def sell(item, quantity)
    if total_inventory[item] < quantity
      return false
    else
      @vendors.each do |vendor|
        quantity = vendor.sell(item, quantity)
      end
      return true
    end
  end
end
