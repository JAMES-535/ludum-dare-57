extends Area3D
class_name Table

@export var collider1 : StaticBody3D
@export var collider2 : StaticBody3D

var on_table : Array[int]

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	GameManager.instance.collision_reset.connect(_on_reset)
	
func _on_area_entered(area : Area3D):
	if area is Side:
		on_table.append(area.side)
		collider1.set_collision_layer_value(1, true)
		collider2.set_collision_layer_value(1, true)

func _on_area_exited(area : Area3D):
	if area is Side and len(on_table) > 0:
		for i in range(len(on_table)):
			if on_table[i] == area.side:
				on_table.remove_at(i)
				break

func _on_reset():
	collider1.set_collision_layer_value(1, false)
	collider2.set_collision_layer_value(1, false)
