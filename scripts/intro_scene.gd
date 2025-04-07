extends CanvasLayer

signal done_talking

@onready var label : Label = $Label

@onready var game : PackedScene = load("res://scenes/table.tscn")

func _ready() -> void:
	label.text = ""
	await get_tree().create_timer(3.0).timeout
	say("You're in deep, kid.")
	await done_talking
	say("But I'll tell you what.")
	await done_talking
	say("Let's roll some dice.")
	await done_talking
	say("Each round we get five dice.")
	await done_talking
	say("Try not to roll over 19.")
	await done_talking
	say("Do that while rolling less than me,")
	await done_talking
	say("and I'll take five grand off your debt.")
	await done_talking
	say("Fail and I'll add two grand more.")
	await done_talking
	say("Double your debt and I own you.")
	await done_talking
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_packed(game)
	
func say(piece : String):
	for c in piece:
		label.text += c
		await get_tree().create_timer(0.05).timeout
		
	await get_tree().create_timer(3.0).timeout
	label.text = ""
	done_talking.emit()
