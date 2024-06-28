extends Node
class_name StateMachine

#setting the states
@export var initial_state : State
@export var current_state : State

var states : Dictionary =  {}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.state_machine = self
			
			print("child: ", child)
	if initial_state:
		transition_to(initial_state.name.to_lower())
	
func handle_input(event: InputEvent):
	current_state.handle_input(event)

func update(delta: float):
	current_state.update(delta)

func transition_to(new_state_name: String):
	if current_state:
		current_state.exit()
	current_state = states[new_state_name]
	current_state.enter()

func get_player() -> CharacterBody3D:
	return get_parent() as CharacterBody3D
