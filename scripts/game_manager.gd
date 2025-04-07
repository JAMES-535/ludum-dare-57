extends Node
class_name GameManager

signal hand_reset
signal collision_reset
signal roll_op

static var instance : GameManager

@export var player : Player
@export var debt_display : Label
@export var ppr_label : Label
@export var op_ppr_label : Label
@export var round_label : Label
@export var table : Table
@export var dealer : Dealer
@export var go_screen : ColorRect

@export var roller : Node3D
@export var op_roller : Node3D

@export var die_list : Array[Die]

@onready var title_screen := load("res://scenes/title.tscn")

var debt : int = 50000
var points : int = 0
var op_points : int = 0
var round : int = 1

var game_over : bool = false
var game_win : bool = false

var turn : int = 0

var die : Node3D
var op_die : Node3D

enum PlayerState {
	PICKING,
	ROLLING,
	LISTENING,
	ENDING,
}
var state : PlayerState = PlayerState.PICKING

func _ready() -> void:
	if instance == null:
		instance = self
	else:
		queue_free()

func _process(_delta: float) -> void:
	debt_display.text = "DEBT\n$" + str(debt)
	ppr_label.text = "You: " + str(points)
	op_ppr_label.text = "Dealer: " + str(op_points)
	round_label.text = "Round " + str(round) + "/5"
	
	if OS.is_debug_build():
		if Input.is_action_just_pressed("debug lose"):
			round = 1
			points = 20
			debt = 200000
		elif Input.is_action_just_pressed("debug win"):
			game_win = true

func roll_die(current_die : Die = null):
	table.on_table.clear()
	collision_reset.emit()
	
	if turn == 1 and range(19 - op_points).pick_random() == 0:
		dealer.hold()
		turn_end(true)
		return
	
	if turn == 0:
		die = current_die.asset.instantiate()
		roller.add_child(die)
		die.rotation.x = randf_range(-2 * PI, 2 * PI)
		die.rotation.y = randf_range(-2 * PI, 2 * PI)
		die.rotation.z = randf_range(-2 * PI, 2 * PI)
		die.linear_velocity.x = -4.0
	else:
		op_die = current_die.asset.instantiate()
		op_roller.add_child(op_die)
		op_die.rotation.x = randf_range(-2 * PI, 2 * PI)
		op_die.rotation.y = randf_range(-2 * PI, 2 * PI)
		op_die.rotation.z = randf_range(-2 * PI, 2 * PI)
		op_die.linear_velocity.x = 4.0

func turn_end(held : bool = false):
	if turn == 0:
		if not held:
			points += table.on_table[0]
		await get_tree().create_timer(2.0).timeout
		turn = 1
		roll_die(die_list.pick_random())
	else:
		if not held:
			op_points += table.on_table[0]
		await get_tree().create_timer(2.0).timeout
		round += 1
		turn = 0
		check_game_over()

func check_game_over():
	if round > 5 or debt == 0 or points > 19 or op_points > 19:
		if points > 19 or (points < op_points and op_points <= 19):
			debt += 10000
		else:
			debt -= 10000
		if debt < 0:
			debt = 0
		
		if debt >= 100000:
			game_over = true
		elif debt == 0:
			game_win = true

		round = 1
		points = 0
		op_points = 0
	
	hand_reset.emit(game_over)
	collision_reset.emit()
	if die:
		die.queue_free()
	if op_die:
		op_die.queue_free()
	player.look_up()
	
	if game_over:
		state = PlayerState.ENDING
		await get_tree().create_timer(2.0).timeout
		dealer.say("Well, wish I could say I'd regret this")
		await get_tree().create_timer(5.0).timeout
		go_screen.visible = true
		await get_tree().create_timer(5.0).timeout
		get_tree().change_scene_to_packed(title_screen)
	elif game_win:
		state = PlayerState.ENDING
		await get_tree().create_timer(2.0).timeout
		dealer.say("Well, I'll be")
		await dealer.done_talking
		await get_tree().create_timer(2.0).timeout
		dealer.say("Guess I won't be having any fun after all")
		await dealer.done_talking
		await get_tree().create_timer(2.0).timeout
		dealer.say("Deal's a deal, off you go")
		await dealer.done_talking
		await get_tree().create_timer(5.0).timeout
		go_screen.visible = true
		await get_tree().create_timer(5.0).timeout
		get_tree().change_scene_to_packed(title_screen)
	else:
		state = PlayerState.PICKING
