extends CharacterBody2D

var speed = 40
var player_chase = false
var player = null

var hp = 100
var player_inatk_range = false

func _physics_process(delta):
	take_damage()
	
	if player_chase:
		position += (player.position - position)/speed
		
		move_and_collide(Vector2(0,0))
		
		$AnimatedSprite2D.play("side_walk")
		
		$AnimatedSprite2D.flip_h = (player.position.x < position.x)
	else:
		$AnimatedSprite2D.play("side_idle")

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true


func _on_detection_area_body_exited(body):
	player = null
	player_chase = false

func enemy():
	pass


func _on_enemy_hitbox_body_entered(body: Node2D):
	if body.has_method("player"):
		player_inatk_range = true


func _on_enemy_hitbox_body_exited(body: Node2D):
	if body.has_method("player"):
		player_inatk_range = false

func take_damage():
	if player_inatk_range and main.player_current_attack:
		hp -= 20
		print("slime hp", hp)
		if hp <= 0:
			self.queue_free()
	
