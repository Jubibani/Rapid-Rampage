class_name StateMachine extends Node

## picking a starting state

#Put it to inspector as a property
@export var initial_state: State = null
#getting the initial state with an iief
@onready var state: State = (func get_initial_state() -> State:
	return initial_state if initial_state != null else get_child(0)
	).call()

## referencing the state for transitioning 
func _ready() -> void:
	#reference the states to the State Machine
	for state_node: State in find_children("*", "State"):
		state_node.finished.connect(_transitioning_to_next_state)
	# State machines usually access data from the root node of the scene they're part of: the owner.
	# We wait for the owner to be ready to guarantee all the data and nodes the states may need are available.
	await owner.ready
	state.enter("")
	
func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)
	
func _process(delta: float) -> void:
	state.update(delta)
	
func _physics_process(delta: float) -> void:
	state.physics_update(delta)
		
##transitioning to next state
func _transitioning_to_next_state(target_state_path: String, data: Dictionary = {}) -> void:
	if not has_node(target_state_path):
		printerr(owner.name + ": Trying to transition to state " + target_state_path + " but it does not exist.")
		return
	
	var previous_state_path := state.name	
	state.exit()
	state = get_node(target_state_path)
	state.enter(previous_state_path, data)
	
