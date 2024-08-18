extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	print("Entered Crouching state")
	player.animation_player.play("CROUCHING", -1, player.animation_speed)
	crouching = true  # Set crouching state to true

func physics_update(_delta: float) -> void:
	if Input.is_action_just_pressed("crouch_or_uncrouch") and crouching: 
		crouching = false
		finished.emit(Standing)  # Transition to Standing if the action is pressed
