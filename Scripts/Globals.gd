extends Node

signal change_level(levelname)


func _ready():
	Globals.connect("change_level", self, "ChangeLevel")
	pass
	
func ChangeLevel(levelname):
	print(levelname)
	get_tree().change_scene(levelname)
	pass


