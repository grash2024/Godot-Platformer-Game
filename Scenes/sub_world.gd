extends Node2D
var player_node=preload("res://Characters/player.tscn")
var player
func _ready():
	Globals.position_state=2
	player=player_node.instantiate()
	player.global_position=Globals.player_sub_world_position
	call_deferred("add_child",player)
	
