extends Node2D

#all generated orders are stored in these arrays so that they can be checked easily
var orderName = [] 
var orderBloodType = []
var preferencesList = [] #description on patient sheet
var orderDifficulty = [] #higher difficulty, shorter time
var orderVampire = [] #boolean if customer is vampire
var orderNum = 0 
var bloodType = ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"]
var names = ["Jessie", "Avery", "Alex", "John", "Rowan", "Morgan", "Casey"]
var foodPreferences = ["Likes bacon", "Likes salads", "Likes coffee", "Dislikes waiting", "Dislikes cats"]
var hobbyPreferences = ["walking.", "bird watching.", "sleeping."]
var vampFoodPreferences = ["Likes blood.", "Likes the moon.", "Likes coffins.", "Dislikes garlic.", "Dislikes medeival weapons."]
var vampHobbyPreferences = ["bat watching.", "flying.", "playing the violin."]

func _ready():
	orderGen() #temp

func orderGen()-> void: #generates next customer whenever called
	orderName.append(names.pick_random())
	var vampire = randi_range(0,5)
	orderDifficulty.append(randi_range(1, 2))
	if (orderNum>0 and (orderNum-1)%5==0): 
		orderDifficulty[orderNum] = 3
	orderBloodType.append(bloodType.pick_random())
	if(vampire==3):
		orderVampire.append(true)
		preferencesList.append(vampFoodPreferences.pick_random() + ". Favourite activity is " +  vampHobbyPreferences.pick_random())
	else:
		orderVampire.append(false)
		preferencesList.append(foodPreferences.pick_random() + ". Favourite activity is " + hobbyPreferences.pick_random())
	#print(orderName[orderNum])
	#print(orderBloodType[orderNum])
	#print(preferencesList[orderNum])
	#print(orderDifficulty[orderNum])
	#print(orderVampire[orderNum])
	orderNum+=1
