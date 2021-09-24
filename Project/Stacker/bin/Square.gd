extends Node2D
####################################################
#
#           Kyletc.com
#
#           Square.gd: (Square)
#
#           Controls Square
#









#\
####################################################
#Declarations
signal left
signal right
               #          |x||x||x|
var myDirection = "Right"#Stop Left Right
var mySpot = 0 # |x||x||x||x||x||x||x||x||x||x||x||x| 12 total
var myHeight = 1 #max 10
var mySpeed = 25
var startPosX = 250
var startPosY = 518
var safe = false

####################################################
#Virtual Functions


func _ready():
	pass

func _process(_delta):
	if myDirection == "Down":
		position.y+=2

	if position.y > startPosY :
		get_parent().remove_child(self)
####################################################
#Setters/Getters

func fallDown():
	myDirection = "Down"

func setSpot(arg):
	 mySpot = arg
	 position.x = startPosX + arg*mySpeed

func getSpot(): return mySpot

func setHeight(arg): 
	myHeight = arg
	position.y = startPosY - arg*mySpeed	

func getHeight(): return myHeight

func setSpeed(arg): mySpeed = arg
func getSpeed(): return mySpeed

func setDirection(arg): myDirection = arg
func getDirection(): return myDirection


####################################################
#Private Functions


func placeSquareY(arg):
	setHeight(arg)
	


func MoveSideways():
	
		
	match myDirection:
		"Left":
			mySpot -=1
			position.x -= mySpeed
		"Right":
			mySpot +=1
			position.x += mySpeed
	
	if mySpot < 0:
		emit_signal("left")
		setSpot(1)
	
		
		
	elif mySpot > 11:
		emit_signal("right")
		






####################################################
#Public Functions

func stopSquare():
	get_parent().remove_child(self)