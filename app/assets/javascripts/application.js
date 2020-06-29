(function() {
  //= require jquery
  //= require jquery_ujs
  //= require sharer

  //-- Uncomment (add "=" after "#") to use photoswipe --

  //= require photoswipe
  //= require photoswipe-ui-default
  //= require photoswipe-init
  //= require marquee
  //= require jquery.waypoints
  //= require infinite-scroll
  var $, Tawk_API, Tawk_LoadStart;

  $ = jQuery;

  $(document).ready(function() {
    var body, hamburger, hamburgerHome, home1, links, navLinks;
    $('.tabs li').click((function() {
      var tab_id;
      tab_id = $(this).attr('data-tab');
      $('.tabs li').removeClass('current');
      $('.tab-content').removeClass('current');
      $(this).addClass('current');
      return $('#' + tab_id).addClass('current');
    }));
    $('.animated').waypoint((function() {
      var $e;
      $e = $(this.element);
      return $e.addClass($e.data('anim'));
    }), {
      offset: '100%'
    });
    $("a[href*='#']").on('click', function(e) {
      var anchor, href, match, position, regex, target;
      regex = /#([\S]+)/igm;
      href = $(this).attr('href');
      match = regex.exec(href);
      anchor = match[1];
      target = $(`#${anchor}`);
      if (target.get(0) !== void 0) {
        e.preventDefault();
        position = target.offset().top;
        return $("body, html").animate({
          scrollTop: position
        }, 500);
      }
    });
    $('#new_contact').on('ajax:error', function(xhr, response, status) {
      var data, self;
      self = $(this);
      data = response.responseJSON;
      self.find('.field-error').remove();
      return $.each(data, function(control, errors) {
        var input;
        input = self.find(`[name*='[${control}]']`);
        return $.each(errors, function(_, error) {
          return $('<div />').addClass('field-error').text(error).insertAfter(input);
        });
      });
    });
    $('#new_contact').on('ajax:success', function(event) {
      $(this)[0].reset();
      $(this).find('.field-error').remove();
      return $('.notice').fadeIn();
    });
    if ($(window).width() < 1370) {
      $('.imagen').addClass('align-self-middle');
    } else {
      $('.imagen').addClass('align-self-bottom');
    }
    $(window).resize(function() {
      if ($(window).width() <= 1370) {
        $('.imagen').removeClass('align-self-bottom');
        return $('.imagen').addClass('align-self-middle');
      } else {
        $('.imagen').addClass('align-self-bottom');
        return $('.imagen').removeClass('align-self-middle');
      }
    });
    $('.post-row').infiniteScroll({
      path: '.next_page',
      append: '.post',
      history: false,
      scrollThreshold: 50
    });
    $('.marquee').marquee({
      delayBeforeStart: 1000,
      duration: 20000,
      startVisible: true,
      duplicated: true
    });
    hamburger = document.querySelector('.hamburger');
    hamburgerHome = document.querySelector('.hamburger-home');
    navLinks = document.querySelector('nav');
    links = document.querySelectorAll('.nav-links li');
    body = document.querySelector('body');
    home1 = document.querySelector('.home-1');
    if (hamburger) {
      return hamburger.addEventListener('click', function() {
        body.classList.toggle('no-scroll');
        navLinks.classList.toggle('open');
        links.forEach(function(link) {
          link.classList.toggle('fade');
        });
        if (home1) {
          setTimeout((function() {
            home1.classList.toggle('min-height');
          }), 100);
        }
      });
    }
  });

  Tawk_API = Tawk_API || {};

  Tawk_LoadStart = new Date;

  (function() {
    var s0, s1;
    s1 = document.createElement('script');
    s0 = document.getElementsByTagName('script')[0];
    s1.async = true;
    s1.src = 'https://embed.tawk.to/5d6558d9eb1a6b0be609a182/default';
    s1.charset = 'UTF-8';
    s1.setAttribute('crossorigin', '*');
    s0.parentNode.insertBefore(s1, s0);
  })();

  // jQuery ->
//   console.log $('.pagination')
//   if $('.pagination').length
//     $(window).scroll ->
//       url = $('.pagination .next_page').attr('href')
//       if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
//         console.log 'Ok'
//         $('.pagination').text('Buscando...')
//         console.log $.getScript(url)

}).call(this);


//# sourceMappingURL=application.js.map
//# sourceURL=coffeescript