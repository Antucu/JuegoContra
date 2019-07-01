extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var GRAVEDAD=600
export var velocidad=150
export var force_salto=30

var VelocidadPlayer=Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	velocidad=velocidad*100
	force_salto=(force_salto*1000)*-1

func _physics_process(delta):
	#VelocidadPlayer.y=VelocidadPlayer.y+GRAVEDAD
	if(is_on_floor()):
		if(Input.is_action_pressed("ui_up")):
			VelocidadPlayer.y=force_salto
	else:
		VelocidadPlayer.y=VelocidadPlayer.y+GRAVEDAD
		
	if (Input.is_action_pressed("ui_right")):
		VelocidadPlayer.x=velocidad
		
	elif (Input.is_action_pressed("ui_left")):
		VelocidadPlayer.x=-velocidad
	
	elif(Input.is_action_just_pressed("ui_down")):
		set_collision_mask_bit(1,false)
		

	else:
		VelocidadPlayer.x=0
	
		
	var movimineto=VelocidadPlayer*delta
	move_and_slide(movimineto, Vector2(0,-1))

func _on_Area2D_body_exited(body):
	set_collision_mask_bit(1,true)
