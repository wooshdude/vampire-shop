extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	print(body)
	if body.is_in_group("BloodBag") or body.is_in_group("Paper"):
		body.anim.play("DELETE")
		if body.is_in_group("Paper"):
			if body.patient_file["vampire"]:
				GlobalOrders.emit_signal("order_finished")
			if body.emergency and body.patient_file["vampire"] == false:
				Score.Citation()
		#body.global_position = self.global_position
