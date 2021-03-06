var moods = {
  happy: ['Comedies', 'Children & Family Movies'],
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

// event handler for emoji mood!
  $('.mood-table').on('click', 'img', function(){
    var mood = $(this).attr('id');
    var data = {genre: moods[mood], imgSrc: $(this).attr('src')};
    var request = $.ajax({
      url: '/getflix',
      data: data
    });

    request.done(function(responseHtml){
      $('.emojis').hide();
      $('.sub-container').empty();
      $('.sub-container').replaceWith(responseHtml);
      $('#back-arrow').parent().addClass('emoji');
    });
  }); // end of mood event handler

  $('.main-container').on('click', '#die-pic', function(){
    var className = $('#back-arrow').parent().attr('class');
    var request = $.ajax({
      url: '/getflix',
      data: {imgSrc: $('#og-mood').attr('src')}
    });

    request.done(function(responseHtml){
      $('.sub-container').empty();
      $('.sub-container').replaceWith(responseHtml);
      $('#back-arrow').parent().addClass(className);
    });
  });

  $('.main-container').on('click','#weather', function(){
    event.preventDefault();
    var mood = $(this).find('img').attr('name');
    var img = $(this).find('img').attr('src');
    var data = {genre: moods[mood], imgSrc: img};
    var request = $.ajax({
      url: '/getflix',
      data: data
    });
    request.done(function(responseHtml){
      $('.search_page').hide();
      $('.sub-container').empty();
      $('.sub-container').replaceWith(responseHtml);
      $('#back-arrow').parent().addClass('weather');
    });
  });

  $('.main-container').on('click', '#back-arrow', function(){
    if ($(this).parent().hasClass('weather')) {
      $('.sub-container').hide();
      $('.search_page').show();
    } else if ($(this).parent().hasClass('emoji')) {
      var request = $.ajax({
        url: '/moods'
      });
      request.done(function(responseHtml){
        $('.sub-container').empty();
        $('.emojis').show();
      });
    }
  });
});
