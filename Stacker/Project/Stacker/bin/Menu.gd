extends Node2D
####################################################
#
#           Kyletc.com
#
#           Menu.gd: (Trunk/Menu)
#
#           Controls Main Menu
#
####################################################





"""
STACK


"""

#\
####################################################
#Declarations

var myMenuChoice : String = "Start"
var menuPause: bool = false
onready var hub = get_node("/root/Hub")


####################################################
#Virtual Functions


func _ready():
	MoveSelector()


func _input(_event):
	if not menuPause:
		if Input.is_action_just_pressed("moveSelector"):
			changeMenuChoice()
			MoveSelector()
		elif Input.is_action_just_pressed("enter"):
			PursueChoice()
	



####################################################
#Setters/Getters

func setMenuChoice(arg): myMenuChoice = arg
func getMenuChoice(): return myMenuChoice






####################################################
#Private Functions

func MoveSelector(): #Moves the Selector Node
	
	hub.debugTitle("Moving Selector")
	match getMenuChoice():	
		"Start":
			get_node("Selector").set_position(get_node("lblStart").get_position())

		"HighScores":
			get_node("Selector").set_position(get_node("lblHighScores").get_position())

	get_node("Selector").set_position(Vector2(get_node("Selector").get_position().x,get_node("Selector").get_position().y-20))
	hub.debug("After Move Selector Pos x:",str(get_node("Selector").get_position().x)+" y:"+str(get_node("Selector").get_position().y))
func changeMenuChoice(): #called by Up/Down Key or hoverd Buttons
	hub.debugTitle("Change Menu Choice")
	match myMenuChoice:
		"Start":
			myMenuChoice = "HighScores"

		"HighScores":
			myMenuChoice = "Start"

			
func PursueChoice():
	menuPause = true
	var scene
	match myMenuChoice:
		"Start":
			scene = preload("res://scenes/Game.tscn").instance()
			get_parent().add_child(scene)
			scene.connect("closed",self,"reloadMenu")
		"HighScores":
			scene = preload("res://scenes/HighScores.tscn").instance()
			get_parent().add_child(scene)
			scene.connect("closed",self,"reloadMenu")

####################################################
#Public Functions
func reloadMenu():
	menuPause = false
func StartHovered():
	hub.debugTitle("Hover Highscores")
	hub.debug("myChoice",myMenuChoice)

	if (myMenuChoice == "HighScores"):
		changeMenuChoice()
		MoveSelector()
func HighScoresHovered():
	if (myMenuChoice == "Start"):
		changeMenuChoice()
		MoveSelector()




