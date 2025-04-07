extends Label

var target_col : Color

var danger_col : Color = Color.RED
var normal_col : Color = Color.WHITE

func _ready() -> void:
	target_col = normal_col

func _process(delta: float) -> void:
	if text.to_int() > 19:
		target_col = danger_col
	else:
		target_col = normal_col
	
	set("theme_override_colors/font_color", get("theme_override_colors/font_color").lerp(target_col, delta * 2.0))
