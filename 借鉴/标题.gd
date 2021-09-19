extends Control

func _on_TextureButton_button_down():
	$"开始游戏界面".show()
	pass # Replace with function body.


func _on__star():
	$"开始游戏界面".hide()
	$"英雄".show()
	pass # Replace with function body.
 
