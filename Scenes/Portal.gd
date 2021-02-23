extends Sprite

export(String, FILE, "*.tscn") var world_scene

func _ready():
	$Area2D.connect("body_entered", self, "_on_Area2D_body_entered")

###
#func _physics_process(delta):
#	var overlap = $Area2D.get_overlapping_bodies()
#	for body in overlap:
#		if body.name == "Player":
#			#SceneTree.
#			get_tree().change_scene(world_scene)

			
func _on_Area2D_body_entered(body):
	if body.name == "Player":
		Globals.emit_signal("change_level", world_scene)
			
