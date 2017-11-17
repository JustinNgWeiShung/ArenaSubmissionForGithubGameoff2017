# script player

extends KinematicBody2D

var AIStateClass = load("res://scripts/game/ai_state_handler.gd")
var PlayerStateClass = load("res://scripts/game/player_state_handler.gd")
var state 

var height=0
var currentJumpPower =0

var minJumpHeight = 50
var jumpLockToEnd=false
var jumpPower = -400 
var maxJumpPower = -1000
var gravity = 3500
var walkSpeed = 200
var runSpeed = 300
var groundCollider
var animation

func _ready():
	groundCollider = get_node("groundCollider")
	animation = get_node("AnimationPlayer")
	
	state = PlayerStateClass.new(self)
	#state.set_idle()
	
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true);
	set_process_input(true);
	pass

func _input(event):
		
	pass
	
func _process(delta):
	_handleWalk(delta)
	_handleJump(delta)
	_handleAttack(delta)
	
	_clampInView()
	
	pass

func _clampInView():
	# clamping to view
	# i.e. cannot walk out of view
	var view_size = get_viewport_rect().size
	var pos = get_pos()
	pos.x = clamp(pos.x,0+16, view_size.width-16)

func _handleWalk(delta):
	var direction = state.checkWalk()
	var invert_scale = Vector2(-1,1)
	var normal_scale = Vector2(1,1)
	if(direction.x < 0):
		set_scale(invert_scale)
	elif(direction.x>0):
		set_scale(normal_scale)
	move(direction * walkSpeed * delta)
	pass

func _handleJump(delta):
	#####new jump function#####
	
	#initially on ground
	if(height <=0):
		#initial jump check
		if(state.checkJump()):
			# set the initial jump speed
			currentJumpPower = jumpPower
	else:
		if(state.checkJump() && height < minJumpHeight && !jumpLockToEnd):
			currentJumpPower = jumpPower * 1.5
			if(currentJumpPower<maxJumpPower):
				currentJumpPower=maxJumpPower
	
	if(height > minJumpHeight):
		jumpLockToEnd=true
	
	#else:
		# character is in mid flight
		#if(state.checkJump()):
			# button is still held
			# maintain the power
		#	currentJumpPower = jumpPower
		#else:
			#jump power needs to decay
		#	currentJumpPower = currentJumpPower/1.5
			
	if(state.isAirborne()):
		var gravityPull = gravity*delta #gravity vector
		currentJumpPower += gravity*delta
		var jumpPowerDelta = currentJumpPower*delta #y vector of jump
		height += -(jumpPowerDelta)
		move(Vector2(0,jumpPowerDelta))
		var groundColliderPos = Vector2(groundCollider.get_pos().x,groundCollider.get_pos().y)
		groundColliderPos.y -= jumpPowerDelta
		groundCollider.set_pos(groundColliderPos)
		#jumping power needs to decay over time
		
		
	#Height can never be less than 0
	if(height<0):
		state.endJumping()
		move(Vector2(0,0+height))
		height=0
		currentJumpPower=0
		jumpLockToEnd=false

func _handleAttack(delta):
	state.checkAttack()
	pass
#func _process(delta):
#    var p1_pos = get_node("p1/char").get_pos()
#    var p2_pos = get_node("p2/char").get_pos()
#    var center_pos = Vector2(p1_pos.x + ((p2_pos.x - p1_pos.x) / 2), 200)
#    get_node("screen_center").set_pos(center_pos)

func setAttack():
	print("ATTACK STATE")
	state.attack()

func setRecover():
	print("RECOVER STATE")
	state.recover()

func setIdle():
	print("IDLE STATE")
	state.idle()

func _on_hurtbox_area_enter( area ):
	print("something enter p1 hurtbox")
	print(area.get_name())
	var test=area.get_parent()
	print(test.get_name())
	pass # replace with function body\

func _on_hitbox_area_enter( area ):
	
	print("something enter p1 hitbox")
	# Enemy enter hitbox
	pass # replace with function body
