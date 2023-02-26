extends "res://singletons/run_data.gd"


var is_gmo_run = false
var gmo_characters = []



func add_character(character:CharacterData)->void:
	if is_gmo_run:
		if current_character == null:
			for test_character in ItemService.characters:
				if test_character.my_id == "GMO_dummy":
					current_character = test_character
					add_item(test_character)
					current_character.wanted_tags = []
					current_character.starting_weapons = []
					gmo_characters = []
					for test_effect in current_character.effects:
						if test_effect.text_key.begins_with("GMO_COMBINES"):
							test_effect.text_key = "GMO_COMBINES "
		if not character.my_id == "GMO_dummy":
			add_item(character)
			gmo_characters.append(character.my_id)
			for test_tag in character.wanted_tags:
				if not current_character.wanted_tags.has(test_tag):
					current_character.wanted_tags.append(test_tag)
			for test_weapon in character.starting_weapons:
				if not current_character.starting_weapons.has(test_weapon):
					current_character.starting_weapons.append(test_weapon)
			for test_effect in current_character.effects:
				if test_effect.text_key.begins_with("GMO_COMBINES") && test_effect.text_key.ends_with(" "):
					test_effect.text_key = "GMO_COMBINES " + character.name
					return
	else:
		.add_character(character)


func reset(restart:bool = false)->void:
	.reset(restart)
	if restart:
		
		if is_gmo_run:
			for item in items:
				if item.my_id == "GMO_dummy": remove_item(item)
			add_item(current_character)
			current_character.wanted_tags = []
			current_character.starting_weapons = []
			for character in gmo_characters:
				for test_character in ItemService.characters:
					if test_character.my_id == character:
						add_item(test_character)
						for test_effect in current_character.effects:
							if test_effect.text_key.begins_with("GMO_COMBINES") && test_effect.text_key.ends_with(" "):
								test_effect.text_key = "GMO_COMBINES " + test_character.name
							for test_weapon in test_character.starting_weapons:
								if not current_character.starting_weapons.has(test_weapon):
									current_character.starting_weapons.append(test_weapon)
							for test_tag in test_character.wanted_tags:
								if not current_character.wanted_tags.has(test_tag):
									current_character.wanted_tags.append(test_tag)
		
		add_starting_items_and_weapons()



#func get_state(
#		reset:bool = false, 
#		shop_items:Array = [], 
#		reroll_price:int = 0, 
#		last_reroll_price:int = 0, 
#		initial_free_rerolls:int = 0, 
#		free_rerolls:int = 0
#	)->Dictionary:
#		var gmo_run = {"is_gmo_run":is_gmo_run}
#		var state = .get_state(reset,shop_items,reroll_price,last_reroll_price,initial_free_rerolls,free_rerolls)
#		if reset:
#			return state
#		else:
#			return state.merge(gmo_run)
