extends CharacterBody3D


@export var speed = 5.0

@onready var animation_player: AnimationPlayer = $MeshInstance3D/AnimationPlayer

var state =""

func _ready():
	state = "Idle"
	animation_state()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()

func _process(_delta):
	pass


func animation_state():
	if state == "Idle":
		animation_player.play("idle")
	elif state == "Run":
		animation_player.play("run")
