extends CharacterBody3D


@export var speed = 5.0

var state =""

func _ready():
	state = "Idle"




func _process(_delta):
	animation_state()


func animation_state():
	if state == "Idle":
		$Sprite.play("idle")
	elif state == "Run":
		$Sprite.play("run")
