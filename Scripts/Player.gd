extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var motion = Vector2(0, 0)
const GRAVITY = 10
const UP = Vector2(0, -1)


const ACCELERATION = 800
const MAXSPEED = 400

export(float) var moveSpeed = 200
export(float) var jumpSpeed = 400

onready var BULLET = preload("res://Objects/Bullet.tscn")
var mousedown = true

# Called when the node enters the scene tree for the first time.
func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	motion.y += GRAVITY
	var animation = "idle"
	var friction = false
	
	if (Input.is_action_pressed("ui_left")):
		#motion.x -= ACCELERATION
		motion.x = max(motion.x - ACCELERATION * delta, -MAXSPEED)
		$AnimatedSprite.flip_h = true
		animation = "run"
	elif (Input.is_action_pressed("ui_right")):
		#motion.x = moveSpeed
		motion.x = min(motion.x + ACCELERATION * delta, MAXSPEED)
		$AnimatedSprite.flip_h = false
		animation = "run"
	else:
		friction = true
		#motion.x = 0

	if (is_on_floor()):	
		if (Input.is_action_just_pressed("ui_up")):
			motion.y -= jumpSpeed
		#motion.x = lerp(motion.x, 0, 0.05)
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2)
	else:
		animation = "jump"
		#motion.x = lerp(motion.x, 0, 0.05)
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.08)
	$AnimatedSprite.play(animation)
	
	motion = move_and_slide(motion, UP)
	#motion = move_and_collide(motion)
	
	
	var mouse = get_global_mouse_position() - global_position
	
	mouse = mouse.normalized() * 25
	$Aimer.position = mouse
	$Aimer.look_at(global_position)
	
	#for i in get_slide_count():
	#	var collision = get_slide_collision(i)
	#	if(collision.collider.name == "Dinosaur"): #has to be slightly modified
	#		print("collided")
	

#func _process(delta):
#	if Input.is_mouse_button_pressed(1):
#		var bullet = BULLET.instance()
#		get_node("/root").add_child(bullet)
#		bullet.position = $Aimer.position
	
func _input(event):
	if event is InputEventMouseButton:
		if mousedown == true:
			var bullet = BULLET.instance()
			get_node("/root").add_child(bullet)
			bullet.start_at($Aimer.rotation - PI, $Aimer.global_position)
			#print($Aimer.rotation)
		mousedown = !mousedown
