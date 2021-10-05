extends Node2D
####################################################
#
#           Kyletc.com
#
#           HighScore.gd: (root/HighScore)
#
#           Controls HighScore
#









#\
####################################################
#Declarations

signal closed
onready var hub = get_node("/root/Hub")
var scores = []

####################################################
#Virtual Functions


func _ready():
	loadScores()








####################################################
#Setters/Getters









####################################################
#Private Functions

func loadScores():
	
	var memName = ""
	var memData = ""
	var mem = "Name"
	var positionJumper = 100
	var counter = 1
	for item in hub.highScores:
		if item != "":
			match mem:
				"Name":
					memName = item
					mem = "Data"
				"Data":
					memData = item
					mem = "Name"

					var newScore = preload("res://scenes/Score.tscn").instance()
					
					newScore.setStats(memName,memData,counter)
					counter+=1
					scores.append(newScore)

	var temp = []
	var holder = 0
	for items in scores:
		if int(items.get_node("data").text) > holder:
			temp.push_front(items)
			holder = int(items.get_node("data").text) 
		else:
			temp.push_back(items)



	for newScore in temp:
		newScore.position.x = 100
		newScore.position.y = positionJumper
		positionJumper+= 40
		add_child(newScore)
					

			







####################################################
#Public Functions

func closeHighScores():
	emit_signal("closed")
	get_parent().remove_child(self)
	