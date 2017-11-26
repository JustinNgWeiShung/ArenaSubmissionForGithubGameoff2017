extends CollisionShape2D

var player
var shadowSize=0
var groundCollider
var offsetY =0
func _ready():
	player=get_parent()
	pass

func setSize(value):
	shadowSize=value

func setOffsetY(value):
	offsetY=value

func _draw():
	var pos = get_pos()
	var pos2 = player.get_pos()
	
	var offset = Vector2(0,offsetY)
	var center = Vector2(pos.x,pos.y-shadowSize/2+offsetY)
	var radius = shadowSize
	var angle_from = 0
	var angle_to = 180
	var angle_from2 = 180
	var angle_to2 = 360
	
	var color = Color(0.0, 0.0, 0.0,0.1)
	draw_circle_arc_poly( center, radius, angle_from, angle_to, color )
	draw_circle_arc_poly( center, radius, angle_from2, angle_to2, color )

func draw_circle_arc_poly( center, radius, angle_from, angle_to, color ):
	var nb_points = 36
	var points_arc = Vector2Array()
	points_arc.push_back(center)
	var colors = ColorArray([color])
	for i in range(nb_points+1):
		var angle_point = angle_from + i*(angle_to-angle_from)/nb_points - 90
		points_arc.push_back(center + Vector2( cos( deg2rad(angle_point) ), sin( deg2rad(angle_point) ) ) * radius)
	
	draw_polygon(points_arc, colors)
	#your draw commands here
	pass