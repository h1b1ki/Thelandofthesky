extends Control

signal star
signal daily
signal custom
signal goback

func _on_1_ok():
	emit_signal("star")
	pass # Replace with function body.

func _on_2_ok():
	emit_signal("daily")
	
	pass # Replace with function body.


func _on_3_ok():
	emit_signal("custom")
	
	pass # Replace with function body.


func _on_TextureButton_button_down():
	emit_signal("goback")
	hide()
	pass # Replace with function body.
