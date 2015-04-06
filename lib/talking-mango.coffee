TalkingMangoView = require './talking-mango-view'

module.exports =

  config:
    enableTimeout:
      type: 'boolean'
      default: true
    timeout:
      type: 'integer'
      default: 800
      minimum: 500
      maximum: 1000

  talkingMangoView: null

  activate: (state) ->
    @talkingMangoView = new TalkingMangoView(state.talkingMangoViewState)

  deactivate: ->
    @talkingMangoView.destroy()
