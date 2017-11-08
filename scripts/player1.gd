# script player

extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true);
	pass

func _process(delta):
	# tracking mouse
	#var motion = (get_global_mouse_pos().x-get_pos().x) *0.2
	#translate(Vector2(motion,0));
	
	if(Input.is_action_pressed("P1_MOVE_RIGHT")):
		var curPos = get_pos()
		curPos.x+= 100*delta
		set_pos(curPos);
		
	if(Input.is_action_pressed("P1_MOVE_LEFT")):
		var curPos = get_pos()
		curPos.x-= 100*delta
		set_pos(curPos);
		
	# clamping to view
	# i.e. cannot walk out of view
	var view_size = get_viewport_rect().size
	var pos = get_pos()
	pos.x = clamp(pos.x,0+16, view_size.width-16)
	
	pass

#
#func _process(delta):
#    var p1_pos = get_node("p1/char").get_pos()
#    var p2_pos = get_node("p2/char").get_pos()
#    var center_pos = Vector2(p1_pos.x + ((p2_pos.x - p1_pos.x) / 2), 200)
#    get_node("screen_center").set_pos(center_pos)