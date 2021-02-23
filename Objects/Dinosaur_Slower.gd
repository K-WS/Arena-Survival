extends KinematicBody2D


# Declare member variables here


var motion = Vector2(0, 0)
const GRAVITY = 10
const UP = Vector2(0, -1)


const ACCELERATION = 30
const MAXSPEED = 30

export(float) var moveSpeed = 30
#export(float) var jumpSpeed = 400

var moveRight = false
var dead = false
var currAnim = "idle"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	if (!dead):
		motion.y += GRAVITY
		currAnim = "idle"
		var friction = false
		
		if !moveRight:
			#motion.x -= ACCELERATION
			motion.x = max(motion.x - ACCELERATION * delta, -MAXSPEED)
			$AnimatedSprite.flip_h = true
			currAnim = "walk"
		elif moveRight:
			#motion.x = moveSpeed
			motion.x = min(motion.x + ACCELERATION * delta, MAXSPEED)
			$AnimatedSprite.flip_h = false
			currAnim = "walk"
		#else:
		#	friction = true
			#motion.x = 0

		#if (is_on_floor()):	
			#if (Input.is_action_just_pressed("ui_up")):
			#	motion.y -= jumpSpeed

			#if friction == true:
			#	motion.x = lerp(motion.x, 0, 0.2)
		#else:
		#	animation = "jump"
		#	#motion.x = lerp(motion.x, 0, 0.05)
		#	if friction == true:
		#		motion.x = lerp(motion.x, 0, 0.08)
		$AnimatedSprite.play(currAnim)
		
		motion = move_and_slide(motion, UP)
		
		if(is_on_wall()):
			for i in get_slide_count():
				var collision = get_slide_collision(i)
				# If one of them is a player, Attack it
				if("Player" in collision.collider.name):
					$"../World"._reset_game()
					
			_flipAnim()
		pass
		
	

func _die():
	if (!dead):
		dead = true
		currAnim = "die"
		$CollisionShape2D.set_deferred("disabled", true)
		$AnimatedSprite.play(currAnim)



func _on_Area2D_body_entered(body):
	print("Dinosaur had connection on area to ", body)
	pass # Replace with function body.


func _on_AnimatedSprite_animation_finished():
	if (currAnim == "die"):
		self.queue_free()
		
func _flipAnim():
	moveRight = !moveRight
