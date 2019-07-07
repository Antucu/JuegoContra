extends Position2D

export (PackedScene) var npc
export var distacniaSpawn=450
export var cantColsiones=1

var collider=0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	var newEnemigo = npc.instance()
	if (body.is_in_group("player") and collider<cantColsiones):
		get_tree().get_nodes_in_group("nivel1")[0].add_child(newEnemigo)
		newEnemigo.global_position = global_position+Vector2(distacniaSpawn,0)
		collider=collider+1
