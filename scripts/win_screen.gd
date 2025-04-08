extends Node2D

@onready var title : PackedScene = load("res://scenes/title.tscn")

func _ready() -> void:
	await get_tree().create_timer(5.0).timeout
	get_tree().change_scene_to_packed(title)
