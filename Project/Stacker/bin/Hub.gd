extends Node2D
####################################################
#
#           Kyletc.com
#
#           Hub.gd: (Singleton)
#
#          
#
#\
####################################################
#Declarations


var highScores = []

####################################################
#Virtual Functions


func _ready():

	loadHighScores()








####################################################
#Setters/Getters









####################################################
#Private Functions










####################################################
#Public Functions

func saveHighScores(argName,argLevel):
	highScores.append(argName)
	highScores.append(argLevel)
	var temp = ""
	for items in highScores:
		temp+="\n"+items
	var newFile = File.new()
	
	newFile.open("user://highScores.txt",File.WRITE)
	newFile.store_string(temp)
	newFile.close()

func loadHighScores():
	var newFile = File.new()
	var temp
	if newFile.file_exists("user://highScores.txt"):
		newFile.open("user://highScores.txt",File.READ)
		temp = newFile.get_as_text()
		newFile.close()
		highScores = temp.split("\n")

	

