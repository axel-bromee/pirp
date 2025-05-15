extends Area2D
@onready var label: Label = $"../CanvasLayer/Label"
var health = 100
var damage = 1000000


func _process(_delta):
	label.text = "base health" + str(int(health))

func _on_area_entered(area: Area2D):
	var enemy = area.get_parent()
	if "damage" in enemy:
		health -= enemy.damage
