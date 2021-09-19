extends Node


var database=[
	"0@1@打击@攻击@6@造成6点伤害@红色@白色@空@0@无@images/1024Portraits/red/attack/strike.png",
"1@1@打击+@攻击@9@造成9点伤害@红色@白色@空@0@无@images/1024Portraits/red/attack/strike.png",
"2@1@防御@技能@0@获得5点格挡@红色@白色@格挡@5@无@images/1024Portraits/red/skill/defend.png",
"3@1@防御+@技能@0@获得8点格挡@红色@白色@格挡@8@无@images/1024Portraits/red/skill/defend.png",

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
func get_data(name):
	for x in use_data:
		if x[2]==name:
			return x
	return []



