extends Area2D
var speed = 150
var bullet_direction = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	bullet_direction = (Vector2.RIGHT).normalized()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += bullet_direction * speed * delta

func _on_area_entered(area: Area2D):
	queue_free()
