extends Marker2D
@onready var goblin_sceen = preload("res://scens/goblin.tscn")
@onready var label_round: Label = $"../CanvasLayer/round"
@onready var label_goblins: Label = $"../CanvasLayer/goblins"
@onready var spawn_time: Timer = $spawn_interwal
var rand_x
var rand_y

var rounds = 1

var goblins_extra = 0
var goblins = 10
var spawn_interval = 5

func _ready():
	spawn_time.start(spawn_interval)
	

@warning_ignore("unused_parameter")
func _process(delta):
	label_goblins.text = str(goblins)
	label_round.text = str(rounds)

func _on_spawn_interwal_timeout():
	if goblins == 0:
		rounds += 1
		goblins_extra += 5
		goblins = 10 + goblins_extra
		
		
	
	
	goblins -= 1
	var goblin = goblin_sceen.instantiate()
	rand_y = randi_range(-0,0)
	rand_x = randi_range(-100,100)
	goblin.position = position + Vector2(rand_y,rand_x)
	get_parent().add_child(goblin)
	spawn_time.start(spawn_interval)
	
