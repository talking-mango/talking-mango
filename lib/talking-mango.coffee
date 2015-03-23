TalkingMangoView = require './talking-mango-view'

module.exports =
  talkingMangoView: null

  activate: (state) ->
    @talkingMangoView = new TalkingMangoView(state.talkingMangoViewState)

  deactivate: ->
    @talkingMangoView.destroy()

  serialize: ->
    talkingMangoViewState: @talkingMangoView.serialize()
