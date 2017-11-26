var CharStateClass = load("res://scripts/game/char_state_handler.gd")
var charState
var player

var aiattackLock=false
var aiattacklockTime = 0
var enemyPlayer

func _init(player,p2):
	enemyPlayer = p2
	charState = CharStateClass.new(player)
	self.player = player
	pass

func aiUpdate(delta):
	if(aiattackLock):
		aiattacklockTime+=delta
		if(aiattacklockTime>1):
			aiattackLock=false
	pass

##### INPUT CHECKS #####
func checkAttack():
	# ai needs to decide how to attack
	if(decideAttack() && !aiattackLock):
		if(charState.isIdle() || charState.isWalking()):
			if(!charState.isAttacking()):
				play_attack()
			charState.start_attack()
		elif(charState.isAirborne()):
			if(!charState.isJumpAttack() && !charState.isJumpRecover() && !charState.isJumpAttacking()):
				play_jump_attack()
				charState.jump_start_attack()
	aiattackLock=decideAttack()
	#if(Input.is_action_pressed("P1_ATTACK") && !aiattackLock):
	#	if(charState.isIdle() || charState.isWalking()):
	#		if(!charState.isAttacking()):
	#			play_attack()
	#		charState.start_attack()
	#	elif(charState.isAirborne()):
	#		if(!charState.isJumpAttack() && !charState.isJumpRecover() && !charState.isJumpAttacking()):
	#			play_jump_attack()
	#			charState.jump_start_attack()
	#aiattackLock=Input.is_action_pressed("P1_ATTACK")
	pass
	
func decideAttack():
	var pos = enemyPlayer.get_pos()
	var currPos = player.get_pos()
	
	var diffX = abs(currPos.x - pos.x)
	var diffY = abs(currPos.y - pos.y)
	
	if(diffX < 50 && diffY < 10 ):
		return true
	else:
		return false
	pass

func checkHurt():
	if(charState.isHurt()):
		play_hurt()
		return true
	return false

func checkWalk():
	#AI needs to decide how to walk	
	
	var direction = Vector2(0,0)
	
	if(!charState.isInWalkableState()):
		return direction
	
	direction = decideWalk()
	#if(Input.is_action_pressed("P1_MOVE_RIGHT")):
		#direction += Vector2(1,0)
	#if(Input.is_action_pressed("P1_MOVE_LEFT")):
		#direction += Vector2(-1,0)
	#if(Input.is_action_pressed("P1_MOVE_UP")):
		#direction += Vector2(0,-1)
	#if(Input.is_action_pressed("P1_MOVE_DOWN")):
		#direction += Vector2(0,1)
	
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

func decideWalk():
	var direction = Vector2(0,0)
	
	var pos = player.get_pos()
	var pos2 = enemyPlayer.get_pos()
	var diffX= pos2.x-pos.x
	var diffY= pos2.y-pos.y
	var diffVector = Vector2(diffX,diffY)
	var oppVector = Vector2(-diffX,-diffY)
	diffVector = diffVector.normalized()
	if(abs(diffX) > 30 || abs(diffY) > 10):
		direction = diffVector
	else:
		direction = oppVector
	return direction
	
	pass

func checkJump():
	# Ai needs to decide when to jump
	#if(Input.is_action_pressed("P1_JUMP")):
	#	if(!charState.isAirborne()):
	#		play_jump()
	#	charState.jump()
	#	return true
	#else:
	#	return false
	if(!charState.isAirborne()):
		return true
	else:
		return false
	#		play_jump()
	#	charState.jump()

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

