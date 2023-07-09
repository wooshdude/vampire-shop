extends Area2D


func _on_body_entered(body):
	if body.is_in_group("BloodBag"):
		print('checking orders...')
		for order in GlobalOrders.orders:
			print(order["order"])
			print(body.order.recipe)
			if body.order.check_order(order["order"]):
				if not order['vampire']:
					print('correct!')
					Score.money += 10
				else:
					print('happy vampire')
					Score.Citation()
				GlobalOrders.emit_signal("order_finished")
				GlobalOrders.emit_signal("order_complete", GlobalOrders.get_order_index(order))
				body.anim.play("DELETE")
				
				if order['emergency']:
					GlobalOrders.emergency = false
