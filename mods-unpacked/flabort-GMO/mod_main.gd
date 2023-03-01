extends Node

# Helping Hands/Co-authors: @KANA#1834, @Dami#7578
# Item concepts: @Zom#5814, @Sauerkraut Chewer#0545/Gamerboy1607
# Improved art assets by @EviePatamon#9954 (creator of Patamon mod)


const MOD_DIR = "flabort-GMO/"
const GMOFLAB_LOG = "flabort-GMO"

var dir = ""
var ext_dir = ""
var trans_dir = ""

func _init(modLoader = ModLoader):
	ModLoaderUtils.log_info("Init", GMOFLAB_LOG)
	dir = modLoader.UNPACKED_DIR + MOD_DIR
	ext_dir = dir + "extensions/"
	

	# Add extensions
	modLoader.install_script_extension(ext_dir + "main.gd")
	modLoader.install_script_extension(ext_dir + "ui/menus/run/character_selection.gd")
	modLoader.install_script_extension(ext_dir + "singletons/progress_data.gd")
	modLoader.install_script_extension(ext_dir + "singletons/run_data.gd")

	# Add translations
	modLoader.add_translation_from_resource("res://mods-unpacked/flabort-GMO/translations/GMO_text.en.translation")
	modLoader.add_translation_from_resource("res://mods-unpacked/flabort-GMO/translations/GMO_text.es.translation")


func _ready():
	ModLoaderUtils.log_info("Done", GMOFLAB_LOG)
	# Next 3 functional lines created by @KANA (@KANA#1834)
	var character_selection = load("res://ui/menus/run/character_selection.tscn").instance()
	ModLoader.append_node_in_scene(character_selection, "GMOButton", 'MarginContainer/VBoxContainer', "res://mods-unpacked/flabort-GMO/extensions/ui/menus/run/GMO_button.tscn", true)
	#ModLoader.append_node_in_scene(character_selection, "GMO_mode_text", 'MarginContainer/VBoxContainer', "res://mods-unpacked/flabort-GMO/extensions/ui/menus/run/GMO_mode_text.tscn", false)
	
	ModLoader.save_scene(character_selection, "res://ui/menus/run/character_selection.tscn")
	
	
	# ContentLoader stuff
	var ContentLoader = get_node("/root/ModLoader/Darkly77-ContentLoader/ContentLoader")
	var content_dir = "res://mods-unpacked/flabort-GMO/content-data/"
	var mod_log = "flabort-GMO"
	ContentLoader.load_data(content_dir + "GMO_characters.tres", mod_log)
	ContentLoader.load_data(content_dir + "GMO_items.tres", mod_log)
	
	
	var dummy_character = load("res://mods-unpacked/flabort-GMO/content/characters/GMO_dummy/GMO_dummy.tres")
	var config_difficulty = ModLoader.get_mod_config("flabort-GMO","difficulty").data
	var cust_config_items_price = ModLoader.get_mod_config("flabort-GMO","items_price").data
	var cust_config_number_of_enemies = ModLoader.get_mod_config("flabort-GMO","number_of_enemies").data
	var cust_config_enemy_speed = ModLoader.get_mod_config("flabort-GMO","enemy_speed").data
	var cust_config_xp_gain = ModLoader.get_mod_config("flabort-GMO","xp_gain").data
	
	if config_difficulty == "default" or ModLoader.get_mod_config("flabort-GMO","difficulty").error != 0:
		pass
	elif config_difficulty == "original":
		for effect in dummy_character.effects:
			if effect.key == "items_price":
				effect.value = 40
			if effect.key == "xp_gain":
				effect.value = -25
			if effect.key == "number_of_enemies":
				effect.value = 50
			if effect.key == "enemy_speed":
				effect.value = 10
	elif config_difficulty == "easy":
		for effect in dummy_character.effects:
			if effect.key == "items_price":
				effect.value = 0
			if effect.key == "xp_gain":
				effect.value = 0
			if effect.key == "number_of_enemies":
				effect.value = 0
			if effect.key == "enemy_speed":
				effect.value = 0
	else:
		for effect in dummy_character.effects:
			if effect.key == "items_price":
				effect.value = cust_config_items_price
			if effect.key == "xp_gain":
				effect.value = cust_config_xp_gain
			if effect.key == "number_of_enemies":
				effect.value = cust_config_number_of_enemies
			if effect.key == "enemy_speed":
				effect.value = cust_config_enemy_speed
	
