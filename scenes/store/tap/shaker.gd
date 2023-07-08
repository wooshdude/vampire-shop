extends Node2D

@onready var area = $Area2D
@onready var spout = $Spout

@export_enum("Iron", "Calcium") var ingredient = 0
var in_use = false
