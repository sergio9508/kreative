#= require jquery
#= require jquery_ujs
#= require sharer

#-- Uncomment (add "=" after "#") to use photoswipe --
#
#= require photoswipe
#= require photoswipe-ui-default
#= require photoswipe-init
#= require marquee
#= require jquery.waypoints

$ = jQuery

$(document).ready ->
  $('.tabs li').click (->
    tab_id = $(this).attr('data-tab')
    if tab_id == 'none'
      return
    $('.tabs li').removeClass 'current'
    $('.tab-content').removeClass 'current'
    $(this).addClass 'current'
    $('#' + tab_id).addClass 'current'
  )

  $('.animated').waypoint (->
    $e = $(this.element)
    $e.addClass($e.data('anim'))
  ), { offset: '100%' }

  $("a[href*='#']").on 'click', (e) ->

    regex  = /#([\S]+)/igm
    href   = $(this).attr('href')
    match  = regex.exec(href)
    anchor = match[1]
    target = $("##{anchor}")

    if target.get(0) != undefined
      e.preventDefault()
      position = target.offset().top
      $("body, html").animate { scrollTop: position }, 500

  $('#new_contact').on 'ajax:error', (xhr, response, status) ->
    self = $(this)
    data = response.responseJSON
    self.find('.field-error').remove()

    $.each data, (control, errors) ->
      input = self.find("[name*='[#{control}]']")
      $.each errors, (_, error) ->
        $('<div />')
          .addClass('field-error')
          .text(error)
          .insertAfter(input)
  
  $('#new_contact').on 'ajax:success', (event) ->
    $(this)[0].reset()
    $(this).find('.field-error').remove()
    $('.notice').fadeIn()

  if $(window).width() < 1370
    $('.imagen').addClass('align-self-middle')
  else
    $('.imagen').addClass('align-self-bottom')

  $(window).resize ->
    if $(window).width() <= 1370
      $('.imagen').removeClass('align-self-bottom')
      $('.imagen').addClass('align-self-middle')
      
    else
      $('.imagen').addClass('align-self-bottom')

      $('.imagen').removeClass('align-self-middle')
  
  $('.marquee').marquee
    delayBeforeStart: 1000
    duration: 20000
    startVisible: true
    duplicated: true
   

  hamburger = document.querySelector('.hamburger')
  hamburgerHome = document.querySelector('.hamburger-home')
  navLinks = document.querySelector('nav')
  links = document.querySelectorAll('.nav-links li')
  body = document.querySelector('body')
  home1 = document.querySelector('.home-1')
  if hamburger
    hamburger.addEventListener 'click', ->
      body.classList.toggle 'no-scroll'
      navLinks.classList.toggle 'open'
      links.forEach (link) ->
        link.classList.toggle 'fade'
        return
      if home1
        setTimeout (->
          home1.classList.toggle 'min-height'
          return
          ), 100
      return

# jQuery ->
#   console.log $('.pagination')
#   if $('.pagination').length
#     $(window).scroll ->
#       url = $('.pagination .next_page').attr('href')
#       if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
#         console.log 'Ok'
#         $('.pagination').text('Buscando...')
#         console.log $.getScript(url)
