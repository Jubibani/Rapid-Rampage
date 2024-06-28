extends Node
class_name State

var state_machine : StateMachine

func enter():
	pass

func exit():
	pass

func handle_input(_event: InputEvent):
	pass
	
func update(event):
	pass
	
func get_player() -> CharacterBody3D:
	return state_machine.get_player()
