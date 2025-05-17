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
var damage_modifier = 0
var spread_shot = false
var mana_bullet_cost = 0
var mana_wall_cost = 0

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

	if Input.is_action_pressed("shot") and can_fire and mana >= mana_bullet_cost and !is_mouse_over_ui():
		shot()
	if Input.is_action_pressed("second_shot") and can_fire and mana >= mana_wall_cost:
		second_shot()

	move_and_slide()
	
func is_mouse_over_ui() -> bool:
	return get_viewport().gui_get_hovered_control() != null

func shot():
	if spread_shot == false:
		damage_modifier = 50
		mana_bullet_cost = 10
		mana -= mana_bullet_cost
		can_regen = false
		can_fire = false
		var bullet = bullet_sceen.instantiate()
		bullet.position = position
		bullet.damage = damage_modifier
		bullet.bullet_direction = (Vector2.RIGHT).normalized()
		get_parent().add_child(bullet)
		fire_coldown.start(fire_rate)
		mana_coldown.start(regen_time)
	elif spread_shot == true:
		mana_bullet_cost = 20
		damage_modifier = 50
		mana -= mana_bullet_cost
		can_regen = false
		can_fire = false
		
		var bullet1 = bullet_sceen.instantiate()
		bullet1.position = position
		bullet1.damage = damage_modifier
		bullet1.bullet_direction = (Vector2.RIGHT).normalized()
		get_parent().add_child(bullet1)
		
		var bullet2 = bullet_sceen.instantiate()
		bullet2.position = position
		bullet2.damage = damage_modifier * 0.5
		bullet2.bullet_direction = (Vector2(5,-1)).normalized()
		get_parent().add_child(bullet2)
		
		var bullet3 = bullet_sceen.instantiate()
		bullet3.position = position
		bullet3.damage = damage_modifier * 0.5
		bullet3.bullet_direction = (Vector2(5,1)).normalized()
		get_parent().add_child(bullet3)
		
		fire_coldown.start(fire_rate)
		mana_coldown.start(regen_time)

func second_shot():
	mana_wall_cost = 50
	mana -= mana_wall_cost
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
