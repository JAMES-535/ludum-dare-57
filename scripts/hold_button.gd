extends Button

func _ready() -> void:
	pressed.connect(_on_button_pressed)

func _process(_delta : float) -> void:
	disabled = not GameManager.instance.state == GameManager.instance.PlayerState.PICKING
	visible = GameManager.instance.state == GameManager.instance.PlayerState.PICKING

func _on_button_pressed():
	GameManager.instance.state = GameManager.instance.PlayerState.ROLLING
	GameManager.instance.player.look_down()
	GameManager.instance.turn_end(true)
