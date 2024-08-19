extends PlayerState

func enter(previous_state_path: String, data = {}) -> void:
	if not proning:
		CharacterPlayer.animation_player.play("StandProne", -1, CharacterPlayer.animation_speed)
		proning = true
		crouching = false
		print("Proning")
		
	if crouching and not proning:
		CharacterPlayer.animation_player.play("CrouchProne", -1, CharacterPlayer.animation_speed)
		crouching = false
		proning = true
		print("Crouch Proning")

func physics_update(_delta: float) -> void:
	if Input.is_action_just_pressed("prone_or_unprone"):
		proning = false
		finished.emit(Standing)
		
	if Input.is_action_just_pressed("crouch_or_uncrouch"):
		proning = false
		finished.emit(Crouching)
