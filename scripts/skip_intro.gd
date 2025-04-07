extends Button

var target_color : Color

func _ready() -> void:
	pressed.connect(_on_button_pressed)
	target_color = Color.BLACK
	await get_tree().create_timer(3.0).timeout
	target_color = Color(.3, .3, .3)
	
func _process(delta: float) -> void:
	set("theme_override_colors/font_color", get("theme_override_colors/font_color").lerp(target_color, delta * 2.0))

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/table.tscn")
