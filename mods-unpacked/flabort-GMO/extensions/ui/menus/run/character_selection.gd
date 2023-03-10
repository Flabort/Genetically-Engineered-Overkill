extends "res://ui/menus/run/character_selection.gd"

var first_character = false

onready var _gmo_button:Button = $"%GMOButton"
#onready var _gmo_mode_text:Label = $"%GMO_mode_text"

func _ready()->void:
	_gmo_button.focus_neighbour_top = _inventory.get_child(0).get_path()
	# Next three lines suggested by @Damzo (@Dami#7578)
	if not self.name == "TraitSelection":
		_gmo_button.set_disabled(true)
		_gmo_button.hide()
		
	for test_inventory_element in _inventory.get_children():
		if "item" in test_inventory_element:
			if not test_inventory_element.item == null:
				if "my_id" in test_inventory_element.item:
					if test_inventory_element.item.my_id == "GMO_dummy":
						_inventory.remove_child(test_inventory_element)

func on_element_pressed(element:InventoryElement)->void:
	if RunData.is_gmo_run == true:
		# This code allows you to select two characters
		if first_character and !character_added:
			# This Not Null fix will allow the mod to work with otDan's Item Explorer
			if not _gmo_button == null:
				_gmo_button.set_disabled(true)
			.on_element_pressed(element)
			return
			
		if element.is_random:
			first_character = true
			RunData.add_character(Utils.get_rand_element(available_elements))
			update_locks(element.item.my_id)
			# This Not Null fix will allow the mod to work with otDan's Item Explorer
			if not _gmo_button == null:
				_gmo_button.hide()
			_inventory.get_child(0).grab_focus()
			# for some reason, I can't get this to work
			#_gmo_mode_text.show()
		elif element.is_special:
			return 
		else :
			first_character = true
			RunData.add_character(element.item)
			update_locks(element.item.my_id)
			# This Not Null fix will allow the mod to work with otDan's Item Explorer
			if not _gmo_button == null:
				_gmo_button.hide()
			_inventory.get_child(0).grab_focus()
			# for some reason, I can't get this to work
			#_gmo_mode_text.show()
		return
	else:
		# This Not Null fix will allow the mod to work with otDan's Item Explorer
		if not _gmo_button == null:
			_gmo_button.set_disabled(true)
		.on_element_pressed(element)
		return


func update_locks(comparator_id:String)->void:
	var characters_to_lock = []
	for test_compatibility in load("res://mods-unpacked/flabort-GMO/extra_classes/load_incompatibles.tres").all_incompatibles:
		if test_compatibility.my_id == comparator_id:
			characters_to_lock = test_compatibility.incompatible_characters
	for test_element in characters_to_lock:
		for test_inventory_element in _inventory.get_children():
			if "item" in test_inventory_element:
				if not test_inventory_element.item == null:
					if "my_id" in test_inventory_element.item:
						if test_inventory_element.item.my_id == test_element.my_id:
							_inventory.remove_child(test_inventory_element)
