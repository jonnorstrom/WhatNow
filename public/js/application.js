var moods = { happy: ['Comedies', 'Children & Family Movies'],
  sad: ['Classic Movies', 'Oscar-winning Movies', 'Dramas'],
  shitty: ['Independent Movies','Thrillers'],
  laughing: ['Comedies', 'Cult Movies'],
  spooky: ['Horror Movies'],
  pissed: ['Action & Adventure', 'Thrillers'],
  wine: ['Oscar-winning Movies', 'Classic Movies', 'Gay & Lesbian Movies', 'Documentaries'],
  inlove: ['Romantic Movies', 'Gay & Lesbian Movies'],
  scary: ['Thrillers', 'Action & Adventure', 'Sci-Fi & Fantasy'],
  beers: ['Comedies', 'TV Shows', 'Cult Movies', 'Action & Adventure'],
  british: ['Foreign Movies', 'Classic Movies'],
  thinker: ['Documentaries', 'Independent Movies', 'Foreign Movies', 'Sci-Fi & Fantasy', 'Romantic Movies', 'Comedies', 'TV Shows']
};

Array.prototype.sample = function(){
  return this[Math.floor(Math.random()*this.length)];
};

$(document).ready(function(){
  $('.login').toggle();
  $('.register').toggle();

  $('#login').on('click', function(){
    $('#register').toggle();
    $('.login').slideToggle("slow");
  });

  $('#register').on('click', function(){
    $("#login").toggle();
    $('.register').slideToggle('slow');

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

// event handler for emoji mood!
  $('.mood-table').on('click', 'img', function(){
    var mood = $(this).attr('id');
    var data = {genre: moods[mood].sample(), mood: $(this).attr('src')};
    console.log(data);
    var request = $.ajax({
      url: '/getflix',
      data: data
    });

    request.done(function(responseHtml){
      $('.emojis').addClass('hidden');
      $('.main-container').append(responseHtml);
    });
  }); // end of mood event handler
});
