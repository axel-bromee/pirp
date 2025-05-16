extends Area2D
@onready var shot_lifetime: Timer = $shot_lifetime
@onready var move_length: Timer = $move_length
@onready var cpu_particles_2d = $CPUParticles2D
var speed = 400
var damage = 25
var lifetime = 4.5
var move_time = 0.4
var burn = 4
var bullet_direction = Vector2.ZERO
var moving = true
# Called when the node enters the scene tree for the first time.
func _ready():
	bullet_direction = (Vector2.RIGHT).normalized()
	move_length.start(move_time)
	shot_lifetime.start(lifetime)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if moving:
		position += bullet_direction * speed * delta
	else:
		pass
	
	


func _on_shot_lifetime_timeout():
	cpu_particles_2d.emitting = false
	await get_tree().create_timer(0.7).timeout
	queue_free()


func _on_move_length_timeout():
	moving = false
