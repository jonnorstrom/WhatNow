var moods = { happy: ['Will Ferrell','Sandra Bullock','Adam Sandler'],
  sad: ['Classic Movies', 'Romance','Dramas'],
  shitty: ['Independent Movies','Thrillers','Faith & Spirtuality']
};

Array.prototype.sample = function(){
  return this[Math.floor(Math.random()*this.length)];
};

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
    var genre = moods[mood].sample();
    var data = {actor: genre};
    var request = $.ajax({
      url: '/getflix',
      data: data
    });

    request.done(function(responseHtml){
      $('.emojis').addClass('hidden');
      $('.main-container').append(responseHtml);
    });
  });
});
