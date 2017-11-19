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
			"HURT":14,
			"DOWN":15,
			"GETUP":16}

var currentState
var player

func _init(player):
	self.player = player
	currentState=STATES.IDLE
	pass
	
##### STATE SETTERS ######
func endJumping():
	idle()

func walk():
	currentState = STATES.WALK
		
func idle():
	currentState = STATES.IDLE

func start_attack():
	currentState = STATES.STARTUP

func attack():
	currentState = STATES.ATTACK
	
func recover():
	currentState = STATES.RECOVER

func hurt():
	currentState = STATES.HURT

func jump():
	currentState = STATES.JUMP

func jump_start_attack():
	currentState=STATES.JUMP_STARTUP

func jump_attack():
	currentState = STATES.JUMP_ATTACK
	
func jump_recover():
	currentState = STATES.JUMP_RECOVER
	
##### STATE CHECKS ######
func isInWalkableState():
	return isIdle() || isAirborne() || isWalking()

func isInAttackState():
	return isAttack() || isAttacking() || isFinishAttack()

func isAirborne():
	return isJumping() || isJumpAttack() || isJumpRecover() || isJumpAttacking()

func isIdle():
	return currentState == STATES.IDLE
	
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

func isAttacking():
	return currentState == STATES.STARTUP

func isAttack():
	return currentState == STATES.ATTACK

func isFinishAttack():
	return currentState == STATES.RECOVER

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
