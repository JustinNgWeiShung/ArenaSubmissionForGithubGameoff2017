var STATES={"IDLE":1,
			"STARTUP":2,
			"ATTACK":3,
			"RECOVER":4,
			"ATTACK_END":5,
			"JUMP":6,
			"JUMP_STARTUP":7,
			"JUMP_ATTACK":8,
			"JUMP_RECOVER":9,
			"JUMP_ATTACK_END":10,
			"BLOCK":11,
			"WALK":12,
			"RUN":13,
			"DAMAGE":14,
			"DOWN":15,
			"GETUP":16}

var currentState
var player

func _init(player):
	self.player = player
	currentState=STATES.IDLE
	pass

##### INPUT CHECKS #####
func checkAttack():
	if(Input.is_action_pressed("P1_ATTACK")):
		if(currentState == STATES.IDLE || currentState == STATES.WALK):
			if(currentState != STATES.STARTUP):
				play_attack()
			currentState = STATES.STARTUP
		elif(currentState == STATES.JUMP):
			currentState = STATES.JUMP_STARTUP
	
func checkBlock():
	pass

func checkWalk():
	var direction = Vector2(0,0)
	
	if(!isInWalkableState()):
		return direction
		
	if(Input.is_action_pressed("P1_MOVE_RIGHT")):
		direction += Vector2(1,0)
	if(Input.is_action_pressed("P1_MOVE_LEFT")):
		direction += Vector2(-1,0)
	if(Input.is_action_pressed("P1_MOVE_UP")):
		direction += Vector2(0,-1)
	if(Input.is_action_pressed("P1_MOVE_DOWN")):
		direction += Vector2(0,1)
	
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
	if(Input.is_action_pressed("P1_JUMP")):
		if(!isAirborne()):
			play_jump()
		currentState = STATES.JUMP
		
		return true
	else:
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
	
##### STATE CHECKS ######
func isAirborne():
	return isJumping() || isJumpAttack() || isJumpRecover() || isJumpAttacking()

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
	#print("play Idle")
	player.animation.play("idle")

func play_block():
	player.animation.play("block")
	print("play block")

func play_walk():
	if(player.animation.is_playing()):
		player.animation.advance(0.01)
	else:
		player.animation.play("walk")
	#print("play walk")
	
func play_attack():
	player.animation.play("attack")
	print("play attack")
	
func play_jump():
	print("play jump")
	player.animation.play("jump")

##### EXTRA HELPER FUNCTIONS #####
func set(state):
	currentState = state

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