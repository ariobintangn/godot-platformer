extends CharacterBody2D

var direction_x :float = 0
var facing_right := true
@export var speed := 200

var can_shoot := true
var armed := false
var health := 100
var vulnerable := true

signal shoot(pos: Vector2, direction: bool)

func _process(_delta):
	get_input()
	apply_gravity()
	get_animation()
	get_facing_direction()
	move_and_slide()
	check_death()
	
func get_input():
	
	if Input.is_action_pressed('sprint') and is_on_floor():
		speed = 300
	elif Input.is_action_just_released('sprint'):
		speed = 200	
		
	direction_x = Input.get_axis("ui_left", "ui_right")
	velocity.x = direction_x * speed
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		print('junping')
		velocity.y = -400
	
	if Input.is_action_just_pressed("shoot") and can_shoot:
		print("shoot!")
		shoot.emit(global_position, facing_right)
		can_shoot = false
		$Timers/CooldownTimer.start()
	
	if Input.is_action_just_pressed("equip"):
		armed = not armed
	
func apply_gravity():
	velocity.y += 20
	
func get_facing_direction():
	if direction_x != 0:
		facing_right = direction_x >= 0
		
	
func get_animation():
	var animation = 'idle'
	if not is_on_floor():
		animation = 'jump'
	elif direction_x != 0:
		animation = 'walk'
	if armed:
		animation += "_bone"
	$AnimatedSprite2D.animation = animation
	$AnimatedSprite2D.flip_h = not facing_right

func get_damage(amount):
	if vulnerable:
		health -= amount
	#print("player has been damaged ",health )
		var tween = create_tween()
		tween.tween_property($AnimatedSprite2D, "material:shader_parameter/amount", 1.0, 0.0)
		tween.tween_property($AnimatedSprite2D, "material:shader_parameter/amount", 0.0, 0.2).set_delay(0.2)
		vulnerable = false
		$Timers/VulnerabilityTimer.start()
	
	
func _on_cooldown_timer_timeout():
	print('bisa lagi')
	can_shoot = true # Replace with function body.


func _on_vulnerability_timer_timeout():
	print("vulnerable!")
	vulnerable = true
	
func check_death():
	if health <= 0:
		get_tree().quit()
