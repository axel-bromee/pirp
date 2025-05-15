extends Marker2D
@onready var goblin_sceen = preload("res://scens/goblin.tscn")
@onready var Goblin_script = preload("res://scripts/goblin.gd")
@onready var pause_button: Button = $"../CanvasLayer/PauseButton"
@onready var label_round: Label = $"../CanvasLayer/round"
@onready var label_goblins: Label = $"../CanvasLayer/goblins"
@onready var spawn_time: Timer = $spawn_interwal

var rand_x
var rand_y
var paused = false

var rounds = 1

var goblins_extra = 0
var goblin_amount = 10
var goblins_left = 10
var spawn_interval = 5

func _ready():
	spawn_time.start(1)

func check_if_all_enemies_dead():
	if Goblin.dead_goblins == goblin_amount:
		process_mode = Node.PROCESS_MODE_DISABLED

@warning_ignore("unused_parameter")
func _process(delta):
	label_goblins.text = str(goblins_left)
	label_round.text = str(rounds)
	print(goblins_left)
	print(get_parent().get_node("enemies").get_child_count())
	if goblins_left == 0:
		rounds += 1
		goblins_extra += 5
		goblin_amount= 10 + goblins_extra
		goblins_left = goblin_amount
		Goblin.dead_goblins = 0
	

func _on_spawn_interwal_timeout():
	if not paused:
		spawn_goblin()

func spawn_goblin():
	goblins_left -= 1
	var goblin = goblin_sceen.instantiate()
	rand_y = randi_range(-0,0)
	rand_x = randi_range(-100,100)
	goblin.position = position + Vector2(rand_y,rand_x)
	get_parent().get_node("enemies").add_child(goblin)
	spawn_time.start(spawn_interval)


func _on_pause_button_pressed() -> void:
	if paused == false:
		process_mode = Node.PROCESS_MODE_DISABLED
		pause_button.text = "paused"
		paused = true
	elif paused == true:
		process_mode = Node.PROCESS_MODE_ALWAYS
		pause_button.text = "pause"
		paused = false
