extends Control
@onready var upgrade_card = $"upgrade card"
@onready var description = $description
@onready var character_body_2d = $"../../../CharacterBody2D"

var rando_card

func _ready():
	rando_card = randi_range(0,7)
	match rando_card:
		0:
			upgrade_card.text = "Common mana card"
			description.text = "This card increases your max mana by 25"
		1:
			upgrade_card.text = "Uncommon spred shot"
			description.text = "This card makes you shot 2 aditional bullets "
		2:
			pass
		3:
			pass
		4:
			pass
		5:
			upgrade_card.text = "Common cast speed"
			description.text = "This card increases bullet fire rate "
		6:
			upgrade_card.text = "Common mana regen"
			description.text = "This card inrcreases mana regen rate"
		7:
			upgrade_card.text = "Common Pierce Bullets"
			description.text = "Pierces one additional"
		8:	
			pass
		9:
			pass

func _on_button_pressed() -> void:
	match rando_card:
		0:
			character_body_2d.max_mana += 25
		1:
			character_body_2d.spread_shot = true
		2:
			pass
		3:
			pass 
		4:
			pass
		5:
			character_body_2d.fire_rate *= 0.9
		6:
			character_body_2d.mana_regen_rate *= 1.15
		7:
			character_body_2d.pierce
		8:
			pass
		9:
			pass
	for child in get_parent().get_children():
		child.queue_free()
	

	
