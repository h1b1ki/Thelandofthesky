extends Node


var database=[
	"0@触手怪@60@怪物/神奈川.jpg@1",
	"1@触手怪@60@怪物/神奈川.jpg@1"

]
var use_data=[]
func _init():
	use_data=manage();
	
func manage():
	var A:=[]
	for x in database:
		A.append(x.split("@"))
	return A
func get_data(id):
	for x in use_data:
		if x[0].to_int()==id:
			return x[1]
	return []



