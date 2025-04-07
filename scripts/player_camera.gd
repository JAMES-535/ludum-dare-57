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

func _ready() -> void:
	target_transform = look_up_transform.global_transform

func _process(delta: float) -> void:
	global_transform = global_transform.interpolate_with(target_transform, 10.0 * delta)

func look_up():
	target_transform = look_up_transform.global_transform
	
func look_down():
	target_transform = look_down_transform.global_transform
