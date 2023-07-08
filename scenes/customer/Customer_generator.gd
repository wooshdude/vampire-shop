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
var hobbyPreferences = ["walking.", "bird watching.", "sleeping.", "making music"]
var vampFoodPreferences = ["Likes blood.", "Likes the moon.", "Likes coffins.", "Dislikes garlic.", "Dislikes medeival weapons."]
var vampHobbyPreferences = ["bat watching.", "flying.", "playing the violin.", "brooding in the darkness."]
var vampire

var body: Sprite2D
var eyes: Sprite2D
var hair: Sprite2D
var mouth: Sprite2D
var nose: Sprite2D

func _ready():
	orderGen() #temp
	body = get_node("Customer/Body")
	eyes = get_node("Customer/Eyes")
	hair = get_node("Customer/Hair")
	mouth = get_node("Customer/Mouth")
	nose = get_node("Customer/Nose")
	spriteGen()

func orderGen()-> void: #generates next customer whenever called
	orderName.append(names.pick_random())
	vampire = randi_range(0,5)
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
	self.orderNum+=1

func spriteGen()->void:
	var ranMouth = randi_range(0,3)
	var mouthArr = ["assets/customer/mouth/Angry.PNG", "assets/customer/mouth/Happy.PNG"]
	var vampMouthArr = ["assets/customer/mouth/AngryBlood.PNG", "assets/customer/mouth/AngryVamp.PNG", "assets/customer/mouth/HappyBlood.PNG", "assets/customer/mouth/HappyVamp.PNG"]
	if vampire==3 and randi()%2==0: #50% chance to get vamp skin if vamp
		body.texture = load("assets/customer/body/VampBase.PNG")
		mouth.texture = load(vampMouthArr[ranMouth])
		print("vamp")
	else:
		body.texture = load("assets/customer/body/Base"+str(randi_range(1,3))+".PNG")
		mouth.texture = load(mouthArr[ranMouth%2])
		print("not vamp")
	eyes.texture = load("assets/customer/eyes/Eyes"+str(randi_range(1,5))+".PNG")
	hair.texture = load("assets/customer/hair/Hair"+str(randi_range(1,4))+".PNG")
