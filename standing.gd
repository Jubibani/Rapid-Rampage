extends State

func enter():
	print("Entering Idle State")

func handle_input(event: InputEvent):
	if event.is_action_pressed("crouch"):
		state_machine.transition_to("crouch")
	elif event.is_action_pressed("prone"):
		state_machine.transition_to("prone")
