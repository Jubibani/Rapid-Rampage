extends PlayerState

func enter(previous_state_path: String, data = {}) -> void:	
	
	if not crouchingFromProne and proning:
		CharacterPlayer.animation_player.play("CrouchProne", -1, CharacterPlayer.animation_speed)
		print("Transitioning from Crouch to Prone - ",  "crouching: %s, proning: %s" % [str(crouchingFromProne), str(proning)])
	else:
		CharacterPlayer.animation_player.play("StandProne", -1, CharacterPlayer.animation_speed)
		print("Entering Proning State - ",  "crouching: %s, proning: %s" % [str(crouchingFromProne), str(proning)])
		
	crouchingFromProne = false
	proning = true


func physics_update(_delta: float) -> void:
	if Input.is_action_just_pressed("prone_or_unprone") or Input.is_action_just_pressed("prone_mobile_button"):
		proning = true
		print("Physics_update - ",  "crouching: %s, proning: %s" % [str(crouchingFromProne), str(proning)])
		finished.emit(Standing)  # Transition back to standing
		Input.action_release("prone_mobile_button")

	elif Input.is_action_just_pressed("crouch_or_uncrouch") and not crouchingFromProne and proning or Input.is_action_just_pressed("crouch_mobile_button") and not crouchingFromProne and proning:
		crouchingFromProne = true
		proning = false
		print("Physics_update - ",  "crouching: %s, proning: %s" % [str(crouchingFromProne), str(proning)])
		finished.emit(ProneCrouch)
		Input.action_release("crouch_mobile_button")


func _on_prone_pressed() -> void:
	Input.action_press("prone_mobile_button")


func _on_crouch_pressed() -> void:
	Input.action_press("crouch_mobile_button")
