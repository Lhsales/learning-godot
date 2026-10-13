extends CharacterBody2D

class_name PersonagemBase

const SPEED = 100.0
const JUMP_VELOCITY = -400.0

var _prefixo_animacao: String = "_b"

@export_category("Objects")
@export var _animador: AnimationPlayer

func _physics_process(delta: float) -> void:
	
	var direction: Vector2 = Input.get_vector(
		"mover_e", "mover_d", "mover_c",  "mover_b"
	)
	
	if Input.is_action_pressed("mover_e"):
		_prefixo_animacao = "_e"
		
	if Input.is_action_pressed("mover_d"):
		_prefixo_animacao = "_d"
		
	if Input.is_action_pressed("mover_b") and direction.y != 0:
		_prefixo_animacao = "_b"
		
	if Input.is_action_pressed("mover_c") and direction.y != 0:
		_prefixo_animacao = "_c"
	
	velocity = direction * SPEED
	move_and_slide()
	
	_animar()
	
	# Add the gravity.
	#if not is_on_floor():
	#	velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
	#	velocity.x = direction * SPEED
	#else:
	#	velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()

func _animar() -> void:
	if velocity == Vector2.ZERO:
		_animador.play("parado" + _prefixo_animacao)
	elif velocity != Vector2.ZERO:
		_animador.play("andando" + _prefixo_animacao)
