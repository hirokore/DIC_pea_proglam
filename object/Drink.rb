class Drink
  # 外部から呼び出す設定
  attr_reader :name, :value, :count

  # 名前と価格と在庫数を定義
  def initialize name,value,count
    @name = name
    @value = value
    @count = count
  end

  # コーラの情報をインスタンス化するクラスメソッド
  def self.cora
    Drink.new('コーラ',120,5)
  end

  # レッドブルの情報をインスタンス化するクラスメソッド
  def self.redbull
    Drink.new('レッドブル',200,5)
  end
  
  # 水の情報をインスタンス化するクラスメソッド
  def self.water
    Drink.new('水',100,5)
  end

  # おでんの情報をインスタンス化するクラスメソッド
  def self.oden
    Drink.new('おでん',200,3)
  end
end