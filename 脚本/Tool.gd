extends Node
#生成两个数之间的整数
static func integers(_min:int,_max:int)->int:
	randomize()
	var rand=randi() % (_max-_min+1)
	return rand+_min
#根据权重生成一个随机数      target(目标)
static func Weightnumber(target:int,weight:int)->int:
	#例子,生成2的概率是1/200，target就是2，weight就是200，游戏设计权重在后期增加
	var number=integers(1,weight);
	if number==1:
		return target;
	return -1
