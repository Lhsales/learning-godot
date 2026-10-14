extends CharacterBody2D

class_name PersonagemBase

const SPEED = 100.0
const JUMP_VELOCITY = -400.0

enum Characters { 
	egg_boy = 0, hunter = 1, mask_racoon = 2, robot_camouflage = 3
}
var _prefixo_animacao: String = "_b"
var _can_attack: bool = true
var _attacking: bool = false 
var _attack_type: String = ""

@export_category("Objects")
@export var _animador: AnimationPlayer
@export var _texture: Sprite2D

@export_category("Variables")
@export var _selected_character: Characters
@export var _character_code: Array[String]

func _ready() -> void:
	_texture.texture = load(
		"res://actors/characters/" + _character_code[_selected_character] + "/spritesheet.png"
	)
	
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
		
	if _can_attack:
		if Input.is_action_just_pressed("ataque"):
			_attack_type = "ataque"
		elif Input.is_action_just_pressed("ataque_especial_1"):
			_attack_type = "ataque_especial_1"
		elif Input.is_action_just_pressed("ataque_especial_2"):
			_attack_type = "ataque_especial_2"
		else: 
			_attack_type = ""
		
		if _attack_type != "":
			_can_attack = false
			_attacking = true
			set_physics_process(false)	
	
	_animar()

func _animar() -> void:
	if _attacking == true:
		if _attack_type == "ataque":
			_animador.play("ataque" + _prefixo_animacao)
		else:
			_animador.play(_attack_type)
	elif velocity == Vector2.ZERO:
		_animador.play("parado" + _prefixo_animacao)
	elif velocity != Vector2.ZERO:
		_animador.play("andando" + _prefixo_animacao)


func _when_animation_finished(_anim_name: StringName) -> void:
	if _anim_name.contains("ataque"):
		_attacking = false 
		_can_attack = true
		set_physics_process(true)
		pass # Replace with function body.
