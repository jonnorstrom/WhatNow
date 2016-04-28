$(document).ready(function(){
  $('#login').on('click', function(){
    $('.login').removeClass('hidden');
  });

  $('#register').on('click', function(){
    $('.register').removeClass('hidden');
  });

  // signing in/up handler
  $('.register, .login').on('submit', function(e){

    var $form = $(this);
    var request = $.ajax({
      url: $form.attr('action'),
      method: $form.attr('method'),
      data: $form.serialize()
    });
  });
});
