extends CharacterBody2D

var enemy_inatk_range = false
var enemy_atk_cd = true
var hp = 100
var player_alive = true

const speed = 100
var current_dir = "none"

func _physics_process(delta):
	player_movement(delta)
	enemy_attack()
	
	if hp <= 0:
		player_alive = false #death screen/menu
		hp = 0
		print("player dead")
		self.queue_free()

func _ready():
	$AnimatedSprite2D.play("front_idle")

func player_movement(delta):
	
	if Input.is_action_pressed("ui_right")	:
		current_dir = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left")	:
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down")	:
		current_dir = "down"
		play_anim(1)
		velocity.x = 0
		velocity.y = speed
	elif Input.is_action_pressed("ui_up")	:
		current_dir = "up"
		play_anim(1)
		velocity.x = 0
		velocity.y = -speed
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
	
	move_and_slide()

func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
	elif dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
	
	elif dir == "down":
		anim.flip_h = false
		if movement == 1:
			anim.play("front_walk")
		elif movement == 0:
			anim.play("front_idle")
	
	elif dir == "up":
		anim.flip_h = false
		if movement == 1:
			anim.play("back_walk")
		elif movement == 0:
			anim.play("back_idle")

func player():
	pass

func _on_player_hitbox_body_entered(body: Node2D):
	if body.has_method("enemy"):
		enemy_inatk_range = true


func _on_player_hitbox_body_exited(body: Node2D):
	if body.has_method("enemy"):
		enemy_inatk_range = false
		
func enemy_attack():
	if enemy_inatk_range and enemy_atk_cd:
		hp -= 10
		enemy_atk_cd = false
		$attack_cd.start()
		print(hp)


func _on_attack_cd_timeout():
	enemy_atk_cd = true
