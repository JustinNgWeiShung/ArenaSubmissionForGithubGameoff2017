# script player

extends KinematicBody2D

var AIStateClass = load("res://scripts/game/ai_state_handler.gd")
var PlayerStateClass = load("res://scripts/game/player_state_handler.gd")
var Player2StateClass = load("res://scripts/game/player2_state_handler.gd")
var state 

var life=100
var currentDamageRecoverFrame=0
var damageTimer=0

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

var pushbackVector = Vector2(0,0)

var attackHeightToleranceUp = 15
var attackHeightToleranceDown = 15
var attackDirection = 0

var sprite

func _ready():
	groundCollider = get_node("groundCollider")
	groundCollider.setSize(30)
	
	animation = get_node("AnimationPlayer")
	sprite = get_node("Node2D/Sprite")
	
	var p2 = get_parent().get_node("Player2")
	print(p2.get_name())
	if(GLOBAL_SYS.p2ModeEnable):
		if(GLOBAL_SYS.p1_char == GLOBAL_SYS.P1CHAR):
			state = PlayerStateClass.new(self)
		else:
			state = Player2StateClass.new(self)
	else:
		if(GLOBAL_SYS.p1_char == GLOBAL_SYS.P1CHAR):
			state = PlayerStateClass.new(self)
		else:
			state = AIStateClass.new(self,p2)
	#state.set_idle()
	
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true);
	pass

	
func _process(delta):
	
	
	_clampInView()
	
	if(life<=0):
		_KO()
		_handleKO(delta)
		return
	
	var parentTest = get_parent()
	if(parentTest.get_name() == "World"):
		if(parentTest.endRound||parentTest.gameIsOver):
			return
	
	state.aiUpdate(delta)
	
	if(_handleHurt(delta)):
		return
	
	_handleWalk(delta)
	_handleJump(delta)
	_handleAttack(delta)
	_handleZIndex()
	
	pass

func _clampInView():
	# clamping to view
	# i.e. cannot walk out of view
	var view_size = get_viewport_rect().size
	var pos = get_pos()
	pos.x = clamp(pos.x,0+16, view_size.width-16)

func _KO():
	life=0
	state.charState.ko()
	return

func _handleKO(delta):
	if(state.charState.isKO()):
		var currPos = get_pos()
		set_z(0)
		if(attackDirection>0):
			set_pos(Vector2(currPos.x+1,currPos.y))
			set_rot(get_rot()+1)
		else:
			set_pos(Vector2(currPos.x-1,currPos.y))
			set_rot(get_rot()+1)
	return

func _handleZIndex():
	if(state.checkHurt()):
		return
	else:
		if(state.charState.isIdle()||state.charState.isWalking()|| state.charState.isJumping()):
			set_z(get_pos().y+get_item_rect().size.y+height)
	
func _handleHurt(delta):
	if(state.checkHurt()):
		if(currentDamageRecoverFrame>0):
			damageTimer+= delta
			if(damageTimer >= currentDamageRecoverFrame*0.016):
				_reset_damage_recovery_counter()
		return true
	else:
		return false
		
	return false

func _reset_damage_recovery_counter():
	currentDamageRecoverFrame=0
	damageTimer=0
	set_z(get_pos().y+(get_item_rect().size.y)+height)
	state.charState.idle()
			
func _handleWalk(delta):
	var direction = state.checkWalk()
	var currScale = get_scale()
	var invert_scale = Vector2(currScale.x*-1,currScale.y)
	var normal_scale = Vector2(currScale.x,currScale.y)
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
			
	if(state.charState.isAirborne()):
		var gravityPull = gravity*delta#gravity vector
		currentJumpPower += gravity*delta
		
		var jumpPowerDelta = currentJumpPower*delta / get_scale().y#y vector of jump
		height += -(jumpPowerDelta)
		move(Vector2(0,jumpPowerDelta))
		var groundColliderPos = Vector2(groundCollider.get_pos().x,groundCollider.get_pos().y)
		groundColliderPos.y -= jumpPowerDelta / get_scale().y
		groundCollider.set_pos(groundColliderPos)
		var shadowSize = 30-height
		if(shadowSize <0):
			shadowSize=20
		groundCollider.setSize(shadowSize)
		groundCollider.setOffsetY(-height)
		groundCollider.update()
		#jumping power needs to decay over time
		
		
	#Height can never be less than 0
	if(height<0):
		state.charState.endJumping()
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
	state.charState.attack()

func setRecover():
	print("RECOVER STATE")
	state.charState.recover()

func setIdle():
	print("IDLE STATE")
	state.charState.idle()

func setJumpAttack():
	print("JUMP ATTACK STATE")
	state.charState.jump_attack()

func setJumpRecover():
	print("JUMP RECOVER STATE")
	state.charState.jump_recover()

func setJump():
	print("JUMP STATE")
	state.charState.jump()

func damage(lifeDamage,frameDamage):
	life -= lifeDamage
	currentDamageRecoverFrame=frameDamage

func getLife():
	return life

func restart():
	life =100

func getPosY():
	return get_pos().y

func _on_hurtbox_area_enter( area ):
	print("something enter p1 hurtbox")
	#print(area.get_name())
	#var test=area.get_parent()
	#print(test.get_name())
	#state.charState.hurt()
	pass # replace with function body\

func _on_hitbox_area_enter( area ):
	print("something enter p1 hitbox")
	var test = area.get_parent().get_parent()
	var testY = test.getPosY()
	var ourY = get_pos().y
	if(testY < ourY+attackHeightToleranceUp+height && testY > ourY-attackHeightToleranceDown+height ):
		attackDirection = get_pos().x - test.get_pos().x
		test.attackDirection = -attackDirection
		test.state.charState.hurt()
		test.damage(5,5)
		set_z(testY+test.get_item_rect().size.y+test.height+50)
		
	# Enemy enter hitbox
	pass # replace with function body
