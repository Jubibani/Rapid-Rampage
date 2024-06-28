extends State

func enter():
	print("Entering Crouch State")
	get_player().speed *= 0.5  # Slow down when crouching

func exit():
	get_player().speed *= 2  # Restore normal speed

func handle_input(event: InputEvent):
	if event.is_action_pressed("crouch"):
		print("crouched")
		state_machine.transition_to("idle")
		print("idle")
	elif event.is_action_pressed("prone"):
		state_machine.transition_to("prone")

func update(delta: float):
	pass
