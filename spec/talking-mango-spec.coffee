{WorkspaceView} = require 'atom'
TalkingMango = require '../lib/talking-mango'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "TalkingMango", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('talking-mango')

  describe "when the talking-mango:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.talking-mango')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.commands.dispatch atom.workspaceView.element, 'talking-mango:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.talking-mango')).toExist()
        atom.commands.dispatch atom.workspaceView.element, 'talking-mango:toggle'
        expect(atom.workspaceView.find('.talking-mango')).not.toExist()
