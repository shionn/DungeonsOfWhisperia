class_name MonsterStatistic
extends Node

enum MonsterClass {
	SkeletonMinion, 
	SkeletonRogue, 
	SkeletonMage, 
	SkeletonWarrior, 
	SkeletonGolem }

var atk: int
var def: int
var pv: int

# Je ne sais pas pou je vais avec ca.

func _init(clazz : MonsterClass, lvl:int = 1):
	match (clazz) : 
		MonsterClass.SkeletonMinion :
			atk = lvl
			def = lvl
			pv  = lvl+1
		MonsterClass.SkeletonRogue :
			atk = lvl
			def = lvl+1
			pv  = lvl+1
		MonsterClass.SkeletonMage :
			atk = 1
			def = lvl
			pv  = lvl+1
		MonsterClass.SkeletonWarrior :
			atk = lvl+1
			def = lvl+1
			pv  = lvl+2
		MonsterClass.SkeletonGolem :
			atk = lvl+2
			def = lvl+2
			pv  = lvl+3
			
	pass
