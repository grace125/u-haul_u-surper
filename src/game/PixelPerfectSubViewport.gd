extends SubViewport


# Called when the node enters the scene tree for the first time.
func _ready():
	get_viewport().size_changed.connect(window_resize)

func window_resize():
	get_viewport()
