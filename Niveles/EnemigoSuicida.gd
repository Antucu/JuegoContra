extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocidad_mov = 25
var velocidad_max = 50
var velocidad_salto = 175
var GRAVEDAD = 500
var velocidad = Vector2() 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	velocidad.y += GRAVEDAD * delta
	velocidad.x -= clamp(velocidad_mov,-velocidad_max,velocidad_max)
	$AnimationPlayer.play("caminar")
	var movimiento = velocidad * delta
	move_and_slide(movimiento)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	print("hola")
