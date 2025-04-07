extends Node3D
class_name Dealer

signal done_talking

@onready var speech : Label3D = $Speech
@onready var audio_player : AudioStreamPlayer3D = $SpeechSound

func _ready() -> void:
	speech.text = ""
	
func say(piece : String, freeze_player : bool = true):
	var player_state = GameManager.instance.state
	if freeze_player:
		GameManager.instance.state = GameManager.instance.PlayerState.LISTENING
		GameManager.instance.player.look_up()
		
	for c in piece:
		speech.text += c
		audio_player.pitch_scale = randf_range(0.5, 1.5)
		audio_player.play()
		await get_tree().create_timer(0.05).timeout
		
	await get_tree().create_timer(3.0).timeout
	speech.text = ""
	
	if freeze_player:
		GameManager.instance.state = player_state
		
	done_talking.emit()

func hold():
	say("I'm holding", false)
