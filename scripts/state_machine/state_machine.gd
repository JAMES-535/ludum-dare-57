extends Node
class_name StateMachine

@export var current_state : State

func _ready():
	current_state.enter(null)

func _process(delta):
	current_state.update(delta)

func _physics_process(delta):
	current_state.physics_update(delta)

func _input(event):
	current_state.input(event)

func change_state(new_state_name : String):
	for i in get_children():
		if i.name.to_lower() == new_state_name.to_lower():
			current_state.exit()
			var prev_state : State = current_state
			current_state = i
			current_state.enter(prev_state)
			return
	
	printerr("State \"" + new_state_name + "\" not found")
