extends "res://singletons/progress_data.gd"





func init_settings()->void :
	ProgressData.settings = {"version":"", "endless_mode_toggled":false, "gmo_mode_toggled":false}
	ProgressData.settings.merge(.init_general_options())
	ProgressData.settings.merge(.init_gameplay_options())

#func get_character_difficulty_info(character_id:String, zone_id:int)->ZoneDifficultyInfo:
#	# This is 100% not the way to do this, it's causing progress to be reset
#	if character_id == "GMO_dummy":
#		return ZoneDifficultyInfo.new(5)
#	else:
#		return .get_character_difficulty_info(character_id,zone_id)
