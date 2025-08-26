extends StaticBody3D

@export var stand_path: NodePath



func _ready():
    add_to_group("stands")

func _process(_delta):
    pass

func clicked():
    print("Stand clicked!")
    get_tree().change_scene_to_file(stand_path)
