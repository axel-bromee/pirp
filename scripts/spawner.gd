extends Marker2D
@onready var goblin_sceen = preload("res://scens/goblin.tscn")
@onready var Goblin_script = preload("res://scripts/goblin.gd")
@onready var CARD = preload("res://scens/card.tscn")
@onready var pause_button: Button = $"../CanvasLayer/PauseButton"
@onready var label_round: Label = $"../CanvasLayer/round"
@onready var label_goblins: Label = $"../CanvasLayer/goblins"

var rand_x
var rand_y
var paused = false

var rounds = 0
var round_clear = false
var goblins_extra = 0
var goblin_amount = 0
var goblins_left = 0
var spawn_interval = 0

func _ready():
	pass

@warning_ignore("unused_parameter")
func _process(delta):
	label_goblins.text = str(goblins_left + get_parent().get_node("enemies").get_child_count())
	label_round.text = str(rounds)
	if goblins_left + get_parent().get_node("enemies").get_child_count() == 0 and rounds % 1 == 0 and round_clear == true:
		round_finished()

func next_round():
		round_clear = true
		rounds += 1
		goblins_extra += 5
		goblin_amount = 5 + goblins_extra
		goblins_left = goblin_amount
		spawn_goblin()

func spawn_goblin():
	for i in range(goblin_amount):
		goblins_left -= 1
		var goblin = goblin_sceen.instantiate()
		rand_y = randi_range(-0,0)
		rand_x = randi_range(-100,100)
		goblin.position = position + Vector2(rand_y,rand_x)
		get_parent().get_node("enemies").add_child(goblin)
		await get_tree().create_timer(spawn_interval).timeout
		
func round_finished():
	for i in range(3):
		var card = CARD.instantiate()
		get_parent().get_node("CanvasLayer/HBoxContainer").add_child(card)
	round_clear = false


func _on_pause_button_pressed() -> void:
	if paused == false:
		process_mode = Node.PROCESS_MODE_DISABLED
		pause_button.text = "paused"
		paused = true
	elif paused == true:
		process_mode = Node.PROCESS_MODE_ALWAYS
		pause_button.text = "pause"
		paused = false


func _on_nextround_pressed():
	if get_parent().get_node("enemies").get_child_count() == 0 and goblins_left == 0:
		next_round()
		
