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
		&& !isJumping()
		&& !isInAttackState()):
		currentState = STATES.WALK
	else:
		if(!isJumping() 
		&& !isInAttackState()):
			currentState = STATES.IDLE
	return direction

func checkJump():
	if(Input.is_action_pressed("P1_JUMP")):
		if(!isJumping()):
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
func isJumping():
	return currentState == STATES.JUMP

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
	print("play Idle")
	player.animation.play("idle")

func play_block():
	player.animation.play("block")
	print("play block")

func play_walk():
	player.animation.play("walk")
	print("play walk")
	
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