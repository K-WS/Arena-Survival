extends Node

var pos_l = Vector2(-310, 166)
var pos_r = Vector2(1193,166)
var spawnpoints = []
var spawntime = 0
var maxtime = 2
var timeup = 0
var timeupdate = 20
var score = 0

var rng = RandomNumberGenerator.new()

onready var dino1 = preload("res://Objects/Dinosaur.tscn")
onready var dino2 = preload("res://Objects/Dinosaur_Runner.tscn")
onready var dino3 = preload("res://Objects/Dinosaur_Slower.tscn")
var dinos = []
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	spawnpoints.append(pos_l)
	spawnpoints.append(pos_r)
	
	dinos.append(dino1)
	dinos.append(dino2)
	dinos.append(dino3)
	
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var rnd_side = rng.randi_range(0, 1)
	var rnd_dino = rng.randi_range(0, 2)
	
	spawntime += delta
	timeup += delta
	
	if(spawntime >= maxtime):
		spawntime = 0
		var dino = dinos[rnd_dino].instance()
		get_node("/root").add_child(dino)
		dino.position = spawnpoints[rnd_side]
		if(rnd_side == 0):
			dino._flipAnim()
			
	if (timeup >= timeupdate):
		timeup = 0
		maxtime = maxtime/1.5
		
	pass
	
func _update_score():
	score += 1
	$"../World/CanvasLayer/Label".text = "Score: " + str(score)
	
func _reset_game():
	score = 0
	$"../World/CanvasLayer/Label".text = "Score: " + str(score)
	var spawntime = 0
	var maxtime = 2
	var timeup = 0
	var timeupdate = 20
	var score = 0
	
	for _i in self.get_tree().get_root().get_children():
		if ("Dinosaur" in _i.name):
			_i.queue_free()
