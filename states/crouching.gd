extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	if not crouching:
		CharacterPlayer.animation_player.play("CROUCHING", -1, CharacterPlayer.animation_speed)
		crouching = true
		proning = false
		print("Crouching")
	
	if not proning and not crouching:
		CharacterPlayer.animation_player.play("StandProne", -1, -CharacterPlayer.animation_speed, true)
		crouching = true
		proning = false
		print("Crouching from prone")	

func physics_update(_delta: float) -> void:
	if Input.is_action_just_pressed("crouch_or_uncrouch"):
		crouching = false
		finished.emit(Standing)
		
	if crouching and Input.is_action_just_pressed("prone_or_unprone"):
		proning = true
		finished.emit(Proning)
