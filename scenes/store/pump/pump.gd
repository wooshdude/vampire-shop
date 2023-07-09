extends Node2D

@onready var area = $Area2D
@onready var spout = $Spout


var in_use = false


func _process(delta):
	if in_use:
		$AnimationPlayer.play("PUMP")
	else:
		$AnimationPlayer.stop()
