class_name Player
extends CharacterBody2D
const ACCELERATION=20
const FRICTION=20
var player_attacking_enemy=false
var enemy
@onready var speed=100

func _ready():
	$PlayerHealthController/PlayerHealthBar.value=Globals.player_health
	$PlayerRecoveryTimer.start()
	if Globals.position_state==1:
		global_position=Globals.player_initial_position
		Globals.position_state=2
	if Globals.position_state==3:
		global_position=Globals.player_world_gate_position
func _process(delta):
	var input_direction=Input.get_vector("left","right","top","down")
	animation(input_direction)
	if input_direction>Vector2.ZERO or input_direction<Vector2.ZERO:
		if input_direction.x>0 or input_direction.x<0:  #for left right motion downword and upward motion should be zero
			input_direction.y=0
		if input_direction.y>0 or input_direction.y<0:  #for up down motion forward backward motion is zero so you cant go forward and backward
			input_direction.x=0
		velocity=lerp(velocity,input_direction*speed,ACCELERATION*delta)
	if input_direction==Vector2.ZERO:
		velocity=lerp(velocity,input_direction*speed,delta*FRICTION)
	move_and_slide()
func animation(input_direction:Vector2):
	match input_direction:
		Vector2.ZERO:
			$AnimatedSprite2D.play("idle")
		Vector2.LEFT:
			$AnimatedSprite2D.flip_h=true
			$AnimatedSprite2D.play("right_walk")
		Vector2.RIGHT:
			$AnimatedSprite2D.flip_h=false
			$AnimatedSprite2D.play("right_walk")
		Vector2.UP:
			$AnimatedSprite2D.play("up_walk")
		Vector2.DOWN:
			$AnimatedSprite2D.play("down_walk")
func hit():
	if Globals.player_health<=0:
		Globals.player_health=0
		$AnimatedSprite2D.play("death")
		queue_free()
		get_tree().change_scene_to_file("res://Ui/home_screen.tscn")
	else:
		$PlayerRecoveryTimer.start()
		Globals.player_health-=1
		$PlayerHealthController/PlayerHealthBar.value=Globals.player_health

func _on_player_recovery_timer_timeout():
	if Globals.player_health>=100:
		Globals.player_health=100
		$PlayerRecoveryTimer.stop()
	elif Globals.player_health<100:
		Globals.player_health+=5
		$PlayerHealthController/PlayerHealthBar.value=Globals.player_health
		$PlayerRecoveryTimer.start()
	else:
		$PlayerRecoveryTimer.stop()

func _on_player_attack_area_body_entered(body):
	if body is Enemy:
		enemy=body
		player_attacking_enemy=true

func _on_player_attack_area_body_exited(body):
	if body is Enemy:
		player_attacking_enemy=false
func _input(event):
	if event.is_action_pressed("attack") and player_attacking_enemy:
		$AnimatedSprite2D.play("down_fight")
		if "hit" in enemy:
			enemy.hit()

