((window)->
  app = {
    init: ->
      # app.initToken()
      FastClick.attach(document.body)

    initToken: ->
      token = Util.getParameterByName('token') or false
      if token
        $.ajax
          type: 'post'
          url: '/auth/login'
          data: {'access-token': token}
          success: (res) ->
            if res.result
              token = res.message
              cookie.set 'token', token, {path: '/'}
              cookie.set 'id', res.data.id, {path: '/'}
              cookie.set 'name', res.data.name, {path: '/'}
              cookie.set 'type', res.data.type, {path: '/'}
              window.Token = token
              $(document).trigger('authSuccess')
            else
              Util.toastr res.message
              setTimeout ->
                location.href = 'login.html'
              , 1000
          error:(xhr, message) ->
            Util.toastr xhr.message
            setTimeout ->
              location.href = 'login.html'
            , 1000
      else
        token = cookie.get 'token'
        if token
          window.Token = token
        else
          if dev
            location.href = "/app/login/login.html"
          else
            location.href = "login.html"
  }

  window.app = app
  window.dev = false
)(window)
