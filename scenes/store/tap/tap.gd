extends Node2D

@onready var ray = $RayCast2D
@onready var spout = $Spout

@export var blood_type = "a"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	if ray.is_colliding():
#		var collider = ray.get_collider().get_parent()
#		if collider.is_in_group("BloodBag"):
#			collider.selected = false
#			#collider.get_node("Area2D").monitoring = false
#			collider.gravity_scale = 0
#			collider.global_position = lerp(collider.global_position, spout.global_position, 0.5)
#			#ray.enabled = false
	pass
