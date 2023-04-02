extends Node2D

onready var mask: Sprite = $Viewport/Mask

var esper_scene: Resource = load("res://src/entity/esper/esper.tscn")
var fluffy_scene: Resource = load("res://src/entity/fluffy/fluffy.tscn")

var esper: KinematicBody2D
var fluffy: KinematicBody2D

var room_coords: Vector2
var from: String

onready var DOORS: Dictionary = {
	"UP": {
		"ts": $DOORS/UP,
		"pos": $DOORS/UP/Position2D
	},
	"DOWN": {
		"ts": $DOORS/DOWN,
		"pos": $DOORS/DOWN/Position2D
	},
	"LEFT": {
		"ts": $DOORS/LEFT,
		"pos": $DOORS/LEFT/Position2D
	},
	"RIGHT": {
		"ts": $DOORS/RIGHT,
		"pos": $DOORS/RIGHT/Position2D
	},
	"SPAWN": {
		"ts": $DOORS/CENTER,
		"pos": $DOORS/CENTER/Position2D
	}
}

func _ready():
	Gamestate.connect("load_room", self, "_load_room")

func _load_first_spawn():
	esper = esper_scene.instance()
	fluffy = fluffy_scene.instance()
	esper.position = DOORS.SPAWN.pos.position
	fluffy.position = Utils.rand_vicinity(DOORS.SPAWN.pos.position)
	self.add_child(esper)
	self.add_child(fluffy)

func _process(delta):
	mask.position = fluffy.position
	mask.look_at(get_global_mouse_position())

func _load_room(room_coords: Vector2, from: String):
	self.room_coords = room_coords
	self.from = from
	
	if (Shortlivedconfig.map_matrix[room_coords.x-1][room_coords.y].id != -1):
		DOORS.LEFT.ts.visible = true
	if (Shortlivedconfig.map_matrix[room_coords.x+1][room_coords.y].id != -1):
		DOORS.RIGHT.ts.visible = true
	if (Shortlivedconfig.map_matrix[room_coords.x][room_coords.y-1].id != -1):
		DOORS.UP.ts.visible = true
	if (Shortlivedconfig.map_matrix[room_coords.x][room_coords.y+1].id != -1):
		DOORS.DOWN.ts.visible = true
	
	esper = esper_scene.instance()
	fluffy = fluffy_scene.instance()
	esper.position = DOORS[from].pos.position
	fluffy.position = Utils.rand_vicinity(DOORS[from].pos.position)
	self.add_child(esper)
	self.add_child(fluffy)

func _on_UP_body_entered(body):
	if (body.name == "Esper"):
		if (Shortlivedconfig.map_matrix[room_coords.x][room_coords.y-1].id != -1):
			Gamestate.goto_room(Vector2(room_coords.x, room_coords.y-1), "DOWN")

func _on_DOWN_body_entered(body):
	if (body.name == "Esper"):
		if (Shortlivedconfig.map_matrix[room_coords.x][room_coords.y+1].id != -1):
			Gamestate.goto_room(Vector2(room_coords.x, room_coords.y+1), "UP")

func _on_LEFT_body_entered(body):
	if (body.name == "Esper"):
		if (Shortlivedconfig.map_matrix[room_coords.x-1][room_coords.y].id != -1):
			Gamestate.goto_room(Vector2(room_coords.x-1, room_coords.y), "RIGHT")

func _on_RIGHT_body_entered(body):
	if (body.name == "Esper"):
		if (Shortlivedconfig.map_matrix[room_coords.x+1][room_coords.y].id != -1):
			Gamestate.goto_room(Vector2(room_coords.x+1, room_coords.y), "LEFT")
