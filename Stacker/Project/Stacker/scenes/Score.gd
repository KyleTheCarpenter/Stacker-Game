extends Node2D
####################################################
#
#           Kyletc.com
#
#           Menu.gd: (Trunk/Menu)
#
#           Controls Main Menu
#









#\
####################################################
#Declarations





####################################################
#Virtual Functions


func _ready():
	pass 








####################################################
#Setters/Getters









####################################################
#Private Functions










####################################################
#Public Functions

func setStats(argN,argD,counter):
	get_node("data").text = argD
	get_node("name").text = argN
	get_node("number").text = str(counter)