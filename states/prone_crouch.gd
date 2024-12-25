extends PlayerState

func enter(previous_state_path: String, data = {}) -> void:
	
		CharacterPlayer.animation_player.play("CrouchProne", -1, -CharacterPlayer.animation_speed, true)
		print("Transitioning from Prone to Crouch - ",  "crouching: %s, proning: %s" % [str(crouchingFromProne), str(proning)])
		
		crouchingFromProne = true
		proning = false
func physics_update(_delta: float) -> void:
	if Input.is_action_just_pressed("crouch_or_uncrouch") and crouchingFromProne and not proning or Input.is_action_just_pressed("crouch_mobile_button") and crouchingFromProne and not proning:
		finished.emit(Standing)  # Transition back to standing
		Input.action_release("crouch_mobile_button")
		
	if Input.is_action_just_pressed("prone_or_unprone") and crouchingFromProne and not proning or Input.is_action_just_pressed("prone_mobile_button") and crouchingFromProne and not proning:
		finished.emit(Proning)
		Input.action_release("prone_mobile_button")
	


func _on_prone_pressed() -> void:
	Input.action_press("prone_mobile_button")


func _on_crouch_pressed() -> void:
	Input.action_press("crouch_or_uncrouch")
