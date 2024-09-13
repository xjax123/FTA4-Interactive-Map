extends Node


enum Affiliation {
	Unaligned,
	HumanSphere,
	VergnitzCourts,
	FederationReborn
}

@export var AffiliationColors = {
	Affiliation.Unaligned :  Color.WHITE,
	Affiliation.HumanSphere : Color.GREEN,
	Affiliation.VergnitzCourts : Color.RED,
	Affiliation.FederationReborn : Color.TEAL
}
