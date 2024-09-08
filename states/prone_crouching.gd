extends PlayerState

func enter(previous_state_path: String, data = {}) -> void:
	
	CharacterPlayer.animation_player.play("ProneCrouching", -1, -CharacterPlayer.animation_speed, true)
	print("Transitioning from Prone to Crouch - ",  "crouching: %s, proning: %s" % [str(crouchingFromProne), str(proning)])
	
	crouchingFromProne = true
	proning = false
		
	CharacterPlayer.SPEED = CharacterPlayer.crouching_speed
	print("crouching speed at: ", CharacterPlayer.SPEED)
	
func physics_update(_delta: float) -> void:
	if Input.is_action_just_pressed("crouch_or_uncrouch") and crouchingFromProne and not proning:
		finished.emit(Standing)  # Transition back to standing
		
	if Input.is_action_just_pressed("prone_or_unprone") and crouchingFromProne and not proning:
		finished.emit(Proning) 
