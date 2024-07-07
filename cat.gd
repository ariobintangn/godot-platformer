extends Area2D

var direction_x := 1
var health := 3
@export var speed = 100

func _on_area_entered(_area):
	health -= 1
	var tween = create_tween()
	tween.tween_property($Sprite2D, "material:shader_parameter/amount", 1.0, 0.0)
	tween.tween_property($Sprite2D, "material:shader_parameter/amount", 0.0, 0.2).set_delay(0.2)
	
func _process(delta):
	check_death()
	position.x += speed * delta * direction_x
	

func check_death():
	if health <= 0:
		queue_free()


func _on_body_entered(body):
	if 'get_damage' in body:
		body.get_damage(30) # Replace with function body.



func _on_border_area_body_entered(_body):
	direction_x *= -1 # Rep
	
	$Sprite2D.flip_h = not $Sprite2D.flip_h



func _on_right_cliff_area_body_exited(_body):
	direction_x *= -1 # Rep
	
	$Sprite2D.flip_h = not $Sprite2D.flip_h # Replace with function body.


func _on_left_cliff_area_body_exited(_body):
	direction_x *= -1 # Rep
	
	$Sprite2D.flip_h = not $Sprite2D.flip_h
