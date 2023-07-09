extends Area2D


func _on_body_entered(body):
	if body.is_in_group("BloodBag"):
		print('checking orders...')
		for order in GlobalOrders.orders:
			if body.order.check_order(order["order"]):
				print('correct!')
				GlobalOrders.orders.pop_at(order["order_num"])
				body.queue_free()
