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

func closeHighScores():
	emit_signal("closed")
	get_parent().remove_child(self)
	