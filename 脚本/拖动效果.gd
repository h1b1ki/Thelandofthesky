extends TextureButton

class_name drag

var draging:bool=false
var Mouse_down:bool=false
var Mouse_position_start:Vector2=Vector2()#类型=数值
var Mouse_position_before:Vector2=Vector2()
var Mouse_position:Vector2=Vector2()
var distance:Vector2

func _init() -> void:
	connect("button_down",self,"__button_down")
	connect("button_up",self,"__button_up")


func __button_down():
	Mouse_down=true
	Mouse_position_start=get_global_mouse_position()
	Mouse_position_before=Mouse_position_start
	
func __button_up():
	Mouse_down=false
	draging=false

func _process(delta):#这里的一个bug因为Mouse_down在draging=false前面导致会一直拖动
	if Mouse_down:
		Mouse_position=get_global_mouse_position()
		distance=Mouse_position-Mouse_position_before
		#距离=当前鼠标位置---前一帧鼠标位置
		Mouse_position_before=get_global_mouse_position()
		draging=true
		


