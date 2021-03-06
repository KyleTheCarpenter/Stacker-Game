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

func startPressed():
	myMenuChoice = "Start"
	PursueChoice()

func hPressed():
	myMenuChoice = "HighScores"
	PursueChoice()

func _input(_event):
	if not menuPause:
		if Input.is_action_just_pressed("moveSelector"):
			changeMenuChoice()
			MoveSelector()
		
	



####################################################
#Setters/Getters

func setMenuChoice(arg): myMenuChoice = arg
func getMenuChoice(): return myMenuChoice






####################################################
#Private Functions

func MoveSelector(): #Moves the Selector Node
	
	
	match getMenuChoice():	
		"Start":
			get_node("Selector").set_position(get_node("lblStart").get_position())

		"HighScores":
			get_node("Selector").set_position(get_node("lblHighScores").get_position())

	get_node("Selector").set_position(Vector2(get_node("Selector").get_position().x,get_node("Selector").get_position().y-20))
	
func changeMenuChoice(): #called by Up/Down Key or hoverd Buttons
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
			
		"HighScores":
			scene = preload("res://scenes/HighScores.tscn").instance()
			get_parent().add_child(scene)
			scene.connect("closed",self,"reloadMenu")

####################################################
#Public Functions
func reloadMenu():
	menuPause = false
	myMenuChoice = "HighScores"
func StartHovered():
	if (myMenuChoice == "HighScores"):
		changeMenuChoice()
		MoveSelector()
func HighScoresHovered():
	
	if (myMenuChoice == "Start"):
		changeMenuChoice()
		MoveSelector()




