extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	if  proning:
		CharacterPlayer.animation_player.play("CrouchProne", -1, -CharacterPlayer.animation_speed, true)
		proning = false
		crouching = true
		print("Crouching from prone")
	if  not crouching:
		CharacterPlayer.animation_player.play("CROUCHING", -1, CharacterPlayer.animation_speed)
		proning = false
		crouching = true
		print("Crouching")
		

func physics_update(_delta: float) -> void:
	if Input.is_action_just_pressed("crouch_or_uncrouch"):
		crouching = false
		finished.emit(Standing)
		
	if crouching and Input.is_action_just_pressed("prone_or_unprone"):
		proning = true
		finished.emit(Proning)
