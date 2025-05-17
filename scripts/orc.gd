extends CharacterBody2D
@onready var health_label: Label = $Health
@onready var timer: Timer = $Timer
var speed = 20
var health = 300
var direction_change = 1
var direction_mode = "down"
var damage = 25
var direction = Vector2.ZERO
var burn_damage = 0
var burn_time = 0
var burning = false
func _ready():
	pass


func _process(delta):
	health_label.text = str(health)
	if direction_mode == "up":
		direction = (Vector2.LEFT) + (Vector2.UP).normalized()
		position += direction * speed * delta
		await get_tree().create_timer(2).timeout
		direction_mode = "down"
	elif direction_mode == "down":
		direction = (Vector2.LEFT) + (Vector2.DOWN).normalized()
		position += direction * speed * delta
		await get_tree().create_timer(2).timeout
		direction_mode = "up"
	if health <= 0:
		kill()




func _on_hitbox_area_entered(area: Area2D):
	if "burn" in area:
		burn_damage = area.get("damage")
		burn_time = area.get("burn")
		burn()
	elif "damage" in area:
		health -= area.damage

func burn():
	burning = true
	for i in range(burn_time):
		await get_tree().create_timer(0.5).timeout
		health -= burn_damage
	burning = false

func kill():
	queue_free()
