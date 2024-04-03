class_name Enemy
extends CharacterBody2D
var attack=false
var player
var speed=50
func _ready():
	$AnimatedSprite2D.play("idle")
func _process(delta):
	if attack:
		move_towards_player()
		check_distance()
func hit():
	if Globals.enemy_health<=0:
		Globals.enemy_health=0
		$AnimatedSprite2D.play("death")
		await $AnimatedSprite2D.animation_finished
		queue_free()
	else:
		Globals.enemy_health-=10

func move_towards_player():
	var direction=global_position.direction_to(player.global_position)
	velocity=direction*speed
	move_and_slide()
func _on_enemy_attacking_player_area_body_entered(body):
	if body is Player:
		print("Player")
		$AnimatedSprite2D.play("motion")
		player=body
		attack=true

func _on_enemy_attacking_player_area_body_exited(body):
	if body is Player:
		attack=false
func check_distance():
	var distance=global_position.distance_to(player.global_position)
	if distance<=10:
		$AnimatedSprite2D.play("attack")
		if "hit" in player:
			player.hit()
