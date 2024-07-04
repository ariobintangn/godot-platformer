extends CanvasLayer


@onready var player = get_tree().get_first_node_in_group('Player')

func _process(_delta):
	if player.health >= 0:
		$MarginContainer/health.value = player.health
	elif player.health <= 0:
		player.health = 0
		$MarginContainer/health.value = 0
