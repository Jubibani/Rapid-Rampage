extends CharacterBody3D

@export var animation_player : AnimationPlayer
@export_range(5.0, 5.0, 10.0)var crouching_animation_speed = 5.0
var SPEED = walking_speed

var is_running : bool = true
var standing := !is_crouching
var is_crouching : bool = true

const crouching_speed = 2.3
const walking_speed = 5.5
const running_speed = 12.5
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
 
func _input(event):
	
	if Input.is_action_just_pressed("run") and is_on_floor():
		if standing:
			_run()
		
	if Input.is_action_just_pressed("crouch") and is_on_floor():
		if is_crouching:
			_crouch()
		else:
			_uncrouch()
		is_crouching = !is_crouching
		
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


#Handle Movements
func _crouch():
	if is_crouching:
		animation_player.play("CROUCHING", -1, crouching_animation_speed)
		SPEED = crouching_speed
		print("is crouching at the speed of: ", SPEED)
	
func _uncrouch():
	if !is_crouching:
		animation_player.play("CROUCHING", -1, -crouching_animation_speed, true)
		SPEED = walking_speed 
		print("is not crouching at the speed of: ", SPEED)

func _run():
	if is_running:
		SPEED = running_speed
		print("running at the speed of: ", SPEED)
		
	elif SPEED == walking_speed:
		SPEED = running_speed
		print("running at the speed of: ", SPEED)
		
	elif is_crouching:
		SPEED = crouching_speed
	#else:
		#SPEED = walking_speed
		#print("walking at the speed of: ", SPEED)
		
	is_running = !is_running

func _on_jump_pressed():
	# Handle jump.
	if is_on_floor():
		velocity.y = JUMP_VELOCITY
		print("jumped")


func _on_run_pressed():
	if is_running:
		SPEED = running_speed
		print("running")
	is_running = !is_running
	
	
