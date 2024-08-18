class_name PlayerState extends State

const Standing = "Standing"
const Crouching = "Crouching"
const Proning = "Proning"


var crouching : bool = false  # Set default to false
var proning : bool = false 

var player: CharacterBody3D

func _ready() -> void:
	await owner.ready
	player = owner as CharacterBody3D    
	assert(player != null, "The PlayerState state type must be used only in the player scene. It needs the owner to be a Player node.")
