class Drink
  attr_reader :name, :value, :count
  def initialize name,value,count
    @name = name
    @value = value
    @count = count
  end

  def self.cora
    Drink.new('コーラ',120,5)
  end

  def self.redbull
    Drink.new('レッドブル',200,5)
  end
  
  def self.water
    Drink.new('水',100,5)
  end

  def self.oden
    Drink.new('おでん',200,3)
  end
end