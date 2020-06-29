(function() {
  //= require jquery
  //= require jquery_ujs
  //= require jquery.tagify
  //= require selectize
  //= require cocoon
  //= require ckeditor/init
  //= require angular
  //= require angular-resource
  //= require angular-animate
  //= require ng-table
  //= require checklist-model
  //= require handsontable.full
  //= require ngHandsontable
  //= require moment-with-locales
  //= require moment-range
  //= require angular-mighty-datepicker
  //= require ng-sortable
  //= require ng-file-upload-shim
  //= require ng-file-upload
  //= require latte/init
  //= require photoswipe
  //= require photoswipe-ui-default
  //= require photoswipe-init
  //= require latte/app
  //= require latte/habtm
  //= require latte/gallery
  //= require latte/attachments
  //= require latte/external_videos
  $(function() {
    var addcallback;
    addcallback = null;
    $.each($('[data-selectize]'), function(i, o) {
      return $(o).selectize({
        plugins: $(o).attr('multiple') !== void 0 ? ['remove_button'] : [],
        allowEmptyOption: $(o).attr('multiple') === void 0,
        valueField: $(o).data('value'),
        labelField: $(o).data('text'),
        searchField: $(o).data('text'),
        persist: true,
        delimiter: '',
        closeAfterSelect: true,
        create: $(o).data('create') !== void 0 ? function(input, callback) {
          var k, params, prms, v;
          addcallback = callback;
          prms = {};
          if ($(o).data('create-params') !== void 0) {
            prms = $(o).data('create-params').replace(/(\w+:)|(\w+ :)/g, function(s) {
              return '"' + s.substring(0, s.length - 1) + '":';
            });
            prms = JSON.parse(prms);
          }
          prms[$(o).data('text')] = input;
          params = {};
          for (k in prms) {
            v = prms[k];
            params[`item[${k}]`] = v;
          }
          $.ajax({
            url: `/latte/${$(o).data('create')}/new`,
            method: 'GET',
            data: params
          });
        } : false,
        render: {
          option_create: function(data, escape) {
            return '<div class="create">Crear <strong>' + escape(data.input) + '</strong>&hellip;</div>';
          }
        },
        load: function(query, callback) {
          if ($(o).data('source') === void 0 || !query.length) {
            return callback();
          }
          return $.ajax({
            url: `/latte/${$(o).data('source')}/list.json`,
            type: 'GET',
            error: function() {
              return callback();
            },
            success: function(res) {
              o.selectize.clearOptions();
              return callback(res);
            }
          });
        }
      });
    });
    $('#add').on('ajax:complete', 'form', function(event, xhr, status) {
      var data;
      data = xhr.responseJSON;
      if (status === 'success') {
        return $('#add').fadeOut('fast', function() {
          $('#add').empty();
          addcallback({
            'id': data.id,
            'name': data.name
          });
          return addcallback = null;
        });
      } else {
        return $.each(data, function(control, errors) {
          var input, wrapper;
          input = $('#add').find(`input[name*='[${control}]']`);
          input.next('.help-block').remove();
          if (input.parent().is('.has-error')) {
            input.unwrap();
          }
          wrapper = $('<div />').addClass('has-error');
          input.wrap(wrapper);
          wrapper = input.parent();
          return wrapper.append($('<span />').addClass('help-block').text(errors[0]));
        });
      }
    });
    $('#add').on('click', '[data-addcancel]', function(e) {
      e.preventDefault();
      $('#add').fadeOut('fast', function() {
        return $('#add').empty();
      });
      addcallback();
      return addcallback = null;
    });
    $('[data-fakepass]').attr('type', 'password');
    if ($('.tagify').length > 0) {
      $.get('/latte/tags', function(result) {
        return $('.tagify').tagify({
          whitelist: result
        });
      });
    }
    $('[data-toggable-from-select]').hide();
    $.each($('[data-toggable-from-select]'), function(i, e) {
      var hide_on, toggable, toggler;
      toggable = $(e);
      toggler = $(`#${toggable.data('toggler-id')}`);
      hide_on = $.map(toggable.data('toggable-hide-on').split(','), function(value) {
        return value.replace(/ /g, '');
      });
      toggler.on('change', function() {
        if ($.inArray($(this).val(), hide_on) !== -1) {
          return toggable.hide();
        } else {
          return toggable.show();
        }
      });
      return toggler.trigger('change');
    });
    $('[data-xhrpopup]').on('ajax:complete', function(event, xhr, settings) {
      var html;
      html = $(xhr.responseText).hide();
      $('body').append(html).addClass('overlayed');
      html.fadeIn('fast');
      return $('[data-close]').on('click', function(e) {
        e.preventDefault();
        return $(this).closest('.overlay').fadeOut('fast', function() {
          $(this).remove();
          return $('.overlayed').removeClass('overlayed');
        });
      });
    });
    $.each($('[data-tab]'), function(i, t) {
      $(t).on('click', function(e) {
        e.preventDefault();
        $.each($('[data-tab]'), function(j, x) {
          return $($(x).data('tab')).hide();
        });
        $('[data-tab]').removeClass('active');
        $(this).addClass('active');
        return $($(this).data('tab')).show();
      });
      if (!$(t).hasClass('active')) {
        return $($(t).data('tab')).hide();
      }
    });
    return $('select#locale').on('change', function() {
      return window.location.search = `locale=${$(this).val()}`;
    });
  });

}).call(this);


//# sourceMappingURL=latte.js.map
//# sourceURL=coffeescript