extends Position2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (PackedScene) var npc
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	var newEnemigo = npc.instance()
	get_tree().get_nodes_in_group("nivel1")[0].add_child(newEnemigo)
	newEnemigo.global_position = global_position
