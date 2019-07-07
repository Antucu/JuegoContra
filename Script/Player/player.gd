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
	if (get_node("Position2D")!=null):
		posBal=get_node("Position2D").position.x

func _physics_process(delta):
	if (Input.is_action_pressed("ui_right") and animPlayer!=null):
		get_node("Sprite").flip_h=false
		get_node("Position2D").rotation_degrees=0
		if (Input.is_action_pressed("ui_up")==false or Input.is_action_pressed("ui_down")==false):
			VelocidadPlayer.x=0 
		VelocidadPlayer.x=velocidad
		####A partir de aqui se anima
		if (atk==true and Input.is_action_pressed("atk") and Input.is_action_pressed("ui_down")==false and Input.is_action_pressed("ui_up")==false):
			if(is_on_floor() and animPlayer.current_animation=="run" or animPlayer.current_animation=="idle"):
				animPlayer.play("runatk")
			if(is_on_floor() and animPlayer.is_playing()==false):
				animPlayer.play("runatk")
		if (atk==true and Input.is_action_pressed("atk") and Input.is_action_pressed("ui_up")):
			if(is_on_floor() and animPlayer.current_animation=="run"):
				animPlayer.play("runatk1")
			if(is_on_floor() and animPlayer.is_playing()==false):
				animPlayer.play("runatk1")
			get_node("Position2D").rotation_degrees=-45
		if (atk==true and Input.is_action_pressed("atk") and Input.is_action_pressed("ui_down")):
			if(is_on_floor() and  animPlayer.current_animation=="run"):
				animPlayer.play("runatk2")
				#if (get_node("CollisionShape2D")!=null):
				#	get_node("CollisionShape2D").get_shape().extents.x=15.816
				#	get_node("CollisionShape2D").get_shape().extents.y=33.875
			if(is_on_floor() and animPlayer.is_playing()==false):
				animPlayer.play("runatk2")
				#if (get_node("CollisionShape2D")!=null):
				#	get_node("CollisionShape2D").get_shape().extents.x=15.816
				#	get_node("CollisionShape2D").get_shape().extents.y=33.875
			get_node("Position2D").rotation_degrees=45
		if (is_on_floor() and  animPlayer.is_playing()==false and Input.is_action_pressed("atk")==false):
			animPlayer.play("run")
			get_node("Position2D").rotation_degrees=0
		
	elif(Input.is_action_pressed("ui_left") and animPlayer!=null):
		get_node("Sprite").flip_h=true
		get_node("Position2D").rotation_degrees=180
		VelocidadPlayer.x=-velocidad
		####A partir de aqui se anima
		if (atk==true and Input.is_action_pressed("atk") and Input.is_action_pressed("ui_down")==false and Input.is_action_pressed("ui_up")==false):
			if(is_on_floor() and animPlayer.current_animation=="run"  or animPlayer.current_animation=="idle"):
				animPlayer.play("runatk")
			if(is_on_floor() and animPlayer.is_playing()==false):
				animPlayer.play("runatk")
			get_node("Position2D").rotation_degrees=180
		if (atk==true and Input.is_action_pressed("atk") and Input.is_action_pressed("ui_up")):
			if(is_on_floor() and animPlayer.current_animation=="run"):
				animPlayer.play("runatk1")
				#if (get_node("CollisionShape2D")!=null):
				#	get_node("CollisionShape2D").get_shape().extents.x=15.816
				#	get_node("CollisionShape2D").get_shape().extents.y=33.875
			if(is_on_floor() and animPlayer.is_playing()==false):
				animPlayer.play("runatk1")
				#if (get_node("CollisionShape2D")!=null):
				#	get_node("CollisionShape2D").get_shape().extents.x=15.816
				#	get_node("CollisionShape2D").get_shape().extents.y=33.875
			get_node("Position2D").rotation_degrees=225
		if (atk==true and Input.is_action_pressed("atk") and Input.is_action_pressed("ui_down")):
			if(is_on_floor() and animPlayer.current_animation=="run"):
				animPlayer.play("runatk2")
			if(is_on_floor() and animPlayer.is_playing()==false):
				animPlayer.play("runatk2")
			get_node("Position2D").rotation_degrees=135
		if (is_on_floor() and animPlayer.is_playing()==false and Input.is_action_pressed("atk")==false):
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
				#if (get_node("CollisionShape2D")!=null):
				#	get_node("CollisionShape2D").get_shape().extents.x=33.167
				#	get_node("CollisionShape2D").get_shape().extents.y=16.305
		if (Input.is_action_pressed("ui_left")==false or Input.is_action_pressed("ui_right")==false):
			VelocidadPlayer.x=-0
	else:
		VelocidadPlayer.x=-0
		#if (animPlayer!=null):
		#	animPlayer.play("idle")
		if (is_on_floor() and animPlayer!=null and Input.is_action_pressed("atk")==false and animPlayer.current_animation!="jump"):
			animPlayer.play("idle")
			#if (get_node("CollisionShape2D")!=null):
			#	get_node("CollisionShape2D").get_shape().extents.x=15.816
			#	get_node("CollisionShape2D").get_shape().extents.y=33.875
		if (is_on_floor() and animPlayer!=null and animPlayer.current_animation==null):
			animPlayer.play("idle")
			#if (get_node("CollisionShape2D")!=null):
			#	get_node("CollisionShape2D").get_shape().extents.x=15.816
			#	get_node("CollisionShape2D").get_shape().extents.y=33.875
		if(is_on_floor()==false and animPlayer!=null and animPlayer.is_playing()==false):
			animPlayer.play("jump")
	
	if(Input.is_action_pressed("atk") and atk):
		atk=false
		if (animPlayer!=null and animPlayer.is_playing()==false):
			animPlayer.play("atk1")
		if(get_node("ratAtk")!=null):
			get_node("ratAtk").start()
		var bal=BalaPerphraps.instance()
		get_parent().add_child(bal)
		if (get_node("Position2D")!=null):
			var posBal1=posBal*Vector2(cos(get_node("Position2D").rotation),sin(get_node("Position2D").rotation))
			get_node("Position2D").position=posBal1
			bal.set_position(get_node("Position2D").global_position)
		
			var impulse=800*Vector2(cos(get_node("Position2D").rotation),sin(get_node("Position2D").rotation))
			bal.apply_impulse(Vector2(0,0),impulse)
	#esto es para el piso collider
	if (is_on_floor()):
		if (Input.is_action_pressed("jump")):
			VelocidadPlayer.y=force_salto
			if (animPlayer!=null and animPlayer.is_playing()):
				animPlayer.play("jump")
		elif(animPlayer!=null  and animPlayer.current_animation=="jump"):
			animPlayer.play("idle")
	else:
		VelocidadPlayer.y=VelocidadPlayer.y+GRAVEDAD
		if (animPlayer!=null and animPlayer.is_playing()==false):
			animPlayer.play("jump")
		
	var movimineto=VelocidadPlayer*delta
	move_and_slide(movimineto, Vector2(0,-1))

func _on_Area2D_body_exited(body):
	set_collision_mask_bit(1,true)

func _on_ratAtk_timeout():
	atk=true
