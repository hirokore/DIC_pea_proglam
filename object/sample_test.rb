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
      @cora = {name:"コーラ",value:120,count:5}
      @redblue = {name:"レッドブル",value:200,count:5}
      @water = {name:"水",value:100,count:5}
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
    def juce_manage
      puts "#-------------------購入可能リスト-----------------------#"
      [@cora,@redblue,@water].each do |select_drink|
        if select_drink[:count] > 0
          puts "#{select_drink[:name]}は#{select_drink[:value]}円、残り#{select_drink[:count]}本です。"
        end
      end
      puts "#--------------------------------------------------------#"
    end
    # def to_s(name,price)
    #     "<Drink: name=#{name}, price=#{price}>"
    # end
    # ジュースが購入可能か判断するメソッド
    def juce_jude(drink)
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
    def juce_buy(drink)
      select_drink = drink_select(drink)
      if juce_jude(drink) == "購入可能"
        heruheru(select_drink[:value])
        @total = @total + select_drink[:value]
        select_drink[:count] -= 1
        puts "はい、#{select_drink[:name]}だよ。"
      else
        juce_jude(drink)
      end
      if current_slot_money >= 0
        puts "#{current_slot_money}円のお釣りです。"
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
    private
    # ジュースを内部的に判別するメソッド
    def drink_select(drink)
      if drink == "コーラ"
        @cora
      elsif drink == "レッドブル"
        @redblue
      elsif drink == "水"
        @water
      else
        puts "現在、実装されておりません。"        
      end
    end
  end

# インスタンス代入
vm = VendingMachine.new
# 500円投入
vm.slot_money(100)
# 現在のお金確認
p vm.current_slot_money

#ジュースの在庫追加
#vm.stock_add("コーラ",10)

# 現在のジュース情報取得
vm.juce_manage
# ジュースが買えるかどうか確認(trueの場合)
p vm.juce_jude("水")
# お金減らすよん
# vm.heruheru(400)

#ジュース購入
vm.juce_buy("水")
#売り上げ確認
vm.total_return
#お釣りだす機能
# vm.return_money







##memo



# juce_manage.keys
# drink_count = juce_manage[:コーラ][:count]


# vm.heruheru(100)
# p vm.current_slot_money
