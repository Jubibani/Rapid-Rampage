extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	if crouching:
		CharacterPlayer.animation_player.play("CROUCHING", -1, -CharacterPlayer.animation_speed, true)
		crouching = false
		print("Standing from crouch")
		
	if proning:
		CharacterPlayer.animation_player.play("StandProne", -1, -CharacterPlayer.animation_speed, true)
		proning = false
		print("Standing from prone")

func physics_update(_delta: float) -> void:
	if Input.is_action_just_pressed("crouch_or_uncrouch"):
		crouching = true
		finished.emit(Crouching)
	
	if Input.is_action_just_pressed("prone_or_unprone"):
		proning = true
		finished.emit(Proning)
