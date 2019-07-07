extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocidad_mov = 25
var velocidad_max = 50
var GRAVEDAD = 500
var velocidad = Vector2() 
var balaR = preload("res://Enemigos/Bala.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.flip_h

func _process(delta):
	
	velocidad.y += GRAVEDAD * delta
	var movimiento = velocidad * delta
	move_and_slide(movimiento)
	


func _on_Timer_timeout():
	var newBala = balaR.instance()
	get_parent().add_child(newBala)
	newBala.global_position = $SpawnBala.global_position
	newBala.direccion = newBala.direcciones["izquierda"]
