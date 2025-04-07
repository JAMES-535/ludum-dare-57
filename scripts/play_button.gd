extends Button

@export var game_scene : PackedScene

func _ready() -> void:
	pressed.connect(_on_button_pressed)
	
func _on_button_pressed():
	get_tree().change_scene_to_packed(game_scene)
