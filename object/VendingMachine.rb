  require './Drink.rb'

class VendingMachine

  # 10円玉、50円玉、100円玉、500円玉、1000円札を固定させた定数
  MONEY = [10, 50, 100, 500, 1000].freeze

  # インスタンス変数の定義
  def initialize
    @total_amount = 0
    @slot_money = 0
    @cora = {name: Drink.cora.name, value: Drink.cora.value,count: Drink.cora.count}
    @redbull = {name:Drink.redbull.name,value: Drink.redbull.value,count: Drink.redbull.count}
    @water = {name: Drink.water.name,value: Drink.water.value,count: Drink.water.count}
    @oden = {name: Drink.oden.name,value: Drink.oden.value,count: Drink.oden.count}
  end
  
  # drink補充機能
  def add_to_drink(drink,count)
    @add_drink = drink_select(drink)
    @add_drink[:count] += count
  end   

  # 投入金額の総計を取得できる機能
  def current_slot_money
    @slot_money
  end

  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる機能
  def slot_money(money)
    # 想定外のもの（１円玉や５円玉。千円札以外のお札、そもそもお金じゃないもの（数字以外のもの）など）
    # が投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
    return false unless MONEY.include?(money)
    # 自動販売機にお金を入れる
    @slot_money += money
    puts "#{@slot_money}円、投入しました。"
  end

  # 払い戻し操作を行うと、投入金額の総計を釣り銭として出力する機能
  def return_money
    # 返すお金の金額を表示する
    puts "お釣りは#{@slot_money}円です。"
    # 自動販売機に入っているお金を0円に戻す
    @slot_money = 0
  end

  # 購入可能drinkを表示する機能 
  def juice_manage
    # puts "#{@cora[:name]}は#{@cora[:value]}円、残り#{@cora[:count]}本です。"
    puts "#-------------------購入可能リスト-----------------------#"

    [@cora,@redbull,@water,@oden].each do |drink|
      if  drink[:count] > 0 && drink[:value] <= @slot_money        
       puts "#{drink[:name]}は#{drink[:value]}円、残り#{drink[:count]}本です。"
      end
    end
    puts "#--------------------------------------------------------#"
  end

  # ランダム購入機能
  def rand_buy
    rand_drink = ["コーラ","レッドブル","水","おでん"].sample
    juice_buy(rand_drink)
  end

  # drink購入の一連処理を行う機能
  def juice_buy(drink)
    @selected_drink = drink_select(drink)
    if purchase_decision(drink) == "購入可能"
      @selected_drink[:count] -= 1
      @total_amount += @selected_drink[:value]
      reduce_money(@selected_drink[:value])
      puts "はい、#{@selected_drink[:name]}だよ。"
      # お釣り出す
      return_money
    elsif purchase_decision(drink) == "在庫切れ"
      purchase_decision(drink)
    elsif purchase_decision(drink) == "金額不足"
      purchase_decision(drink)
    end
  end

  # 総合売り上げ金出力機能
  def sale_amount
    puts "総売上金は#{@total_amount}円です。"
  end
  
  private

  # 飲み物名を選択する機能
  def drink_select(drink)
    if drink == "コーラ"
      @cora
    elsif drink == "レッドブル"
      @redbull
    elsif drink == "水"
      @water
    elsif drink == "おでん"
      @oden
    else
      puts "現在、実装されておりません。"        
    end
  end 

  # ドリンクが買えるかどうかを判断する機能
  def purchase_decision(drink)
    @selected_drink = drink_select(drink)
    if @selected_drink[:count] == 0      
      "在庫切れ"
    elsif @selected_drink[:value] > @slot_money
      "金額不足"
    else
      "購入可能"
    end
  end

  # 自販機内でお金を減らす機能
  def reduce_money(i)
    @slot_money -= i
  end
end

vm = VendingMachine.new