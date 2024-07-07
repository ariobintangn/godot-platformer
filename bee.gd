extends Area2D

var direction_x := 1
var health := 3
@export var speed := 200
@export var marker1: Marker2D
@export var marker2: Marker2D
@onready var target = marker2
var forward := true 


func _ready():
	position = marker1.position

func _on_area_entered(_area):
	health -= 1
	var tween = create_tween()
	tween.tween_property($AnimatedSprite2D, "material:shader_parameter/amount", 1.0, 0.0)
	tween.tween_property($AnimatedSprite2D, "material:shader_parameter/amount", 0.0, 0.2).set_delay(0.2)
	
func _process(delta):
	check_death()
	get_target()
	position += (target.position - position).normalized() * speed * delta
	
func get_target():
	if forward and position.distance_to(marker2.position) < 10 or\
	   not forward and position.distance_to(marker1.position) <10:
		forward = not forward
		$AnimatedSprite2D.flip_h = not $AnimatedSprite2D.flip_h
	if forward:
		target = marker2
	else:
		target = marker1
	

func check_death():
	if health <= 0:
		queue_free()


func _on_body_entered(body):
	if 'get_damage' in body:
		body.get_damage(15)



func _on_border_area_body_entered(_body):
	direction_x *= -1 # Rep
	
	$AnimatedSprite2D.flip_h = not $AnimatedSprite2D.flip_h
