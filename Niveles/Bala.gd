extends KinematicBody2D

var direccion = Vector2() setget _set_direccion
var velocidad = Vector2()
var vel_lateral = 1000
var vel_max = 2000
enum direcciones {izquierda = -1,derecha =1}
func _ready():
	velocidad.x=0
	velocidad.y=0

func _process(delta):
	velocidad.x -= direccion.x * vel_lateral
	velocidad.x = clamp(vel_lateral,-vel_max,vel_max)
	var movimiento = velocidad * delta
	move_and_slide(movimiento)
	
func _set_direccion(value):
	direccion = Vector2(value,0)
