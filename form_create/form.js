// DOMの読み込みが終わったらfunction()の中の処理を実行します。
$(document).ready(function(){
  $(".c_send").on("click",function(){
    alert("thanks for your letter!!!")
  })
  $('.c_send').on('click', function() {
	rocketcss(this,'.logo_image', 'rocketPulse');
	$('.logo_image').addClass('targetPulse');
});
});
