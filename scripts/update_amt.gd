extends Label3D

@onready var anim_player : AnimationPlayer = $AnimationPlayer

func positive_motion():
	text = "-10k"
	anim_player.play("PositiveMotion")

func negative_motion():
	text = "+10k"
	anim_player.play("Motion")
