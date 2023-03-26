extends "res://singletons/weapon_service.gd"

func init_base_stats(from_stats:WeaponStats, weapon_id:String = "", sets:Array = [], effects:Array = [], is_structure:bool = false)->WeaponStats:
	
	var base_stats = .init_base_stats(from_stats,weapon_id,sets,effects,is_structure)
	for effect in effects:
		if effect is WeaponWaveStateMultiplierEffect:
			base_stats.set(effect.stat_name, base_stats.get(effect.stat_name)+effect.value*RunData.current_wave)
	return base_stats
