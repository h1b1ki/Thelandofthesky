extends TextureButton

signal _return

func _on_TextureButton_button_down():
	emit_signal("_return")
	pass # Replace with function body.
