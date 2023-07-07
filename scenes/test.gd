extends Node2D

func _ready():
	var foo_order = Order.new()
	
	#foo_order.new_order()
	foo_order.add_blood('b')
	print(foo_order.recipe)
	
	foo_order.add_blood('a')
	print(foo_order.recipe)
