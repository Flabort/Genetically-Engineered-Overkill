extends Node

# Helping Hands/Co-authors: @KANA#1834, @Dami#7578
# Item concepts: @Zom#5814

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
