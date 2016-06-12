(->
  Status =
    load: ($wrap)->
      $wrap.html('<div class="loading"></div>')
    nodata: ($wrap)->
      $wrap.html('<div class="nodata"></div>')
    error: ($wrap)->
      $wrap.html('<div class="error"></div>')
)()
