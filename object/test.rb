 
# ��
# irb
# require �e/Users/shibatadaiki/work_shiba/full_stack/sample.rb�f
# �i���̃p�X�́A�����̔��@�t�@�C���������Ă���p�X���w�肷��j
# �����ݒ�i�����̔��@�C���X�^���X���쐬���āAvm�Ƃ����ϐ��ɑ������j
# vm = VendingMachine.new
# �쐬���������̔��@��100�~������
# vm.slot_money (100)
# �쐬���������̔��@�ɓ��ꂽ�����������炩���m�F����i�\������j
# vm.current_slot_money
# �쐬���������̔��@�ɓ��ꂽ������Ԃ��Ă��炤
# vm.return_money
class VendingMachine
  # �X�e�b�v�O�@�����̓����ƕ����߂��̗�R�[�h
  # �X�e�b�v�P�@�����Ȃ������̗�R�[�h
  # 10�~�ʁA50�~�ʁA100�~�ʁA500�~�ʁA1000�~�D���P�������ł���B
  MONEY = [10, 50, 100, 500, 1000].freeze
  # �i�����̔��@�ɓ������ꂽ���z���C���X�^���X�ϐ��� @slot_money �ɑ������j
  def initialize
    # �ŏ��̎����̔��@�ɓ����Ă�����z��0�~
    # @name = []
    @total_amount = 0
    @slot_money = 0
    @cora = {name:"�R�[��",value:120,count:5}
    @redbull = {name: "���b�h�u��", value: 200, count: 5}
    @water = {name: "��", value: 100, count: 5}

    # @select_drink = []
    @select_drink << {
      cora: {name:'�R�[��',value: 120, count: 5},
      redbull: {name:'���b�h�u��', value: 200, count: 5}
    }
  end

  def stock_list
    # @name << @cora
    # @name << @redbull
    # @name << @water
    @list = []
    @select_drink.each do |list|
    if purchase_decision == '�w���\'
      @list << list[0][:name]
    end
   end
   p @list
  end
  # �������z�̑��v���擾�ł���B
  def current_slot_money
    # �����̔��@�ɓ����Ă��邨����\������
    @slot_money
  end
  # 10�~�ʁA50�~�ʁA100�~�ʁA500�~�ʁA1000�~�D���P�������ł���B
  # �����͕�����ł���B
  def slot_money(money)
    # �z��O�̂��́i�P�~�ʂ�T�~�ʁB��~�D�ȊO�̂��D�A����������������Ȃ����́i�����ȊO�̂��́j�Ȃǁj
    # ���������ꂽ�ꍇ�́A�������z�ɉ��Z�����A��������̂܂ܒނ�K�Ƃ��ă��[�U�ɏo�͂���B
    return false unless MONEY.include?(money)
    # �����̔��@�ɂ���������
    @slot_money += money
    puts "#{@slot_money}�~�A�������܂����B"
  end
  # �����߂�������s���ƁA�������z�̑��v��ނ�K�Ƃ��ďo�͂���B
  def return_money
    # �Ԃ������̋��z��\������
    puts "���ނ��#{@slot_money}�~�ł��B"
    # �����̔��@�ɓ����Ă��邨����0�~�ɖ߂�
    @slot_money = 0
  end
  def juice_manage
    puts "#{@select_drink[:cora][:name]}��#{@select_drink[:cora][:value]}�~�A�c��#{@select_drink[:cora][:count]}�{�ł��B"
  end

  def purchase_decision
    if @select_drink[:cora][:count] == 0      
      "�݌ɐ؂�"
    elsif @select_drink[:cora][:value] > @slot_money
      "���z�s��"
    else
      "�w���\"
    end
  end
  def juice_buy
    if purchase_decision == "�w���\"
      @select_drink[:cora][:count] -= 1
      @total_amount = @total_amount + @select_drink[:cora][:value]
      reduce_money(@select_drink[:cora][:value])
      puts "�͂��A#{@select_drink[:cora][:name]}����B"
    elsif purchase_decision == "�݌ɐ؂�"
      purchase_decision
    elsif purchase_decision == "���z�s��"
      purchase_decision
    #   @total = @total + select_drink[:value]
    #   select_drink[:count] -= 1
    #   puts "�͂��A#{select_drink[:name]}����B"
    # else
    #   juice_jude(drink)
    # end
    # if current_slot_money >= 0
    #   puts "#{current_slot_money}�~�̂��ނ�ł��B"
    end
  end
  def sale_amount
    puts "���������#{@total_amount}�~�ł��B"
  end
  
  def reduce_money(i)
    @slot_money -= i
  end
 
end

vm = VendingMachine.new
 vm.juice_manage

 vm.slot_money(500)

 vm.juice_buy

 vm.sale_amount

 vm.return_money

 vm.stock_list
 

 