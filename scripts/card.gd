extends Control
@onready var CHARECTER = $"../../CharacterBody2D"

func _on_button_pressed() -> void:
	match randi_range(0,9):
		0:
			common_card_mana()
		1:
			pass
		2:
			pass
		3:
			pass
		4:
			pass
		5:
			pass
		6:
			pass
		7:
			pass
		8:
			pass
		9:
			pass

func common_card_mana():
	CHARECTER.max_mana += 50
	pass
