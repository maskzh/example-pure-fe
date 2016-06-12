(->
  util =
    # 计时显示提示
    toastr: (message) ->
      genId = (->
        i = 0
        ->
          i++
      )()

      id = 'toastr' + genId()
      $('body').append "<div id='#{id}' class='toastr'>"+
      "<span class='toastr-inner'>#{message}</span></div>"

      _timer = setTimeout ->
        $('#' + id).remove()
        clearTimeout _timer
      , 1000
      return

    # JS 设置网页标题
    setTitle: (title) ->
      $body = $('body')
      document.title = title
      # hack在微信等webview中无法修改document.title的情况
      $iframe = $('<iframe src="/h5/favicon.ico"></iframe>')
      $iframe.on 'load', ->
        setTimeout ->
          $iframe.off('load').remove()
        , 0
      .appendTo($body)
      return

    # 获取 URL 查询字段
    getParameterByName: (name) ->
      match = RegExp('[?&]' + name + '=([^&]*)')
        .exec(window.location.search)
      match && decodeURIComponent(match[1].replace(/\+/g, ' '))

    # 跟图片增加前缀
    img: (url) ->
      'http://jkbsimg.com/' + url

    # 封装的 ajax 方法
    ajax: (type, url, data, success) ->
      $.extend data, {'access-token': Token}
      $.ajax({
        type: type
        url: url
        data: data
        dataType: 'json'
        success: (res) ->
          if res.result
            success && success(res)
          else
            Util.toastr '请求失败 -_-!!'
        error: (xhr, message) ->
          Util.toastr message
      })

  window.util = util
)()
