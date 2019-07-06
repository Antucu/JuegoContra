extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var GRAVEDAD=800
export var velocidad=150
export var force_salto=30

var VelocidadPlayer=Vector2(0,0)
var atk=true
var castInstAnim=false

export(NodePath) var animPlayerPath=null
var BalaPerphraps=preload("res://Perphraps/Bala/Bala.tscn")
var animPlayer: AnimationPlayer
var posBal
# Called when the node enters the scene tree for the first time.
func _ready():
	velocidad=velocidad*100
	force_salto=(force_salto*1000)*-1
	animPlayer=get_node("AnimationPlayer")
	print ("rrotation",get_node("Position2D").global_rotation)
	get_node("Position2D").rotation_degrees=90
	posBal=get_node("Position2D").position.x
	print ("rrotation",get_node("Position2D").global_rotation)

func _physics_process(delta):
	
	if (Input.is_action_pressed("ui_right") and animPlayer!=null):
		get_node("Sprite").flip_h=false
		if (Input.is_action_pressed("ui_up")==false or Input.is_action_pressed("ui_down")==false):
			VelocidadPlayer.x=0
		VelocidadPlayer.x=velocidad
		####A partir de aqui se anima
		if (atk==true and Input.is_action_pressed("atk") and Input.is_action_pressed("ui_down")==false and Input.is_action_pressed("ui_up")==false):
			if(animPlayer.current_animation=="run" or animPlayer.current_animation=="idle"):
				animPlayer.play("runatk")
			if(animPlayer.is_playing()==false):
				animPlayer.play("runatk")
			get_node("Position2D").rotation_degrees=0
		if (atk==true and Input.is_action_pressed("atk") and Input.is_action_pressed("ui_up")):
			if(animPlayer.current_animation=="run"):
				animPlayer.play("runatk1")
			if(animPlayer.is_playing()==false):
				animPlayer.play("runatk1")
			get_node("Position2D").rotation_degrees=-45
		if (atk==true and Input.is_action_pressed("atk") and Input.is_action_pressed("ui_down")):
			if(animPlayer.current_animation=="run"):
				animPlayer.play("runatk2")
			if(animPlayer.is_playing()==false):
				animPlayer.play("runatk2")
			get_node("Position2D").rotation_degrees=45
		if (animPlayer.is_playing()==false and Input.is_action_pressed("atk")==false):
			animPlayer.play("run")
			get_node("Position2D").rotation_degrees=0
		
	elif(Input.is_action_pressed("ui_left") and animPlayer!=null):
		get_node("Sprite").flip_h=true
		VelocidadPlayer.x=-velocidad
		####A partir de aqui se anima
		if (atk==true and Input.is_action_pressed("atk") and Input.is_action_pressed("ui_down")==false and Input.is_action_pressed("ui_up")==false):
			if(animPlayer.current_animation=="run"  or animPlayer.current_animation=="idle"):
				animPlayer.play("runatk")
			if(animPlayer.is_playing()==false):
				animPlayer.play("runatk")
			get_node("Position2D").rotation_degrees=180
		if (atk==true and Input.is_action_pressed("atk") and Input.is_action_pressed("ui_up")):
			if(animPlayer.current_animation=="run"):
				animPlayer.play("runatk1")
			if(animPlayer.is_playing()==false):
				animPlayer.play("runatk1")
			get_node("Position2D").rotation_degrees=225
		if (atk==true and Input.is_action_pressed("atk") and Input.is_action_pressed("ui_down")):
			if(animPlayer.current_animation=="run"):
				animPlayer.play("runatk2")
			if(animPlayer.is_playing()==false):
				animPlayer.play("runatk2")
			get_node("Position2D").rotation_degrees=135
		if (animPlayer.is_playing()==false and Input.is_action_pressed("atk")==false):
			animPlayer.play("run")
			get_node("Position2D").rotation_degrees=180
	elif(Input.is_action_pressed("ui_up") and animPlayer!=null):
		if (Input.is_action_pressed("atk") and atk==true and animPlayer.is_playing()==false):
			animPlayer.play("atk2")
			get_node("Position2D").rotation_degrees=-90
		else: 
			if (animPlayer.current_animation=="run"):
				animPlayer.play("idle1")
			if (animPlayer.is_playing()==false):
				animPlayer.play("idle1")
		if (Input.is_action_pressed("ui_left")==false or Input.is_action_pressed("ui_right")==false):
			VelocidadPlayer.x=-0
	elif(Input.is_action_pressed("ui_down") and animPlayer!=null):
		if (Input.is_action_pressed("atk") and atk==true and animPlayer.is_playing()==false):
			animPlayer.play("atk3")
		else: 
			if (animPlayer.current_animation=="run"):
				animPlayer.play("idle2")
			if (animPlayer.is_playing()==false):
				animPlayer.play("idle2")
		if (Input.is_action_pressed("ui_left")==false or Input.is_action_pressed("ui_right")==false):
			VelocidadPlayer.x=-0
	else:
		VelocidadPlayer.x=-0
		get_node("Position2D").rotation_degrees=0
		if (animPlayer!=null and Input.is_action_pressed("atk")==false):
			animPlayer.play("idle")
	
	if(Input.is_action_pressed("atk") and atk):
		atk=false
		if (animPlayer.is_playing()==false):
			animPlayer.play("atk1")
		get_node("ratAtk").start()
		var bal=BalaPerphraps.instance()
		get_parent().add_child(bal)
		print ("rotation1",get_node("Position2D").rotation_degrees,get_node("Position2D").rotation," pos:",get_node("Position2D").global_position,"pos: ",get_node("Position2D").position)
		print ("rotation11",cos(get_node("Position2D").rotation),sin(get_node("Position2D").rotation))
		var posBal1=posBal*Vector2(cos(get_node("Position2D").rotation),sin(get_node("Position2D").rotation))
		print ("rotation2",get_node("Position2D").rotation_degrees," pos:",get_node("Position2D").global_position,"pos: ",get_node("Position2D").position,"pos:bal",posBal1)
		get_node("Position2D").position=posBal1
		print ("rotation3",get_node("Position2D").rotation_degrees," pos:",get_node("Position2D").global_position,"pos: ",get_node("Position2D").position)
		bal.set_position(get_node("Position2D").global_position)
		
		var impulse=800*Vector2(cos(get_node("Position2D").rotation),sin(get_node("Position2D").rotation))
		bal.apply_impulse(Vector2(0,0),impulse)
	
	var movimineto=VelocidadPlayer*delta
	move_and_slide(movimineto, Vector2(0,-1))
	#####Esto es para atacar
	"""if (Input.is_action_just_pressed("atk") or Input.is_action_pressed("atk")):
		atk=true
	else:
		atk=false
		
	if (Input.is_action_pressed("ui_right") and animPlayer!=null):
		get_node("Idle1").flip_h=false
		VelocidadPlayer.x=velocidad
		####Aqui casto la animacion rapido
		if (animPlayer.current_animation=="run" and Input.is_action_pressed("ui_up") ):
			animPlayer.play("runatk1")
		elif (animPlayer.current_animation=="run" and Input.is_action_pressed("ui_down")):
			animPlayer.play("runatk2")
		####A partir de aqui se anima
		elif (animPlayer.is_playing()==false and Input.is_action_pressed("ui_up")==false and Input.is_action_pressed("ui_down")==false and atk==false and animPlayer.current_animation!="jump"):
			animPlayer.play("run")
		elif (animPlayer.is_playing()==false and Input.is_action_pressed("ui_up") ):
			animPlayer.play("runatk1")
		elif (animPlayer.is_playing()==false and Input.is_action_pressed("ui_down") ):
			animPlayer.play("runatk2")
		elif (animPlayer.is_playing()==false and Input.is_action_pressed("ui_up")==false and Input.is_action_pressed("ui_down")==false and atk==true):
			animPlayer.play("atackrun")
		else:
			if (Input.is_action_pressed("ui_up")==false and Input.is_action_pressed("ui_down")==false and animPlayer.current_animation!="jump"):
				animPlayer.play("run")
		
	elif(Input.is_action_pressed("ui_left") and animPlayer!=null):
		get_node("Idle1").flip_h=true
		VelocidadPlayer.x=-velocidad
		####Aqui casto la animacion rapido
		if (animPlayer.current_animation=="run" and Input.is_action_pressed("ui_up") ):
			animPlayer.play("runatk1")
		elif (animPlayer.current_animation=="run" and Input.is_action_pressed("ui_down") ):
			animPlayer.play("runatk2")
		####A partir de aqui se anima
		elif (animPlayer.is_playing()==false and Input.is_action_pressed("ui_up")==false and Input.is_action_pressed("ui_down")==false and atk==false and animPlayer.current_animation!="jump"):
			animPlayer.play("run")
		elif (animPlayer.is_playing()==false and Input.is_action_pressed("ui_up") ):
			animPlayer.play("runatk1")
		elif (animPlayer.is_playing()==false and Input.is_action_pressed("ui_down") ):
			animPlayer.play("runatk2")
		elif (animPlayer.is_playing()==false and Input.is_action_pressed("ui_up")==false and Input.is_action_pressed("ui_down")==false and atk==true):
			animPlayer.play("atackrun")
		else:
			if (Input.is_action_pressed("ui_up")==false and Input.is_action_pressed("ui_down")==false and animPlayer.current_animation!="jump"):
				animPlayer.play("run")
	elif(Input.is_action_pressed("ui_up") and animPlayer!=null):
		VelocidadPlayer.x=0
		if (atk==false):
			animPlayer.play("idle2")
		else:
			if (animPlayer.is_playing()==false):
				animPlayer.play("atk1")
	elif(Input.is_action_pressed("ui_down") and Input.is_action_pressed("ui_right")==false and Input.is_action_pressed("ui_left")==false and animPlayer!=null):
		VelocidadPlayer.x=0
		if (animPlayer.is_playing()==false):
			animPlayer.play("idle3")
	else:
		VelocidadPlayer.x=0
		if (animPlayer!=null and animPlayer.current_animation!="jump"):
			animPlayer.play("idle")
		elif (animPlayer!=null and animPlayer.current_animation=="idle3"):
			animPlayer.play("idle")
			
	######esto es para el piso
	if (is_on_floor()):
		if (Input.is_action_pressed("jump")):
			VelocidadPlayer.y=force_salto
		elif(animPlayer!=null  and animPlayer.current_animation=="jump"):
			animPlayer.play("idle")
	else:
		VelocidadPlayer.y=VelocidadPlayer.y+GRAVEDAD
		if (animPlayer!=null and animPlayer.current_animation!="jump"):
			animPlayer.play("jump")
			print ("esta animanco el jump",animPlayer.current_animation)	
	var movimineto=VelocidadPlayer*delta
	move_and_slide(movimineto, Vector2(0,-1))"""

func _on_Area2D_body_exited(body):
	set_collision_mask_bit(1,true)

func _on_ratAtk_timeout():
	atk=true
