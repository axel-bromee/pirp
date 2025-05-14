extends Area2D
@onready var label: Label = $"../CanvasLayer/Label"
var health = 100


func _process(delta):
	label.text = "base health" + str(int(health))

func _on_area_entered(area: Area2D):
	health -= 10
