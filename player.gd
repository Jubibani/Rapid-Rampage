extends RigidBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var move_speed = 1000.0
	var jump_strength = 1000.0
	var force := Vector3.ZERO
	
	if Input.is_action_pressed("forward"):
		force += -transform.basis.z * move_speed * delta
	if Input.is_action_pressed("backward"):
		force += transform.basis.z * move_speed * delta
	if Input.is_action_pressed("left"):
		force += -transform.basis.x * move_speed * delta
	if Input.is_action_pressed("right"):
		force += transform.basis.x * move_speed * delta
	
	if Input.is_action_pressed("jump"):
		force += transform.basis.y * jump_strength * delta
	apply_central_force(force)
