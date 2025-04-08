extends Button

func _ready() -> void:
	pressed.connect(_on_pressed)
	
func _on_pressed():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		text = "Fullscreen"
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		text = "Windowed"
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
