extends Area2D

func _process(delta):
	position.y += sin(Time.get_ticks_msec() / 200.0) * 10 * delta


func _on_body_entered(body):
	body.armed = true
	body.bullet += 5
	queue_free()
	
