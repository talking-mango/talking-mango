module.exports =
  class TalkingMangoParse

    constructor: ->
      @createClass = /.*?create.*?class(.*)/
      @createFunction = /.*?create.*?function(.*)/
      @createVariable = /.*?create.*?variable(.*).*?and assign value(.*)/
      @endClass = /.*?end.*?class.*/

    parse: (text) ->
      if matches = @createClass.exec(text)
        return "class " + matches[1].trim().split(" ").join("_") + " {\n"
      if matches = @createFunction.exec(text)
        return "def " + matches[1].trim().split(" ").join("_") + "():\n"
      if matches = @createVariable.exec(text)
        return matches[1].trim().split(" ").join("_") + " = " + matches[2].trim() + "\n"
      if matches = @endClass.exec(text)
        return "}\n"
      return ""
