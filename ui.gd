extends CanvasLayer

var gun_icon_texture = preload("res://graphic/bone-small.0001.png")
var gun_icon_texture_rect: TextureRect = null
@onready var gun = get_tree().get_first_node_in_group("Gun")
@onready var player = get_tree().get_first_node_in_group('Player')


func _ready():
	gun_icon_texture_rect = TextureRect.new()
	gun_icon_texture_rect.texture = gun_icon_texture
	
func _process(_delta):
	if player.health >= 0:
		$MarginContainer/VBoxContainer/health.value = player.health
	elif player.health <= 0:
		player.health = 0
		$MarginContainer/VBoxContainer/health.value = 0
	
	if player.armed:
		$MarginContainer/VBoxContainer/items2/Label.text = 'x' + str(player.bullet)
		if not gun_icon_texture_rect.is_inside_tree():
			$MarginContainer/VBoxContainer/items2.add_child(gun_icon_texture_rect)
