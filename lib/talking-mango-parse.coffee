module.exports =
  class TalkingMangoParse
    currentTabDepth: 1

    constructor: ->
      @createClass = /.*?create.*?class(.+)/
      @createFunction = /.*?create.*?function(.+)/
      @createVariable = /.*?create.*?variable(.+).*?and assign value(.+)/
      @returnVariable = /.*?return.?variable(.+)/
      @returnValue = /.*?return(.+)/
      @endSection = /.*?end section.*/

    parse: (text) ->
      if matches = @createClass.exec(text)
        ret = @tabOver() + "class " + matches[1].trim().split(" ").join("_") + "():\n"
        @currentTabDepth = @currentTabDepth + 1
        return ret
      if matches = @createFunction.exec(text)
        ret = @tabOver() + "def " + matches[1].trim().split(" ").join("_") + "():\n"
        @currentTabDepth = @currentTabDepth + 1
        return ret
      if matches = @createVariable.exec(text)
        return @tabOver() + matches[1].trim().split(" ").join("_") + " = " + matches[2].trim() + "\n"
      if matches = @returnVariable.exec(text)
        return @tabOver() + "return " + matches[1].trim().split(" ").join("_") + "\n"
      if matches = @returnValue.exec(text)
        return @tabOver() + "return " + mattches[1].trim() + "\n"
      if matches = @endSection.exec(text)
        if @currentTabDepth > 1
          @currentTabDepth = @currentTabDepth - 1
        return @tabOver() + "\n"
      alert "Command doesn't match any available action."
      return ""

    tabOver: =>
      return Array(@currentTabDepth).join "\t"
