extends Area2D
var vel = Vector2()
export var speed = 1000

func _ready():
	set_physics_process(true)

func start_at(dir, pos):
	set_rotation(dir)
	set_position(pos)
	vel = Vector2(speed, 0).rotated(dir)

func _physics_process(delta):
	set_position(get_position() + vel * delta)


func _on_Bullet_body_entered(body):
	if ("Dinosaur" in body.name):
		body._die()
		#Update score
		$"../World"._update_score()
		
	
	self.queue_free()
	
