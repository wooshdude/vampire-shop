extends Node
class_name Order

@export var recipe = {
	"blood-type": {
		"type": "",
		"polarization": ""
	},
	"ingredients": []  # Array of ingrendients
}


func new_order():
	recipe['blood-type'].clear()
	recipe['ingredients'].clear()
	
	var types = ["a", "b", "o", "ab"]
	var polarities = ['+', '-']
	var ingredients = ["iron", "calcium", "insulin"]
	
	recipe['blood-type']['type'] = types[randi_range(0, len(types)-1)]
	recipe['blood-type']['polarization'] = polarities[randi_range(0, len(polarities)-1)]
	
	for i in randi_range(1, 3):
		recipe['ingredients'].append(ingredients.pop_at(randi_range(0, len(ingredients)-1)))
	
	return recipe


func check_order(order: Dictionary):
#	print(recipe['blood-type'])
#	print(order['blood-type'])
	if recipe['blood-type']['type'] != order['blood-type']['type']: return false
	if recipe['blood-type']['polarization'] != order['blood-type']['polarization']: return false
	for item in order["ingredients"]:
		if not recipe["ingredients"].has(item):
			return false
	if not len(recipe["ingredients"]) == len(order["ingredients"]): return false
	
	return true


func add_blood(type: String):
	print(type)
	if recipe['blood-type']['type'] == "": 
		recipe['blood-type']['type'] = type
	
	if type in ['a', 'b'] and recipe['blood-type']['type'] in ['a', 'b']:
		print('is type a or b')
		if not type == recipe['blood-type']['type']:
					recipe['blood-type']['type'] = 'ab'
	else:
		recipe['blood-type']['type'] = type


func polarize(type: String):
	recipe['blood-type']['polarization'] = type


func add_ingredient(ingredient: String):
	print(ingredient)
	if not ingredient in recipe['ingredients']:
		recipe['ingredients'].append(ingredient)
