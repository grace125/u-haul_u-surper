extends Car


func _ready():
	super._ready()

func _process(delta):
	super._process(delta)

func _on_body_entered_main(body):
	if body is River:
		print("AAAAAA")
	pass
