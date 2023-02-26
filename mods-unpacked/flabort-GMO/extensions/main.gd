extends "res://main.gd"


const GMOFLAB_LOG = "flabort-GMO"


# Called when the node enters the scene tree for the first time.
func _ready()->void:
	ModLoaderUtils.log_info("Ready", GMOFLAB_LOG)


