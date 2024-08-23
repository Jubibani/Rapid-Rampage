extends PlayerState

func enter(previous_state_path: String, data = {}) -> void:
	if not crouching and proning:
		CharacterPlayer.animation_player.play("CrouchProne", -1, CharacterPlayer.animation_speed)
		crouching = false
		proning = true
		print("Transitioning from Crouch to Prone - ",  "crouching: %s, proning: %s" % [str(crouching), str(proning)])
	else:
		CharacterPlayer.animation_player.play("StandProne", -1, CharacterPlayer.animation_speed)
		proning = true
		print("Entering Proning State - ",  "crouching: %s, proning: %s" % [str(crouching), str(proning)])


func physics_update(_delta: float) -> void:
	if Input.is_action_just_pressed("prone_or_unprone"):
		proning = true
		print("Physics_update - ",  "crouching: %s, proning: %s" % [str(crouching), str(proning)])
		finished.emit(Standing)  # Transition back to standing

	elif Input.is_action_just_pressed("crouch_or_uncrouch") and not crouching and proning:
		crouching = true
		proning = false
		print("Physics_update - ",  "crouching: %s, proning: %s" % [str(crouching), str(proning)])
		finished.emit(ProneCrouch)
