extends "res://scripts/game/char_state_handler.gd"

func  _init(player).(player):
	self.player = player
	currentState=STATES.IDLE
	pass

##### INPUT CHECKS #####
func checkAttack():
	#if(Input.is_action_pressed("P1_ATTACK")):
	#	if(currentState == STATES.IDLE || currentState == STATES.WALK):
	#		if(currentState != STATES.STARTUP):
	#			play_attack()
	#		currentState = STATES.STARTUP
	#	elif(currentState == STATES.JUMP):
	#		currentState = STATES.JUMP_STARTUP
	return
		
func checkBlock():
	pass

func checkHurt():
	if(isHurt()):
		play_hurt()
		return true
	return false

func checkWalk():
	var direction = Vector2(0,0)
	
	if(!isInWalkableState()):
		return direction
		
	#if(Input.is_action_pressed("P1_MOVE_RIGHT")):
	#	direction += Vector2(1,0)
	#if(Input.is_action_pressed("P1_MOVE_LEFT")):
	#	direction += Vector2(-1,0)
	#if(Input.is_action_pressed("P1_MOVE_UP")):
	#	direction += Vector2(0,-1)
	#if(Input.is_action_pressed("P1_MOVE_DOWN")):
	#	direction += Vector2(0,1)
	
	if((direction.x!= 0 || direction.y !=0) 
		&& !isAirborne()
		&& !isInAttackState()):
		currentState = STATES.WALK
		play_walk()
	else:
		if(!isAirborne() 
		&& !isInAttackState()):
			currentState = STATES.IDLE
			play_idle()
	return direction

func checkJump():
	#if(Input.is_action_pressed("P1_JUMP")):
	#	if(!isAirborne()):
	#		play_jump()
	#	currentState = STATES.JUMP
	#	
	#	return true
	#else:
	#	return false
	return false

##### STATE SETTERS ######
func endJumping():
	idle()
	
func idle():
	currentState = STATES.IDLE

func attack():
	currentState = STATES.ATTACK
	
func recover():
	currentState = STATES.RECOVER

func hurt():
	currentState = STATES.HURT
	
##### STATE CHECKS ######
func isAirborne():
	return isJumping() || isJumpAttack() || isJumpRecover() || isJumpAttacking()

func isHurt():
	return currentState == STATES.HURT

func isJumping():
	return currentState == STATES.JUMP 

func isJumpAttacking():
	return currentState == STATES.JUMP_STARTUP
	
func isJumpAttack():
	return currentState == STATES.JUMP_ATTACK
	
func isJumpRecover():
	return currentState == STATES.JUMP_RECOVER

func isWalking():
	return currentState == STATES.WALK

func isInWalkableState():
	return currentState == STATES.IDLE || currentState == STATES.JUMP || currentState == STATES.WALK

func isInAttackState():
	return isAttack() || isAttacking() || isFinishAttack()

func isAttacking():
	return currentState == STATES.STARTUP

func isAttack():
	return currentState == STATES.ATTACK

func isFinishAttack():
	return currentState == STATES.RECOVER

##### ANIMATION PLAYS #####
func play_idle():
	if(player.animation.is_playing()):
		if(check_animation_playing("walk")):
			player.animation.play("idle")
		return
	else:
	#print("play Idle")
		player.animation.play("idle")

func play_block():
	player.animation.play("block")
	#print("play block")

func play_walk():
	if(player.animation.is_playing()):
		return
	else:
		player.animation.play("walk")
	#print("play walk")
	
func play_attack():
	player.animation.play("attack")
	#print("play attack")
	
func play_jump():
	#print("play jump")
	player.animation.play("jump")
	
func play_hurt():
	if(player.animation.is_playing()):
		if(check_animation_playing("walk") || check_animation_playing("idle")):
			player.animation.play("hurt")
		return
	else:
		player.animation.play("hurt")

##### EXTRA HELPER FUNCTIONS #####
func set(state):
	currentState = state

func check_animation_playing(name):
	if(player.animation.get_current_animation() == name):
		return true
	else:
		return false

func get_state():
	return currentState
		
func check():
	for i in STATES:
		if(STATES[i] == currentState):
			return i

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass