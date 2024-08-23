extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	if crouching:
		CharacterPlayer.animation_player.play("CROUCHING", -1, -CharacterPlayer.animation_speed, true)
		print("Standing from crouch - ",  "crouching: %-8s proning: %s" % [str(crouching), str(proning)])
		
	elif proning:
		CharacterPlayer.animation_player.play("StandProne", -1, -CharacterPlayer.animation_speed, true)
		print("Standing from prone - ",  "crouching: %-8s proning: %s" % [str(crouching), str(proning)])
	
	else:
		print("Already standing - ",  "crouching: %-8s proning: %s" % [str(crouching), str(proning)])

	# Reset state flags
	crouching = false
	proning = false

func physics_update(_delta: float) -> void:
	if Input.is_action_just_pressed("crouch_or_uncrouch"):
		crouching = true
		finished.emit(Crouching)
	
	if Input.is_action_just_pressed("prone_or_unprone"):
		proning = true
		finished.emit(Proning)
