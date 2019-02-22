class Vendor
  attr_reader :name,
              :inventory

  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end

  def check_stock(item)
    @inventory[item]
  end

  def stock(item, quantity)
    @inventory[item] += quantity
  end

  def sell(item, quantity)
    if check_stock(item) < quantity
      quantity -= check_stock(item)
      @inventory[item] = 0
      return quantity
    else
      @inventory[item] -= quantity
      return 0
    end
  end
end
