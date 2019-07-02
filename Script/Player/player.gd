extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var GRAVEDAD=800
export var velocidad=150
export var force_salto=30

var VelocidadPlayer=Vector2(0,0)

export(NodePath) var animPlayerPath=null
var animPlayer: AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	velocidad=velocidad*100
	force_salto=(force_salto*1000)*-1
	animPlayer=get_node("AnimationPlayer")

func _physics_process(delta):
	#VelocidadPlayer.y=VelocidadPlayer.y+GRAVEDAD
	if(is_on_floor()):
		if (animPlayer!=null and animPlayer.current_animation=="jump"):
			animPlayer.play("idle1")
		if(Input.is_action_pressed("ui_up")):
			VelocidadPlayer.y=force_salto
	else:
		VelocidadPlayer.y=VelocidadPlayer.y+GRAVEDAD
		if (animPlayer!=null and animPlayer.is_playing()):
				animPlayer.play("jump")
		
	if (Input.is_action_pressed("ui_right")):
		VelocidadPlayer.x=velocidad
		if (get_node("Idle1")!=null):
			get_node("Idle1").flip_h=false
		if (animPlayer!=null and animPlayer.current_animation=="idle1" and is_on_floor()):
			animPlayer.play("run")
		if (animPlayer!=null and animPlayer.is_playing()==false and is_on_floor()):
			animPlayer.play("run")
		
		
	elif (Input.is_action_pressed("ui_left")):
		VelocidadPlayer.x=-velocidad
		if (get_node("Idle1")!=null):
			get_node("Idle1").flip_h=true
		if (animPlayer!=null and animPlayer.current_animation=="idle1" and is_on_floor()):
			animPlayer.play("run")
		if (animPlayer!=null and animPlayer.is_playing()==false and is_on_floor()):
			animPlayer.play("run")
	
	elif(Input.is_action_just_pressed("ui_down")):
		set_collision_mask_bit(1,false)
		
	else:
		VelocidadPlayer.x=0
		if (animPlayer!=null):
			if (animPlayer.current_animation=="run"):
				animPlayer.play("idle1")
		if (animPlayer!=null  and animPlayer.is_playing()==false):
			animPlayer.play("idle1")
		
	var movimineto=VelocidadPlayer*delta
	move_and_slide(movimineto, Vector2(0,-1))

func _on_Area2D_body_exited(body):
	set_collision_mask_bit(1,true)

