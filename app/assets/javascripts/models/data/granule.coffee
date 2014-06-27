@edsc.models.data.Granule = do (extend = $.extend, scalerUrl = @edsc.config.browseScalerUrl) ->

  class Granule
    constructor: (jsonData) ->
      extend(this, jsonData)

    edsc_browse_url: (w, h) ->
      w ?= 170
      h ?= w
      "#{scalerUrl}/#{@id}?h=#{h}&w=#{w}"

    edsc_full_browse_url: ->
      for link in @links
        return link.href if link.rel.indexOf('browse') != -1
      null

    getTemporal: ->
      time_end = @_normalizeTime(@time_end)
      time_start = @_normalizeTime(@time_start)

      return time_start if time_start == time_end
      return time_start unless time_end?
      return time_end unless time_start?

      "#{time_start} to #{time_end}"

    _normalizeTime: (time) ->
      return null unless time?

      time.replace(/\.0+Z/, 'Z')

    equals: (other) ->
      other.id == @id

  exports = Granule
