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
      @slot_money = 0
      # 合計売り上げの初期値
      @total = 0
      # 各ドリンクの初期状態
      @drink1 = {name:"コーラ",value:250,count:5,omake:0}
      @drink2 = {name:"レッドブル",value:400,count:5,omake:0}
      @drink3 = {name:"水",value:200,count:5,omake:0}
      @omake_ticket = []
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
    end
    # 払い戻し操作を行うと、投入金額の総計を釣り銭として出力する。
    def return_money
      # 返すお金の金額を表示する
      puts "#{@slot_money}円のお返しです。"
      # 自動販売機に入っているお金を0円に戻す
      @slot_money = 0
    end
    # 在庫チェックメソッド
    def drink_buy?
      puts "現在の投入金額：#{@slot_money}円"
      puts "#-------------------購入可能リスト-----------------------#"
      [@drink1,@drink2,@drink3].each do |select_drink|
        if select_drink[:count] > 0 && select_drink[:value] <= @slot_money
          puts "#{select_drink[:name]}は#{select_drink[:value]}円、残り#{select_drink[:count]}本です。"
        end
      end
      puts "#--------------------------------------------------------#"
    end
    # def to_s(name,price)
    #     "<Drink: name=#{name}, price=#{price}>"
    # end
    # ジュースが購入可能か判断するメソッド
    def drink_dicision(drink)
      select_drink = drink_select(drink)
      if select_drink[:count] > 0 && current_slot_money >= select_drink[:value]
        "購入可能"
      elsif select_drink[:count] == 0
        "売り切れ"
      elsif current_slot_money < select_drink[:value]
        "金額不足"
      end
    end
    # ジュースが購入可能なら購入するメソッド
    def drink_buy(drink)
      select_drink = drink_select(drink)
      if drink_dicision(drink) == "購入可能"
        heruheru(select_drink[:value])
        @total = @total + select_drink[:value]
        select_drink[:count] -= 1
        puts "はい、#{select_drink[:name]}だよ。"
        if omake == 1
          omake_drink = [@drink1,@drink2,@drink3].sample
          if omake_drink[:count] > 0
            puts "大当たり！！おまけの#{omake_drink[:name]}だよ。"
            omake_drink[:count] -= 1
            omake_drink[:omake] += 1
          else
            number = rand(10000..99999)
            puts "対象商品が売り切れのため、ドリンク引換券「#{omake_drink[:name]}No.#{number}」を発行します。後日、ご利用ください。"
            @omake_ticket << number
          end
        end
        if current_slot_money >= 0
          return_money
        end
      else
        drink_dicision(drink)
      end
    end

    def heruheru(i)
      @slot_money -= i
    end
    def total_return
      puts "現在の売り上げは#{@total}円です。"
    end
    def stock_add(drink,add)
      select_drink = drink_select(drink)
      select_drink[:count] += add
    end
    #ランダムで購入する
    def rand_buy
      rand_drink = ["コーラ","レッドブル","水"].sample
      drink_buy(rand_drink)
    end
    #おまけのルーレット用乱数作成メソッド
    def omake
      (1..3).to_a.sample
    end
    #内部的に管理するためのメソッド
    def manage
      puts "現在の総売上：#{@total}円"
      puts "#-------------------購入可能リスト-----------------------#"
      [@drink1,@drink2,@drink3].each do |select_drink|
        puts select_drink
      end
      p @omake_ticket
      puts "#--------------------------------------------------------#"
    end
   def irekae(from_drink,to_drink,to_value,to_count)
      @selected_drink = drink_select(from_drink)
      @selected_drink[:name] = to_drink
      @selected_drink[:value] = to_value
      @selected_drink[:count] = to_count
  end
    private
    # ジュースを内部的に判別するメソッド
    def drink_select(drink)
      if drink == @drink1[:name]
        @drink1
      elsif drink == @drink2[:name]
        @drink2
      elsif drink == @drink3[:name]
        @drink3
      else
        puts "現在、実装されておりません。"        
      end
    end    
  end

# インスタンス代入
vm = VendingMachine.new
# 500円投入
vm.slot_money(500)
# 現在のお金確認
p vm.current_slot_money

#ジュースの在庫追加
#vm.stock_add("コーラ",10)

# 現在のジュース情報取得
vm.drink_buy?
# ジュースが買えるかどうか確認(trueの場合)
p vm.drink_dicision("水")
# お金減らすよん
# vm.heruheru(400)

#ジュース購入
vm.drink_buy("水")
#売り上げ確認
vm.total_return
#お釣りだす機能
# vm.return_money

# vm.stock_add("コーラ",3)
# vm.slot_money(500)
# vm.drink_buy?

# vm.rand_buy


vm.manage

vm.irekae("コーラ","コーヒー","150","4")

vm.manage
