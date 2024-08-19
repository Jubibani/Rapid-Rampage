extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
<<<<<<< HEAD
	if Input.is_action_just_pressed("crouch_or_uncrouch"):
		print("Entered Standing state from Crouching State")
		player.animation_player.play("CROUCHING", -1, -player.animation_speed, true)
			
	if Input.is_action_just_pressed("prone_or_unprone"):
		print("Entered Standing state from Proning State")
		player.animation_player.play("STANDPRONE", -1, -player.animation_speed, true)

func physics_update(_delta: float) -> void:
	if Input.is_action_just_pressed("crouch_or_uncrouch"):
		crouching = true 
		finished.emit(Crouching)
		


	#if Input.is_action_just_pressed("prone_or_unprone"):
		#proning = true
		#finished.emit(Proning)
=======
	print("Entered Standing state")
	
	player.animation_player.play("CROUCHING", -1, -player.animation_speed, true)

	proning = false
	crouching = false  # Set crouching state to false

func physics_update(_delta: float) -> void:
	if Input.is_action_just_pressed("crouch_or_uncrouch") and not crouching:
		crouching = true
		finished.emit(Crouching)  # Transition to Crouching if the action is pressed
		
	if Input.is_action_just_pressed("prone_or_unprone"):
		proning = true
		finished.emit(Proning)
>>>>>>> f19b1fbe91b7d47950f84f4253c45acf63007c07
