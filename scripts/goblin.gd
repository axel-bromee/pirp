extends CharacterBody2D
class_name Goblin
@onready var health_label: Label = $health
@onready var point_light_2d: PointLight2D = $PointLight2D
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
@onready var ivincebilyt_frames: Timer = $ivincebilyt_frames

static var dead_goblins = 0

var speed = 100
var health = 100
var damage = 25

var can_take_damage = true
var direction = Vector2.ZERO
var burn_damage = 0
var burn_time = 0
var burning = false

func _ready():
	direction = (Vector2.LEFT).normalized()


func _process(delta):
	position += direction * speed * delta
	health_label.text = str(int(health))
	if burning:
		point_light_2d.color = Color(1,0,0)
		cpu_particles_2d.emitting = true
	else:
		point_light_2d.color = Color(0,1,0)
		cpu_particles_2d.emitting = false
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
	burning = true
	for i in range(burn_time):
		await get_tree().create_timer(0.5).timeout
		health -= burn_damage
	burning = false

func kill():
	dead_goblins += 1
	queue_free()


func _on_ivincebilyt_frames_timeout():
	can_take_damage = true
