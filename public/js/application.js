$(document).ready(function(){
  $('#login').on('click', function(){
    $('.login').removeClass('hidden');
    $('.rogister').addClass('hidden');
  });

  $('#register').on('click', function(){
    $('.register').removeClass('hidden');
    $('.login').addClass('hidden');
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

  $('.mood-table').on('click', 'img', function(){
    var mood = $(this).attr('id');
  });
});
