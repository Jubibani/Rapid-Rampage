extends PlayerState

func enter(previous_state_path: String, data = {}) -> void:
	if crouching:
		CharacterPlayer.animation_player.play("CrouchProne", -1, CharacterPlayer.animation_speed)
		crouching = false
		proning = true
		print("Crouch to prone")
	else:
		CharacterPlayer.animation_player.play("StandProne", -1, CharacterPlayer.animation_speed)
		crouching = false
		proning = true
		print("Proning")

func physics_update(_delta: float) -> void:
	if Input.is_action_just_pressed("prone_or_unprone"):
		proning = false
		finished.emit(Standing)
		
	if Input.is_action_just_pressed("crouch_or_uncrouch"):
		proning = true
		finished.emit(Crouching)
		
