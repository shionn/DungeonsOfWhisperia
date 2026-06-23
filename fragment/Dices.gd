class_name Dices
extends Object

var _random = RandomNumberGenerator.new()

func d6(count: int, threshold:int) -> int :
	var result = 0
	for i in range(0,count) :
		if _random.randi_range(1,6) >= threshold :
			result = result+1
	return result
	
