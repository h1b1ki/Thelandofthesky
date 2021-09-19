extends Node

#自己攻击倍率
var Attack_rate=1.0
#敌人攻击倍率
var enemy_Attack_rate=1.0
#直接增加的攻击数值
var ATK:int

func dobuff(id,who:bool):
	if who:
		if id==1:
			Attack_rate*=0.5
		elif id==2:
			Attack_rate*=1.5
	#敌人		
	else:
		if id==1:
			enemy_Attack_rate*=0.5		
		elif id==2:
			enemy_Attack_rate*=1.5


func delbuff(id,who:bool):
	if who:
		if id==1:
			Attack_rate/=0.5
		elif id==2:
			Attack_rate/=1.5
	else:
		if id==1:
			enemy_Attack_rate/=0.5
		elif id==2:
			enemy_Attack_rate/=1.5

func clear():
	Attack_rate=1.0
	enemy_Attack_rate=1.0
	ATK=0
