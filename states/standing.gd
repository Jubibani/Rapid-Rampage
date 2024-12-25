extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	if crouchingFromStand:
		CharacterPlayer.animation_player.play("CROUCHING", -1, -CharacterPlayer.animation_speed, true)
		print("Standing from crouch - ",  "crouching: %-8s proning: %s" % [str(crouchingFromStand), str(proning)])
	
	elif crouchingFromProne and not proning:
		CharacterPlayer.animation_player.play("CROUCHING", -1, -CharacterPlayer.animation_speed, true)
		print("crouchingFromProne - ",  "crouching: %-8s proning: %s" % [str(crouchingFromStand), str(proning)])	
	elif proning:
		CharacterPlayer.animation_player.play("StandProne", -1, -CharacterPlayer.animation_speed, true)
		print("Standing from prone - ",  "crouching: %-8s proning: %s" % [str(crouchingFromStand), str(proning)])
	
	else:
		print("Already standing - ",  "crouching: %-8s proning: %s" % [str(crouchingFromStand), str(proning)])

	# Reset state flags
	crouchingFromStand = false
	crouchingFromProne = false
	proning = false

func physics_update(_delta: float) -> void:
	if Input.is_action_just_pressed("crouch_or_uncrouch") or Input.is_action_just_pressed("crouch_mobile_button"):
		print("Mobile button or key press detected [from stand]")
		crouchingFromStand = true
		finished.emit(Crouching)
		Input.action_release("crouch_mobile_button")
	
	if Input.is_action_just_pressed("prone_or_unprone") or Input.is_action_just_pressed("prone_mobile_button"):
		proning = true
		finished.emit(Proning)
		Input.action_release("prone_mobile_button")


func _on_crouch_pressed() -> void:
	Input.action_press("crouch_mobile_button")


func _on_prone_pressed() -> void:
	Input.action_press("prone_mobile_button")
