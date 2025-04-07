extends Camera3D
class_name Player

@export var look_up_transform : Node3D
@export var look_down_transform : Node3D
var target_transform : Transform3D

enum PositionState {
	UP,
	DOWN,
}
var position_state : PositionState = PositionState.UP

var shake_amt : float = 0.0

func _ready() -> void:
	target_transform = look_up_transform.global_transform

func _process(delta: float) -> void:
	global_transform = global_transform.interpolate_with(target_transform, 10.0 * delta)
	
	h_offset = randf_range(-shake_amt, shake_amt)
	v_offset = randf_range(-shake_amt, shake_amt)
	shake_amt = move_toward(shake_amt, 0.0, delta * 0.4)

func look_up():
	target_transform = look_up_transform.global_transform
	
func look_down():
	target_transform = look_down_transform.global_transform
