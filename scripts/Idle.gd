extends State
class_name Idle

# Upon entering the state, we set the Player node's velocity to zero and adjust animations.
func enter(_msg := {}) -> void:
	# Reset velocity to zero (example)
	owner.velocity = Vector3.ZERO

	# Example: Play idle animation
	owner.animation_player.play("IDLE", -1, owner.animation_speed)

	# Example: Check if crouching and adjust animation or state
	if owner.is_crouching:
		owner.animation_player.play("CROUCHING", -1, owner.animation_speed)

func update(delta: float) -> void:
	# Example: Handle input to transition to another state (e.g., Crouch state)
	if Input.is_action_just_pressed("crouch") and !owner.is_crouching:
		owner.state_machine.transition_to("Crouch")
		print("Transitioning to Crouch state")
