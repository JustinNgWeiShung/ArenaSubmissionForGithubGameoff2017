# script player

extends KinematicBody2D

var height=0
var currentJumpPower =0
var jumpPower = 500 
var gravity = 1000
var walkSpeed = 200
var runSpeed = 300
var groundCollider

func _ready():
	groundCollider = get_node("groundCollider")
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true);
	pass

func _process(delta):
	# tracking mouse
	#var motion = (get_global_mouse_pos().x-get_pos().x) *0.2
	#translate(Vector2(motion,0));
	var direction = Vector2(0,0)
	if(Input.is_action_pressed("P1_MOVE_RIGHT")):
		direction += Vector2(1,0)
	if(Input.is_action_pressed("P1_MOVE_LEFT")):
		direction += Vector2(-1,0)
	if(Input.is_action_pressed("P1_MOVE_UP")):
		direction += Vector2(0,-1)
	if(Input.is_action_pressed("P1_MOVE_DOWN")):
		direction += Vector2(0,1)
	move( direction * walkSpeed * delta)
	
	if(Input.is_action_pressed("P1_JUMP")):
		if(height ==0):
			currentJumpPower=jumpPower;
	
	var currentDeltaJumpPower=currentJumpPower*delta;
	
	currentJumpPower-=gravity*delta
	height+=currentDeltaJumpPower
	
	move(Vector2(0,-currentDeltaJumpPower))
	
	var groundColliderPos = Vector2(groundCollider.get_pos().x,groundCollider.get_pos().y)
	groundColliderPos.y += currentDeltaJumpPower
	groundCollider.set_pos(groundColliderPos)
	if(!_is_jumping()):
		move(Vector2(0,0-height))
		height =0;
		currentJumpPower=0;
		
	
	# clamping to view
	# i.e. cannot walk out of view
	var view_size = get_viewport_rect().size
	var pos = get_pos()
	pos.x = clamp(pos.x,0+16, view_size.width-16)
	
	pass

func _is_jumping():
	if(height>0):
		return true
	else:
		return false

#func _process(delta):
#    var p1_pos = get_node("p1/char").get_pos()
#    var p2_pos = get_node("p2/char").get_pos()
#    var center_pos = Vector2(p1_pos.x + ((p2_pos.x - p1_pos.x) / 2), 200)
#    get_node("screen_center").set_pos(center_pos)


func _on_hurtbox_area_enter( area ):
	print("something enter hurtbox")
	print(area.get_name())
	var test=area.get_parent()
	print(test.get_name())
	pass # replace with function body\

func _on_hitbox_area_enter( area ):
	# Enemy enter hitbox
	pass # replace with function body
