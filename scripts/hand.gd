extends Area3D

@onready var look_transform : Node3D = $Marker3D
@onready var name_label : Label3D = $DieName
@onready var description_label : Label3D = $DieDescription
@onready var hand_sprite : Sprite3D = $HandSprite
@export var roller : Node3D
@export var op_roller : Node3D
@export var grab_sound : AudioStreamPlayer3D

var current_die : Die
var die_mesh : Node3D
var die : RigidBody3D
var op_die : RigidBody3D

func _ready() -> void:
	input_event.connect(_on_input_event)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	GameManager.instance.hand_reset.connect(_on_hand_reset)
	hand_sprite.region_rect = Rect2(368.0, 192.0, 105.0, 55.0)
	pick_die()
	
func pick_die():
	for c in get_children():
		if c is MeshInstance3D:
			c.queue_free()
			break
	current_die = GameManager.instance.die_list.pick_random()
	
	name_label.text = current_die.name
	description_label.text = current_die.description
	
	die_mesh = current_die.model.instantiate()
	add_child(die_mesh)
	die_mesh.scale = Vector3.ONE * 3.0
	die_mesh.global_rotation_degrees = Vector3(45.0, 45.0, 45.0)

func _on_hand_reset(game_over : bool):
	if die_mesh:
		die_mesh.queue_free()
	
	hand_sprite.texture.set("region", Rect2(368.0, 192.0, 105.0, 55.0))
	name_label.visible = false
	description_label.visible = false
	if not game_over:
		pick_die()

func _on_input_event(camera : Node, event : InputEvent, event_position : Vector3, normal : Vector3, shape_idx : int):
	if Input.is_action_just_pressed("select") and GameManager.instance.state == GameManager.instance.PlayerState.PICKING:
		GameManager.instance.state = GameManager.instance.PlayerState.ROLLING
		await get_tree().create_timer(0.5).timeout
		die_mesh.visible = false
		hand_sprite.texture.set("region", Rect2(380.0, 112.0, 70.0, 76.0))
		GameManager.instance.player.shake_amt = 0.1
		grab_sound.play()
		await get_tree().create_timer(1.0).timeout
		GameManager.instance.player.look_down()
		await get_tree().create_timer(4.0).timeout
		GameManager.instance.roll_die(current_die)

func _on_mouse_entered():
	if GameManager.instance.state != GameManager.instance.PlayerState.PICKING:
		return
		
	GameManager.instance.player.target_transform = look_transform.global_transform
	name_label.visible = true
	description_label.visible = true

func _on_mouse_exited():
	if GameManager.instance.state != GameManager.instance.PlayerState.PICKING:
		return
		
	GameManager.instance.player.look_up()
	name_label.visible = false
	description_label.visible = false
