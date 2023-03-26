class_name WeaponWaveStateMultiplierEffect
extends NullEffect


export (String) var stat_displayed_name = "stat_damage"
export (String) var stat_name = "damage"


static func get_id()->String:
	return "wave_multiplier"


func get_args()->Array:
	
	var waves = RunData.current_wave
	
	return [str(value), tr(stat_displayed_name.to_upper()), str(waves), str(waves * value)]


func serialize()->Dictionary:
	var serialized = .serialize()


	serialized.stat_displayed_name = stat_displayed_name
	serialized.stat_name = stat_name

	return serialized


func deserialize_and_merge(serialized:Dictionary)->void :
	.deserialize_and_merge(serialized)

	stat_displayed_name = serialized.stat_displayed_name
	stat_name = serialized.stat_name
