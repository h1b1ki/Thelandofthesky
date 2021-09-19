extends Node


var database=[
	"1@虚弱@攻击下降50%@buff/accursed.png",
"2@狂怒@攻击上升50%@buff/scatter.png",


]
var use_data=[]
func _init():
	use_data=manage();
	pass
func manage():
	var A:=[]
	for x in database:
		A.append(x.split("@"))
	return A
func get_data(id):
	for x in use_data:
		if x[0].to_int()==id:
			return x
	return []



