extends Node

var orders: Array[Dictionary]
var emergency = false

signal order_complete(index)
signal order_finished


func get_order_index(order):
	return orders.find(order)

