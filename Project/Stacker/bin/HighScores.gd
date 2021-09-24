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
	var highScoreList = hub.loadHighScores()

	highScoreList = highScoreList.split("\n")

	var memName = ""
	var memData = ""
	var mem = "Name"
	var positionJumper = 100
	var counter = 1
	for item in highScoreList:

		match mem:
			"Name":
				memName = item
				mem = "Data"
			"Data":
				memData = item
				mem = "Name"

				var newScore = preload("res://scenes/Score.tscn").instance()
				add_child(newScore)
				newScore.position.x = 100
				newScore.position.y = positionJumper
				newScore.setStats(memName,memData,counter)
				counter+=1
				positionJumper+= 40
				scores.append(newScore)

			







####################################################
#Public Functions

func closeHighScores():
	emit_signal("closed")
	get_parent().remove_child(self)
	