extends Node2D

onready var mask: Sprite = $Viewport/Mask

var esper_scene: Resource = load("res://src/entity/esper/esper.tscn")
var fluffy_scene: Resource = load("res://src/entity/fluffy/fluffy.tscn")

var esper: KinematicBody2D
var fluffy: KinematicBody2D

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
	Gamestate.connect("load_first_spawn", self, "_load_first_spawn")
	_load_first_spawn() # dbg

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
