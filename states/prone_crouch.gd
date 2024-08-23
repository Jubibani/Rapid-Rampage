extends PlayerState

func enter(previous_state_path: String, data = {}) -> void:
		CharacterPlayer.animation_player.play("CrouchProne", -1, -CharacterPlayer.animation_speed, true)
		crouching = true
		print("Transitioning from Prone to Crouch - ",  "crouching: %s, proning: %s" % [str(crouching), str(proning)])

func physics_update(_delta: float) -> void:
	if Input.is_action_just_pressed("crouch_or_uncrouch") and crouching:
		finished.emit(Standing)  # Transition back to standing
	
