extends Node

enum SystemType {
	Mono,
	Binary,
	Trinary,
	Empty
}

enum PlanetType {
	Rocky,
	Continental,
	GasGiant,
	HotHouse
}

enum OrbitDirection {
	Left,
	Right
}

# how long (in seconds) an earth year is (speed 1 on any option takes 1 earth year)
var globaltimemod : float = 10000
var globalyear : int = 1

signal forceShowNamesOn
signal forceShowNamesOff
