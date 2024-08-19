extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
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
