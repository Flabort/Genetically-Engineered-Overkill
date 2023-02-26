class_name GMOButton
extends CheckButton

var focus_set: = false


func _ready()->void :
	pressed = ProgressData.settings.gmo_mode_toggled


func _on_Inventory_instance_added(instance)->void :
	if focus_set:return 
	
	focus_set = true
	focus_neighbour_bottom = instance.get_path()



func _on_GMOButton_toggled(button_pressed):
	RunData.is_gmo_run = button_pressed
	ProgressData.settings.gmo_mode_toggled = button_pressed
