extends CharacterBody2D
@onready var health_label: Label = $health
var speed = 100
var health = 100

var direction = Vector2.ZERO

func _ready():
	direction = (Vector2.LEFT).normalized()


func _process(delta):
	position += direction * speed * delta
	health_label.text = str(int(health))
	if health <= 0:
		kill()


func _on_hitbox_area_entered(area: Area2D):
	health -= 50

func kill():
	queue_free()
