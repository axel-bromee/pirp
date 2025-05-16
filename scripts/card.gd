extends Control
@onready var upgrade_card = $"upgrade card"
@onready var description = $description
@onready var character_body_2d = $"../../../CharacterBody2D"

var rando_card

func _ready():
	rando_card = 0#randi_range(0,9)
	match rando_card:
		0:
			common_card_mana_vis()
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

func _on_button_pressed() -> void:
	match rando_card:
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
	for child in get_parent().get_children():
		child.queue_free()
func common_card_mana_vis():
	upgrade_card.text = "common mana card"
	description.text = "this card increses your max mana by 25"

func common_card_mana():
	character_body_2d.max_mana += 25
