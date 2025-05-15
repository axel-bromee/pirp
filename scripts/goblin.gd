extends CharacterBody2D
@onready var health_label: Label = $health
@onready var ivincebilyt_frames: Timer = $ivincebilyt_frames
var speed = 100
var health = 100
var damage = 25
var can_take_damage = true

var direction = Vector2.ZERO
var burn_damage = 0
var burn_time = 0

func _ready():
	direction = (Vector2.LEFT).normalized()


func _process(delta):
	position += direction * speed * delta
	health_label.text = str(int(health))
	if health <= 0:
		kill()


func _on_hitbox_area_entered(area: Area2D):
	if "burn" in area and can_take_damage:
		burn_damage = area.get("damage")
		burn_time = area.get("burn")
		burn()
	elif "damage" in area and can_take_damage:
		health -= area.damage
		can_take_damage = false
		ivincebilyt_frames.start()

func burn():
	for i in range(burn_time):
		await get_tree().create_timer(0.5).timeout
		health -= burn_damage

func kill():
	queue_free()


func _on_ivincebilyt_frames_timeout():
	can_take_damage = true
