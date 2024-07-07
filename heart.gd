extends Area2D

func _process(delta):
	position.y += sin(Time.get_ticks_msec() / 200.0) * 20 * delta



func _on_body_entered(body):
	if body.health < 100:
		body.health += 40 # Replace with function body.
		queue_free()
