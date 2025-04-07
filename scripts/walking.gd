extends State

@export var body : CharacterBody2D

const SPEED : float = 500.0
const JUMP_FORCE : float = -800

func physics_update(delta: float):
	if not body.is_on_floor():
		body.velocity += body.get_gravity() * delta
		
	if Input.is_action_just_pressed("jump") and body.is_on_floor():
		body.velocity.y = JUMP_FORCE

	var input : float = Input.get_axis("left", "right")
	print(input)
	if input:
		body.velocity.x = input * SPEED
	else:
		body.velocity.x = move_toward(body.velocity.x, 0, SPEED)
		
	body.move_and_slide()
