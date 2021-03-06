extends Node2D
####################################################
#
#           Kyletc.com
#
#           Game.gd: (root/Game)
#
#           Controls Main Menu
#









#\
####################################################
#Declarations
signal closed
var player = [] #array of Square.tscn
var playerCache = []
var holderPlacement = []
var allowedToPlace = false
var pause = false
var heightCount = 1
var playerCounter = 3
var gameSpeed = .5
var firstTime = true
onready var hub = get_node("/root/Hub")



####################################################
#Virtual Functions


func _ready():
	get_node("dataLevel").text = str(heightCount)

func _input(_event):
	if allowedToPlace:
		if !pause:
			if Input.is_action_just_pressed("ActionPressed"):
				ActionPressed()

var time = 0
var clock = 0
func _process(delta):
	time +=delta
	if time >= .01:

		doClock()
		time = 0

func doClock():
	clock+=1
	var temp = heightCount
	if temp > 18:
		temp = 18
	if clock >= 20-temp :
		movePlayer()
		clock = 0



####################################################
#Setters/Getters









####################################################
#Private Functions
func recordPlacement():
	
	holderPlacement.clear()
	for items in player:
		hub.debug("RecordingPlacement ",items.getSpot())
		holderPlacement.append(items.getSpot())

func loadSquare(argSpot,argHeight,origDirection):
	
	var square = preload("res://scenes/Square.tscn").instance()
	add_child(square)
	square.setSpot(argSpot)
	if argHeight < 12:
		square.setHeight(argHeight)
	if argHeight >=12:
		square.setHeight(12)
	square.setDirection(origDirection)
	square.connect("left",self,"changeDirectionL")
	square.connect("right",self,"changeDirectionR")
	player.append(square)
	

func changeDirectionL():
	

	for items in player:
		items.setDirection("Right")
		items.setSpot(items.getSpot())


func changeDirectionR():
	
	for items in player:
		items.setDirection("Left")
		items.setSpot(items.getSpot())	

func startGame():
	loadSquare(0,1,"Right")
	loadSquare(1,1,"Right")
	loadSquare(2,1,"Right")
	


func movePlayer():
	#check if at end of screen


	#move items
	for items in player:
		items.MoveSideways()
	





####################################################
#Public Functions

func StartPlay():
	hub.debugTitle("AnimeDone")
	startGame()
	allowedToPlace = true

func ActionPressed():
	if firstTime:
		firstTime = false
		hub.debugTitle("First time pressed")
	var counte = 0
	hub.debugTitle("Action Pressed Lets See Player Spots")
	for item in player:
		counte +=1
		hub.debug(str(counte)+" Player Spot ", str(item.getSpot()))


	hub.debugTitle("These are the holder spots")
	counte = 0
	var wins = 0
	for item in holderPlacement:
		counte +=1
		hub.debug(str(counte)+" Held Spot ", str(item))

	if !holderPlacement.empty():
		for squares in player:
			squares.safe = false
			
			

		for squares in player:
			var found = false
			for items in holderPlacement:
				
				hub.debug("Comparing " + str(squares.getSpot()), "with "+ str(items))
				if squares.getSpot() == items:
					found = true
			if found == false:
				squares.safe = false
				squares.visible = false
				wins +=1


	for items in player:
		if items.visible == false:
			get_parent().remove_child(items)
			player.erase(items)
			
				
				
				
	

	playerCounter-= wins
	recordPlacement()
	hub.debug("Misses ",wins)
	if playerCounter <= 0:
		pause = true
		for items in playerCache:
			items.visible = false
		get_node("Finish").visible = true
		return

	gameSpeed = .5 - (heightCount /16)
	var firstSpotX = player[0].getSpot()
	var origDirection = player[0].getDirection()
	
	for items in player:
		playerCache.append(items)
	recordPlacement()
	player.clear()

	heightCount+=1
	hub.debugTitle("Level" + str(heightCount))
	var tempPlayerCounter = 0
	
	while tempPlayerCounter < playerCounter:
		loadSquare(firstSpotX,heightCount,origDirection)
		firstSpotX+=1
		tempPlayerCounter+=1
		get_node("dataLevel").text = str(heightCount)

	if heightCount > 12:
		
		for items in playerCache:
			items.position.y+= 25
			if items.position.y >= 464:
				items.visible = false
			
	allowedToPlace = true
	
	
func closeStart():
	hub.saveHighScores(get_node("Finish/data").text,get_node("dataLevel").text)
	get_parent().remove_child(self)
	emit_signal("closed")
