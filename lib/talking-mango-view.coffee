module.exports =
class TalkingMangoView

  constructor: (serializeState) ->
    # Create root element
    @element = document.createElement('div')
    @element.classList.add('talking-mango',  'block')

    # Create message element
    message = document.createElement('div')
    message.textContent = "The TalkingMango package is Alive! It's ALIVE!"
    message.classList.add('message')
    @element.appendChild(message)

    @button = document.createElement("button")
    @button.classList.add('mic-button')
    @button.onclick = @start
    elem = document.createElement("img")
    elem.src = "atom://talking-mango/images/test.png"
    elem.height = "30"
    elem.width = "25"

    @button.appendChild(elem)

    @element.appendChild(@button)


    # Register command that toggles this view
    atom.commands.add 'atom-workspace', 'talking-mango:toggle': => @toggle()

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  start: ->
    console.log "start was called"
    msg = new SpeechSynthesisUtterance()
    msg.text = "Hello World"
    window.speechSynthesis.speak(msg)

    # might have to move it to the constructor
    recognition = new webkitSpeechRecognition()
    recognition.continuous = false
    recognition.interimResults = true

    recognition.onstart = () ->
      console.log "started"

    recognition.onend = () ->
      console.log "end"

    recognition.onresult = (event) ->
      console.log "onresult was called"
      i = event.resultIndex
      while i < event.results.length
          if event.results[i].isFinal
            console.log event.results[i][0].transcript
          i++

    recognition.start()

  # Toggle the visibility of this view
  toggle: ->
    console.log 'TalkingMangoView was toggled!'

    if @element.parentElement?
      @element.remove()
    else
      atom.workspace.addBottomPanel(item: @element)
