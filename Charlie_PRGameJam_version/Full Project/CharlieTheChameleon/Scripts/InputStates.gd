var inputName
var prevState
var curState
var input

var outputState
var stateOld
func _init(var inputName):
	self.inputName = inputName

func check():
  input = Input.is_action_pressed(self.inputName)
  prevState = curState
  curState = input

  stateOld = outputState

  if not prevState and not curState:
    outputState = 0 # Released

  if not prevState and curState:
    outputState = 1 # Just Pressed

  if prevState and curState:
    outputState = 2 # Pressed

  if prevState and not curState:
    outputState = 3 # Just Released

  return outputState
