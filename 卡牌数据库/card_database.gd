extends Node

#      ^代表攻击数值   ~代表buff回合
#1 虚弱 2 狂怒
var database=[
	"0@1@打击@攻击@6@0@造成^点伤害@红色@白色@@@0@0@无@images/1024Portraits/red/attack/strike.png",
"1@1@打击+@攻击@9@0@造成^点伤害@红色@白色@@@0@0@无@images/1024Portraits/red/attack/strike.png",
"2@1@防御@技能@0@5@获得^点格挡@红色@白色@@@0@0@无@images/1024Portraits/red/skill/defend.png",
"3@1@防御+@技能@0@8@获得^点格挡@红色@白色@@@0@0@无@images/1024Portraits/red/skill/defend.png",
"4@0@虚弱@技能@0@0@使敌人[color=#6fe61e]虚弱[/color]~回合@红色@白色@2@1^2@3@2@无@images/1024Portraits/red/skill/battle_trance.png",

#"0@1@打击@攻击@6@0@造成^点伤害@红色@白色@null@null@0@0@无@images/1024Portraits/red/attack/strike.png",
#"1@1@打击+@攻击@9@0@造成^点伤害@红色@白色@null@null@0@0@无@images/1024Portraits/red/attack/strike.png",
#"2@1@防御@技能@0@5@获得^点格挡@红色@白色@null@null@0@0@无@images/1024Portraits/red/skill/defend.png",
#"3@1@防御+@技能@0@8@获得^点格挡@红色@白色@null@null@0@0@无@images/1024Portraits/red/skill/defend.png",
#"4@0@虚弱@技能@0@0@使敌人虚弱~回合@红色@白色@2@1^2@3@2@无@images/1024Portraits/red/skill/battle_trance.png",
#



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



