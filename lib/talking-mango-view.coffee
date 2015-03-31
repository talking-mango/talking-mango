module.exports =
class TalkingMangoView

  constructor: (serializeState) ->

    recognition = new webkitSpeechRecognition()
    recognition.continuous = true
    recognition.interimResults = true

    doTranscribe = =>
      @start(recognition, 'btn-transcribe', (text) -> atom.workspace.activePaneItem.getSelection().insertText(text + "\n"))

    doTalkMango = =>
      @start(recognition, 'btn-talk-mango', (text) -> console.log text)

    # Create root element
    @element = document.createElement('div')
    @element.classList.add('talking-mango',  'block')

    elem = document.createElement('div')
    elem.setAttribute('id', 'intermediate-result')
    elem.textContent = "This is a transcribed text"
    @element.appendChild(elem)

    elem = document.createElement("button")
    elem.classList.add('btn', 'btn-warning', 'pull-right')
    elem.setAttribute('id', 'btn-talk-mango')
    elem.textContent = "Talk Mango"
    elem.onclick = doTalkMango
    @element.appendChild(elem)

    elem = document.createElement("button")
    elem.classList.add('btn', 'btn-primary', 'pull-right')
    elem.setAttribute('id', 'btn-transcribe')
    elem.textContent = "Transcribe"
    elem.onclick = doTranscribe
    @element.appendChild(elem)

    # Register command that toggles this view
    atom.commands.add 'atom-workspace', 'talking-mango:toggle': => @toggle()

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  # Start talking
  start: (recognition, buttonId, callback) ->

    btn = document.getElementById(buttonId)
    btnText = btn.textContent

    if btn.classList.contains('btn-error')
      text = document.getElementById('intermediate-result').textContent
      if text.trim() != ''
        console.log text
      recognition.stop()
      console.log "Stopped Listening"
    else
      console.log "Started Listening"
      document.getElementById('intermediate-result').textContent = ''

      recognition.onstart = () ->
        btn.classList.add('btn-error')
        btn.textContent = "Stop Listening"

      recognition.onend = () ->
        btn.classList.remove('btn-error')
        btn.textContent = btnText

      recognition.onresult = (event) ->
        i = event.resultIndex
        dumb = document.getElementById('intermediate-result')
        dumb.textContent = ''
        while i < event.results.length
          if event.results[i].isFinal
            callback event.results[i][0].transcript
          else
            dumb.textContent += event.results[i][0].transcript
          i++

      recognition.start()

  # Toggle the visibility of this view
  toggle: ->
    console.log 'TalkingMangoView was toggled!'

    if @element.parentElement?
      @element.remove()
    else
      atom.workspace.addBottomPanel(item: @element)
