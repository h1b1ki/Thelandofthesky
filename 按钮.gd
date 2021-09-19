extends Container

signal ok

export var Unlocking:bool=true
var into:bool

func _on__mouse_entered():
	if Unlocking:
		self.rect_scale=Vector2(1.2,1.2)
	into=true
	pass # Replace with function body.


func _on__mouse_exited():
	if Unlocking:
		self.rect_scale=Vector2(1,1)
	into=false
	pass # Replace with function body.
func _physics_process(delta: float) -> void:
	if into and Unlocking and Input.is_action_just_pressed("左键按下"):
		#print("ok")
		emit_signal("ok")
	
