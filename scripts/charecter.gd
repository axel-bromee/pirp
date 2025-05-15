extends CharacterBody2D
@onready var bullet_sceen = preload("res://scens/bullet.tscn")
@onready var Fire_wall_sceen = preload("res://scens/fire_wall.tscn")
@onready var label_mana: Label = $"../CanvasLayer/mana"
@onready var mana_coldown = $mana_coldown
@onready var fire_coldown = $fire_coldown



var speed = 100  # speed in pixels/sec
var max_mana = 100
var mana = 100
var mana_regen_rate = 10
var can_regen = true
var regen_time = 1
var fire_rate = 1
var can_fire = true

func _ready():
	pass

func _process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	label_mana.text = "mana" + str(int(mana))
	if can_regen and mana < max_mana:
		mana += mana_regen_rate * delta
		mana = clamp(mana,0,max_mana)
	
	if can_fire == false:
		label_mana.label_settings.font_color = Color(1,0,0)
	else:
		label_mana.label_settings.font_color = Color(0,1,0)

	if Input.is_action_pressed("shot") and can_fire and mana >= 10:
		shot()
	if Input.is_action_pressed("second_shot") and can_fire and mana >= 50:
		second_shot()

	move_and_slide()

func shot():
	mana -= 10
	can_regen = false
	can_fire = false
	var bullet = bullet_sceen.instantiate()
	bullet.position = position
	get_parent().add_child(bullet)
	fire_coldown.start(fire_rate)
	mana_coldown.start(regen_time)

func second_shot():
	mana -= 50
	can_regen = false
	can_fire = false
	var fire_wall = Fire_wall_sceen.instantiate()
	fire_wall.position = position
	get_parent().add_child(fire_wall)
	fire_coldown.start(fire_rate * 2)
	mana_coldown.start(regen_time)


func _on_mana_coldown_timeout():
	can_regen = true


func _on_fire_coldown_timeout():
	can_fire = true
