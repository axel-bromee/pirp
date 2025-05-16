extends Marker2D
@onready var goblin_sceen = preload("res://scens/goblin.tscn")
@onready var label_round: Label = $"../CanvasLayer/round"
@onready var spawn_time: Timer = $spawn_interwal
var rand_x
var rand_y

var round = 1

var goblins = 10

var spawn_interval = 5

func _ready():
	spawn_time.start(spawn_interval)
	

func _process(delta):
	pass

func _on_spawn_interwal_timeout():
	if goblins == 0:
		round += 1
		goblins = 10
		label_round.text = str(round)
		
	
	
	goblins -= 1
	var goblin = goblin_sceen.instantiate()
	rand_y = randi_range(-0,0)
	rand_x = randi_range(-100,100)
	goblin.position = position + Vector2(rand_y,rand_x)
	get_parent().add_child(goblin)
	spawn_time.start(spawn_interval)
	
