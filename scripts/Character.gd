extends CharacterBody3D


var SPEED = walking_speed
const walking_speed = 5.5
const running_speed = 12.5
var running : bool = false
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
 
func _input(event):
	if Input.is_action_just_released("run") and is_on_floor():
		running = not running   
		if running:
			SPEED = running_speed
			print("running")
		else:
			SPEED = walking_speed
		
	if event is InputEventScreenDrag:
		var look_sensitivity = 0.5
		rotate_y(deg_to_rad(-event.relative.x * look_sensitivity))
		$head.rotate_x(deg_to_rad(-event.relative.y * look_sensitivity))
		
		var head_rotation = $head.rotation_degrees
		head_rotation.x -= event.relative.y * look_sensitivity
		head_rotation.x = clamp(head_rotation.x, -90, 90)
		$head.rotation_degrees = head_rotation
		
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	print("speed: ", SPEED)



func _on_jump_pressed():
	# Handle jump.
	if is_on_floor():
		velocity.y = JUMP_VELOCITY
		print("jumped")


func _on_run_pressed():
	running = not running   
	if running:
		SPEED = running_speed
		print("running")
	else:
		SPEED = walking_speed
	
	
