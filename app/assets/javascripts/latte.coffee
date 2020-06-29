#= require jquery
#= require jquery_ujs
#= require jquery.tagify
#= require selectize
#= require cocoon
#= require ckeditor/init
#= require angular
#= require angular-resource
#= require angular-animate
#= require ng-table
#= require checklist-model
#= require handsontable.full
#= require ngHandsontable
#= require moment-with-locales
#= require moment-range
#= require angular-mighty-datepicker
#= require ng-sortable
#= require ng-file-upload-shim
#= require ng-file-upload
#= require latte/init
#= require photoswipe
#= require photoswipe-ui-default
#= require photoswipe-init
#= require latte/app
#= require latte/habtm
#= require latte/gallery
#= require latte/attachments
#= require latte/external_videos

$ ->

  addcallback = null
  $.each $('[data-selectize]'), (i, o) ->
    $(o).selectize
      plugins: if $(o).attr('multiple') != undefined then ['remove_button'] else [],
      allowEmptyOption: $(o).attr('multiple') == undefined,
      valueField: $(o).data('value'),
      labelField: $(o).data('text'),
      searchField: $(o).data('text'),
      persist: true,
      delimiter: '',
      closeAfterSelect: true,
      create: if $(o).data('create') != undefined
          (input, callback) ->
            addcallback = callback
            prms = {}

            unless $(o).data('create-params') == undefined
              prms = $(o).data('create-params')
                       .replace /(\w+:)|(\w+ :)/g, (s) ->
                         '"' + s.substring(0, s.length - 1) + '":'

              prms = JSON.parse(prms)

            prms[$(o).data('text')] = input

            params = {}
            for k, v of prms
              params["item[#{k}]"] = v

            $.ajax({
              url: "/latte/#{$(o).data('create')}/new",
              method: 'GET',
              data: params
            })
            return
        else
          false
      ,
      render: {
        option_create: (data, escape) ->
          '<div class="create">Crear <strong>' +
          escape(data.input) +
          '</strong>&hellip;</div>'
      }
      ,
      load: (query, callback) ->
        return callback() if $(o).data('source') == undefined || !query.length
        $.ajax {
          url: "/latte/#{$(o).data('source')}/list.json",
          type: 'GET',
          error: ->
            callback()
          ,
          success: (res) ->
            o.selectize.clearOptions()
            callback(res)
        }

  $('#add').on 'ajax:complete', 'form', (event, xhr, status) ->
    data = xhr.responseJSON
    if status == 'success'
      $('#add').fadeOut 'fast', ->
        $('#add').empty()
        addcallback { 'id': data.id, 'name': data.name }
        addcallback = null
    else
      $.each data, (control, errors) ->
        input = $('#add').find("input[name*='[#{control}]']")

        input.next('.help-block').remove()
        if input.parent().is('.has-error')
          input.unwrap()

        wrapper = $('<div />').addClass('has-error')
        input.wrap(wrapper)
        wrapper = input.parent()
        wrapper.append(
          $('<span />')
            .addClass('help-block')
            .text(errors[0])
        )

  $('#add').on 'click', '[data-addcancel]', (e) ->
    e.preventDefault()
    $('#add').fadeOut 'fast', ->
      $('#add').empty()
    addcallback()
    addcallback = null

  $('[data-fakepass]').attr('type', 'password')

  if $('.tagify').length > 0
    $.get '/latte/tags', (result) ->
      $('.tagify').tagify whitelist: result

  $('[data-toggable-from-select]').hide()
  $.each $('[data-toggable-from-select]'), (i, e) ->
    toggable = $(e)
    toggler  = $("##{toggable.data('toggler-id')}")
    hide_on  = $.map toggable.data('toggable-hide-on').split(','), (value) ->
      return value.replace(/ /g, '')

    toggler.on 'change', ->
      if $.inArray($(this).val(), hide_on) != -1
        toggable.hide()
      else
        toggable.show()
    toggler.trigger('change')


  $('[data-xhrpopup]').on 'ajax:complete', (event, xhr, settings) ->
    html = $(xhr.responseText).hide()
    $('body').append(html).addClass('overlayed')
    html.fadeIn 'fast'

    $('[data-close]').on 'click', (e) ->
      e.preventDefault()
      $(this).closest('.overlay').fadeOut 'fast', ->
        $(this).remove()
        $('.overlayed').removeClass('overlayed')


  $.each $('[data-tab]'), (i, t) ->
    $(t).on 'click', (e) ->
      e.preventDefault()

      $.each $('[data-tab]'), (j, x) ->
        $($(x).data('tab')).hide()

      $('[data-tab]').removeClass('active')
      $(this).addClass('active')
      $($(this).data('tab')).show()

    $($(t).data('tab')).hide() unless $(t).hasClass('active')

  $('select#locale').on 'change', ->
      window.location.search = "locale=#{$(this).val()}"
