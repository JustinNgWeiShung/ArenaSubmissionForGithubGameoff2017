var CharStateClass = load("res://scripts/game/char_state_handler.gd")
var charState
var player

var p2attackLock=false

func _init(player):
	charState = CharStateClass.new(player)
	self.player = player
	pass


##### INPUT CHECKS #####
func checkAttack():
	if(Input.is_action_pressed("P2_ATTACK") && !p2attackLock):
		if(charState.isIdle() || charState.isWalking()):
			if(!charState.isAttacking()):
				play_attack()
			charState.start_attack()
		elif(charState.isAirborne()):
			if(!charState.isJumpAttack() && !charState.isJumpRecover() && !charState.isJumpAttacking()):
				play_jump_attack()
				charState.jump_start_attack()
	p2attackLock=Input.is_action_pressed("P2_ATTACK")

func checkHurt():
	if(charState.isHurt()):
		play_hurt()
		return true
	return false

func checkWalk():
	
	var direction = Vector2(0,0)
	
	if(!charState.isInWalkableState()):
		return direction
		
	if(Input.is_action_pressed("P2_MOVE_RIGHT")):
		direction += Vector2(1,0)
	if(Input.is_action_pressed("P2_MOVE_LEFT")):
		direction += Vector2(-1,0)
	if(Input.is_action_pressed("P2_MOVE_UP")):
		direction += Vector2(0,-1)
	if(Input.is_action_pressed("P2_MOVE_DOWN")):
		direction += Vector2(0,1)
	
	if((direction.x!= 0 || direction.y !=0) 
		&& !charState.isAirborne()
		&& !charState.isInAttackState()):
		charState.walk()
		play_walk()
	else:
		if(!charState.isAirborne() 
		&& !charState.isInAttackState()):
			charState.idle()
			play_idle()
	return direction

func checkJump():
	if(Input.is_action_pressed("P2_JUMP")):
		if(!charState.isAirborne()):
			play_jump()
		charState.jump()
		return true
	else:
		return false

##### ANIMATION PLAYS #####
func play_idle():
	if(player.animation.is_playing()):
		if(charState.check_animation_playing("walk")):
			player.animation.play("idle")
		return
	else:
	#print("play Idle")
		player.animation.play("idle")

func play_walk():
	if(player.animation.is_playing()):
		return
	else:
		player.animation.play("walk")
	#print("play walk")

func play_jump_attack():
	player.animation.play("jump_attack")
			
func play_attack():
	player.animation.play("attack")
	#print("play attack")
	
func play_jump():
	#print("play jump")
	player.animation.play("jump")
	
func play_hurt():
	if(player.animation.is_playing()):
		if(charState.check_animation_playing("walk") || charState.check_animation_playing("idle")):
			player.animation.play("hurt")
		return
	else:
		player.animation.play("hurt")

