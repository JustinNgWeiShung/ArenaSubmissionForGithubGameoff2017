extends Panel

var selectionBox
var p1Portrait
var p2Portrait
var selectedPortrait
var actionLock=false
var selectLock=false

func _ready():
	selectionBox = get_node("Selection box")
	p1Portrait= get_node("p1Button")
	p2Portrait=get_node("p2Button")
	_setSelectionBoxPos(p1Portrait);
	set_process(true);
	
	pass
	
func _setSelectionBoxPos(portrait):
	selectedPortrait=portrait;
	var newPos = Vector2(selectedPortrait.get_pos().x+
							(selectionBox.get_item_rect().size.x*selectionBox.get_scale().x)/2* selectedPortrait.get_scale().x
							,selectedPortrait.get_pos().y+(selectionBox.get_item_rect().size.y*selectionBox.get_scale().y)/2);
	selectionBox.set_pos(newPos);
	
func _process(delta):
	_effectCheck()
	_playerInputCheck()
	
	get_node("/root/GLOBAL_INPUT").quitGame();
	#if(Input.is_mouse_button_pressed(BUTTON_LEFT)):
		#print(str("Mouse Button pressed at: ", get_global_mouse_pos()));
		
	pass
	
func _effectCheck():
	GLOBAL_INPUT.changeEffect();
	
	if(GLOBAL_SYS.effect == 0):
		get_node("overlay").hide()
	else:
		get_node("overlay").show()
		
func _playerInputCheck():
	
	if(selectedPortrait==p1Portrait):
		if((Input.is_action_pressed("P1_MOVE_RIGHT") || Input.is_action_pressed("P1_MOVE_LEFT")) && !actionLock):
			_setSelectionBoxPos(p2Portrait)
	else:
		if((Input.is_action_pressed("P1_MOVE_RIGHT") || Input.is_action_pressed("P1_MOVE_LEFT")) && !actionLock):
			_setSelectionBoxPos(p1Portrait)
	
	if(Input.is_action_pressed("ui_accept") && !selectLock):
		selectedPortrait.pressed()
		
	selectLock = Input.is_action_pressed("ui_accept")
	actionLock = Input.is_action_pressed("P1_MOVE_RIGHT") || Input.is_action_pressed("P1_MOVE_LEFT")