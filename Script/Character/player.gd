extends CharacterBody3D


@export var speed = 5.0

@onready var animation_player: AnimationPlayer = $MeshInstance3D/AnimationPlayer

var state =""
var target_position: Vector3
var moving: bool = false


func _ready():
	state = "Idle"
	animation_state()

#Gestion du clique sur les stands pour déplacer le joueur
func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var camera = get_viewport().get_camera_3d()
		if camera:
			var from = camera.project_ray_origin(event.position)
			var to = from + camera.project_ray_normal(event.position) * 1000.0
			
			var space_state = get_world_3d().direct_space_state
			var query = PhysicsRayQueryParameters3D.create(from, to)
			var result = space_state.intersect_ray(query)
			
			if result:
				var obj = result.collider
				if obj.is_in_group("stands"):
					target_position = obj.global_transform.origin
					moving = true
					state = "Run"
					animation_state()
					obj.clicked()



#Gestion de la physique du joueur
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()

	if moving:
		var direction = (target_position - global_transform.origin)
		if direction.length() > 0.1:
			direction = direction.normalized()
			velocity = direction * speed
			move_and_slide()
		else:
			velocity = Vector3.ZERO
			moving = false




func animation_state():
	if state == "Idle":
		animation_player.play("idle")
	elif state == "Run":
		animation_player.play("run")
