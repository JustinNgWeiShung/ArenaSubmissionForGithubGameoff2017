extends KinematicBody2D

var PlayerStateClass = load("res://scripts/game/ai_state_handler.gd")
var state

var height=0
var currentJumpPower =0
var jumpPower = 500 
var gravity = 1000
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

func _process(delta):
	
	# clamping to view
	# i.e. cannot walk out of view
	var view_size = get_viewport_rect().size
	var pos = get_pos()
	pos.x = clamp(pos.x,0+16, view_size.width-16)

		
func _on_hitbox_area_enter( area ):
	print("something enter p2 hitbox")
	print(area.get_name())
	pass # replace with function body


func _on_hurtbox_area_enter( area ):
	print("something enter p2 hurtbox")
	
	pass # replace with function body
