extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
<<<<<<< HEAD
	if Input.is_action_just_pressed("crouch_or_uncrouch"):
		print("Entered Crouching state")
		player.animation_player.play("CROUCHING", -1, player.animation_speed)
		
		crouching = true
	if Input.is_action_just_pressed("prone_or_unprone"):
		print("prone from crouch")
		
=======
	print("Entered Crouching state")
	player.animation_player.play("CROUCHING", -1, player.animation_speed)
	crouching = true  # Set crouching state to true

>>>>>>> f19b1fbe91b7d47950f84f4253c45acf63007c07
func physics_update(_delta: float) -> void:
	if Input.is_action_just_pressed("crouch_or_uncrouch") and crouching: 
		crouching = false
		finished.emit(Standing)  # Transition to Standing if the action is pressed
<<<<<<< HEAD
	
=======
>>>>>>> f19b1fbe91b7d47950f84f4253c45acf63007c07
