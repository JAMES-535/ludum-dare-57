extends Node
class_name State

@export var state_machine : StateMachine

func enter(_prev_state : State):
	pass

func update(_delta : float):
	pass

func physics_update(_delta : float):
	pass

func input(_event):
	pass

func exit():
	pass
