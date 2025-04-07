extends RigidBody3D

var finished_movement : bool = false
var first_bounced : bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _process(delta: float) -> void:
	if finished_movement or not first_bounced:
		return
	
	var velo_magnitude = sqrt(linear_velocity.x * linear_velocity.x +
							  linear_velocity.y * linear_velocity.y +
							  linear_velocity.z * linear_velocity.z)
	if velo_magnitude <= 0.001:
		if len(GameManager.instance.table.on_table) == 0:
			apply_impulse(global_position.direction_to(GameManager.instance.table.global_position) * 1.0)
			return
		finished_movement = true
		GameManager.instance.turn_end()

func _on_body_entered(_body : Node3D):
	first_bounced = true
