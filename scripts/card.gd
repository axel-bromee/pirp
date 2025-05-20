extends Control
@onready var upgrade_card = $"upgrade card"
@onready var description = $description
@onready var character_body_2d = $"../../../CharacterBody2D"

var rando_card

func _ready():
	rando_card = randi_range(0,9)
	match rando_card:
		0:
			upgrade_card.text = "common mana card"
			description.text = "this card increses your max mana by 25"
		1:
			upgrade_card.text = "Common mana regen"
			description.text = "This card inrcreases mana regen rate"
		2:
			upgrade_card.text = "Common Pierce Bullets"
			description.text = "Pierces one additional"
		3:
			upgrade_card.text = "Common Bullet Damage"
			description.text = "Increases bullet damage by 10%"
		4:
			upgrade_card.text = "Common Projectile Speed"
			description.text = "Increases projectile speed by 20%"
		5:
			upgrade_card.text = "Common cast speed"
			description.text = "This card increases bullet fire rate "
		6:
			upgrade_card.text = "uncommon spred shot"
			description.text = "this card makes you shot 2 aditional bullets "
		7:
			upgrade_card.text = "rare fire wall"
			description.text = "a strong fire wall that lights enemies on fire taing damage over time"
		8:	
			pass
		9:
			pass

func _on_button_pressed() -> void:
	match rando_card:
		0:
			character_body_2d.max_mana += 25
		1:
			character_body_2d.mana_regen_rate *= 1.15
		2:
			character_body_2d.pierce
		3:
			character_body_2d.damage_modifier *= 1.1
		4:
			character_body_2d.projectile_speed *= 1.2
		5:
			character_body_2d.fire_rate *= 0.9
		6:
			character_body_2d.spread_shot = true
		7:
			character_body_2d.fire_wall_unlocked = true
		8:
			pass
		9:
			pass
	for child in get_parent().get_children():
		child.queue_free()
