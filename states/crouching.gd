extends PlayerState

func enter(previous_state_path: String, data = {}) -> void:
	print("Crouch State: ", "crouching: %s, proning: %s" % [str(crouching), str(proning)]) 
	
	if crouching:
		CharacterPlayer.animation_player.play("CROUCHING", -1, CharacterPlayer.animation_speed)
		crouching = true
		print("Entering Crouching State - ",  "crouching: %s, proning: %s" % [str(crouching), str(proning)])
		
	elif crouching and not proning:
		CharacterPlayer.animation_player.play("CrouchProne", -1, -CharacterPlayer.animation_speed, true)
		proning = false
		crouching = true
		print("Transitioning from Prone to Crouch - ",  "crouching: %s, proning: %s" % [str(crouching), str(proning)])

func physics_update(_delta: float) -> void:
	if Input.is_action_just_pressed("crouch_or_uncrouch"):
		crouching = true
		finished.emit(Standing)  # Transition back to standing
	elif Input.is_action_just_pressed("prone_or_unprone"):
		crouching = false
		proning = true
		finished.emit(Proning)  # Transition to proning
