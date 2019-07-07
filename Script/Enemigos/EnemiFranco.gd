extends KinematicBody2D

var atk=false
var BalaPerphraps=preload("res://Perphraps/Bala/Bala.tscn")
var posBal
var collider=0
var bodyCollider=null

# Called when the node enters the scene tree for the first time.
func _ready():
	if (get_node("Position2D")!=null):
		posBal=get_node("Position2D").position.x

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	if (atk and bodyCollider!=null):
		atk=false
		get_node("ratAtk").start()
		print ("se esta disparando")
		var bal=BalaPerphraps.instance()
		get_parent().add_child(bal)
		if (get_node("Position2D")!=null):
			var posBal1=posBal*Vector2(cos(get_node("Position2D").rotation),sin(get_node("Position2D").rotation))
			get_node("Position2D").position=posBal1
			bal.set_position(get_node("Position2D").global_position)
		
			var impulse=800*Vector2(cos(get_node("Position2D").rotation),sin(get_node("Position2D").rotation))
			bal.apply_impulse(Vector2(0,0),impulse)

func _on_Area2D_body_entered(body):
	#if (body.is_in_group("player") and collider<1):
	#	atk=true
	#	print ("El enemigo es el jugador")
	#	collider=collider+1
	pass	


func _on_ratAtk_timeout():
	atk=true
	print ("Termino el atk")


func _on_Area2D_body_shape_entered(body_id, body, body_shape, area_shape):
	if (body.is_in_group("player")):
		print ("El enemigo es el jugador",body_id,"  ",bodyCollider)
	if (body.is_in_group("player") and bodyCollider==null):
		bodyCollider=body_id
		atk=true
		
	elif(body.is_in_group("player") and bodyCollider!=body_id):
		atk=true
		print ("El enemigo es el jugador")


func _on_Area2D_body_shape_exited(body_id, body, body_shape, area_shape):
	
	atk=false
	bodyCollider=null

