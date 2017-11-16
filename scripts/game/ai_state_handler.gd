var STATES={"IDLE":1,
			"ATTACK":2,
			"JUMP":3,
			"JUMP_ATTACK":4,
			"BLOCK":5,
			"WALK":6,
			"RUN":7}

var currentState
var player

func _init(player):
	self.player = player
	currentState=STATES.IDLE
	pass

func get_state():
	return currentState

func test():
	print("ai state handler created")
	print(self.currentState)
	pass

func checkAttacking():
	pass

func checkBlock():
	pass

func checkWalk():
	#var direction = Vector2(0,0)
	#if(Input.is_action_pressed("P1_MOVE_RIGHT")):
	#	direction += Vector2(1,0)
	#if(Input.is_action_pressed("P1_MOVE_LEFT")):
	#	direction += Vector2(-1,0)
	#if(Input.is_action_pressed("P1_MOVE_UP")):
	#	direction += Vector2(0,-1)
	#if(Input.is_action_pressed("P1_MOVE_DOWN")):
	#	direction += Vector2(0,1)
	
	#if((direction.x!= 0 || direction.y !=0) 
	#	&& !isJumping()):
	#	currentState = STATES.WALK
	#else:
	#	if(!isJumping()):
	#		currentState = STATES.IDLE
	#return direction
	pass

func checkJump():
	#if(Input.is_action_pressed("P1_JUMP")):
	#	currentState = STATES.JUMP
	#	return true
	#else:
	#	return false
	pass
	
func isJumping():
	return currentState == STATES.JUMP

func endJumping():
	currentState = STATES.IDLE
		
func isWalking():
	return currentState == STATES.WALK

func set(state):
	currentState = state
	
func check():
	for i in STATES:
		if(STATES[i] == currentState):
			return i

func set_idle():
	print("play Idle")
	player.animation.play("idle")

func set_block():
	player.animation.play("block")

func set_walk():
	player.animation.play("walk")

func set_jump():
	player.animation.play("jump")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass