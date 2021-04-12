 
# 例
# irb
# require ‘/Users/shibatadaiki/work_shiba/full_stack/sample.rb’
# （↑のパスは、自動販売機ファイルが入っているパスを指定する）
# 初期設定（自動販売機インスタンスを作成して、vmという変数に代入する）
# vm = VendingMachine.new
# 作成した自動販売機に100円を入れる
# vm.slot_money (100)
# 作成した自動販売機に入れたお金がいくらかを確認する（表示する）
# vm.current_slot_money
# 作成した自動販売機に入れたお金を返してもらう
# vm.return_money
class VendingMachine
  # ステップ０　お金の投入と払い戻しの例コード
  # ステップ１　扱えないお金の例コード
  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  MONEY = [10, 50, 100, 500, 1000].freeze
  # （自動販売機に投入された金額をインスタンス変数の @slot_money に代入する）
  def initialize
    # 最初の自動販売機に入っている金額は0円
    # @name = []
    @total_amount = 0
    @slot_money = 0
    @cora = {name:"コーラ",value:120,count:5}
    @redbull = {name: "レッドブル", value: 200, count: 5}
    @water = {name: "水", value: 100, count: 5}

    # @select_drink = []
    @select_drink << {
      cora: {name:'コーラ',value: 120, count: 5},
      redbull: {name:'レッドブル', value: 200, count: 5}
    }
  end

  def stock_list
    # @name << @cora
    # @name << @redbull
    # @name << @water
    @list = []
    @select_drink.each do |list|
    if purchase_decision == '購入可能'
      @list << list[0][:name]
    end
   end
   p @list
  end
  # 投入金額の総計を取得できる。
  def current_slot_money
    # 自動販売機に入っているお金を表示する
    @slot_money
  end
  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  # 投入は複数回できる。
  def slot_money(money)
    # 想定外のもの（１円玉や５円玉。千円札以外のお札、そもそもお金じゃないもの（数字以外のもの）など）
    # が投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
    return false unless MONEY.include?(money)
    # 自動販売機にお金を入れる
    @slot_money += money
    puts "#{@slot_money}円、投入しました。"
  end
  # 払い戻し操作を行うと、投入金額の総計を釣り銭として出力する。
  def return_money
    # 返すお金の金額を表示する
    puts "お釣りは#{@slot_money}円です。"
    # 自動販売機に入っているお金を0円に戻す
    @slot_money = 0
  end
  def juce_manage
    puts "#{@select_drink[:cora][:name]}は#{@select_drink[:cora][:value]}円、残り#{@select_drink[:cora][:count]}本です。"
  end

  def purchase_decision
    if @select_drink[:cora][:count] == 0      
      "在庫切れ"
    elsif @select_drink[:cora][:value] > @slot_money
      "金額不足"
    else
      "購入可能"
    end
  end
  def juce_buy
    if purchase_decision == "購入可能"
      @select_drink[:cora][:count] -= 1
      @total_amount = @total_amount + @select_drink[:cora][:value]
      reduce_money(@select_drink[:cora][:value])
      puts "はい、#{@select_drink[:cora][:name]}だよ。"
    elsif purchase_decision == "在庫切れ"
      purchase_decision
    elsif purchase_decision == "金額不足"
      purchase_decision
    #   @total = @total + select_drink[:value]
    #   select_drink[:count] -= 1
    #   puts "はい、#{select_drink[:name]}だよ。"
    # else
    #   juce_jude(drink)
    # end
    # if current_slot_money >= 0
    #   puts "#{current_slot_money}円のお釣りです。"
    end
  end
  def sale_amount
    puts "総売上金は#{@total_amount}円です。"
  end
  
  def reduce_money(i)
    @slot_money -= i
  end
 
end

vm = VendingMachine.new
 vm.juce_manage

 vm.slot_money(500)

 vm.juce_buy

 vm.sale_amount

 vm.return_money

 vm.stock_list
 

 