extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	CharacterPlayer.SPEED = CharacterPlayer.running_speed
	print("running speed at: ", CharacterPlayer.SPEED)

func physics_update(_delta: float) -> void:
	if Input.is_action_just_pressed("crouch_or_uncrouch"):
		crouchingFromStand = true
		finished.emit(StandCrouching)
	
	if Input.is_action_just_pressed("prone_or_unprone"):
		proning = true
		finished.emit(Proning) 
		
	if Input.is_action_just_pressed("run"):
		finished.emit(Standing)
	
	if Input.is_action_just_pressed("Jump"):
		finished.emit(Jumping)
