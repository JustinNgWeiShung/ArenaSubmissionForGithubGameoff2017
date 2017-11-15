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
	var direction = Vector2(0,0)
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
	
func _is_jumping():
	if(height>0):
		return true
	else:
		return false
		
func _on_hitbox_area_enter( area ):
	print("something enter hitbox")
	print(area.get_name())
	pass # replace with function body


func _on_hurtbox_area_enter( area ):
	
	pass # replace with function body
