extends TextureButton

signal _go

func _on_TextureButton_button_down():
	emit_signal("_go")
	pass # Replace with function body.
