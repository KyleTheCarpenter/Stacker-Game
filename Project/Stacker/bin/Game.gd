
   
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

var player = [] #array of Square.tscn
var playerCache = []
var holderPlacement = []
var allowedToPlace = false
var pause = false
var heightCount = 1
var playerCounter = 5
var gameSpeed = .5
var firstTime = true

onready var hub = get_node("/root/Hub")



####################################################
#Virtual Functions


func _ready():
	get_node("dataLevel").text = str(heightCount)


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
	if temp > 12:
		temp = 12
	if clock >= 20-temp :
		movePlayer()
		clock = 0


func playAgain():
	switchMenus("Start")

####################################################
#Setters/Getters









####################################################
#Private Functions
func recordPlacement():
	
	holderPlacement.clear()
	for items in player:
		
		holderPlacement.append(items.getSpot())

func loadSquare(argSpot,argHeight,origDirection):
	
	var square = preload("res://scenes/Square.tscn").instance()
	get_node("screen").add_child(square)
	square.setSpot(argSpot)
	if argHeight < 10:
		square.setHeight(argHeight)
	if argHeight >=10:
		square.setHeight(10)
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
	var i = 0
	while i < playerCounter:
		loadSquare(i,1,"Right")
		i+=1
	
	


func movePlayer():
	#check if at end of screen


	#move items
	for items in player:
		items.MoveSideways()
	





####################################################
#Public Functions

func spawnFallingSquare(arg):
	var squareFall = preload("res://scenes/Square.tscn").instance()
	get_node("screen").add_child(squareFall)
	squareFall.position = arg.position
	squareFall.get_node("blue").visible = true
	squareFall.fallDown()
func finishFinish():
	for items in playerCache:
		items.visible = false
	get_node("Finish").visible = true	

func StartPlay():
	
	startGame()
	allowedToPlace = true

func ActionPressed():
	if !pause && allowedToPlace:
		if firstTime:
			firstTime = false
		
		
	
		
			


	
		
		var wins = 0

		if !holderPlacement.empty():
			for squares in player:
				squares.safe = false
				
				

			for squares in player:
				var found = false
				for items in holderPlacement:
					
			
					if squares.getSpot() == items:
						found = true
				if found == false:
					squares.safe = false
					squares.visible = false
					spawnFallingSquare(squares)
					wins +=1

						
		for items in player:
			if items.visible == true:
				items.get_node("AnimationPlayer").play("hit")
			if items.visible == false:
				remove_child(items)
				player.erase(items)
				
					
					
					
		
		
		playerCounter-= wins
		recordPlacement()
	
		if playerCounter <= 0:
			pause = true
			get_node("dataLevel/Time").visible = true
			get_node("dataLevel/Time").text = "Nice Try"
			match heightCount:
				0,1:
					get_node("dataLevel/Time").text = "Stack Ontop"
				2,3,4,5:
					get_node("dataLevel/Time").text = "You Dont Get It"

				6,7,8,9:
					get_node("dataLevel/Time").text = "Fail"
				10,11,12,13,14,15:
					get_node("dataLevel/Time").text = "Low Effort"
				16,17,18,19,20,21,22,23,24,25:
					get_node("dataLevel/Time").text = "Grandmother"
				26,27,28,29,30,31,32,33,34,35:
					get_node("dataLevel/Time").text = "Decent"
				36,37,38,39,40,41,42,43,44,45:
					get_node("dataLevel/Time").text = "Nice Miss Lol"
				46,47,48,49,50,51,52,53,54,55:
					get_node("dataLevel/Time").text = "Swing n a MISS"
				57,58,59,60,61,62,63,64:
					get_node("dataLevel/Time").text = "Heather Tier"

			get_node("Finish/Timer").start()
			return

		gameSpeed = .5 - (heightCount /16)
		var firstSpotX = player[0].getSpot()
		var origDirection = player[0].getDirection()
		
		for items in player:
			playerCache.append(items)
		recordPlacement()
		player.clear()

		heightCount+=1
		
		var tempPlayerCounter = 0
		
		while tempPlayerCounter < playerCounter:
			loadSquare(firstSpotX,heightCount,origDirection)
			firstSpotX+=1
			tempPlayerCounter+=1
			get_node("dataLevel").text = str(heightCount)

		if heightCount > 10:
			get_node("screen/jumpView").position.y+=25
			for items in playerCache:
				items.position.y+= 25
				if items.position.y >= items.startPosY:
					items.visible = false
				
		allowedToPlace = true
		recordPlacement()
	
func closeStart():
	switchMenus("HighScores")
 
func switchMenus(argS):
	player.clear()
	playerCache.clear()
	holderPlacement.clear()
	get_node("Finish").visible = false
	if get_node("Finish/data").text!= "":
		hub.saveHighScores(get_node("Finish/data").text,get_node("dataLevel").text)
	get_parent().get_node("Menu").myMenuChoice = argS
	get_parent().get_node("Menu").PursueChoice()
	get_parent().remove_child(self)
