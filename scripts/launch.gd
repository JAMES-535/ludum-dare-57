extends Node3D

func _ready() -> void:
	if OS.get_name() == "Windows" or OS.get_name() == "macOS" or OS.get_name() == "Linux":
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
