extends Label3D

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
		
	modulate = modulate.lerp(target_col, delta * 1.5)
