extends Node


enum Affiliation {
	Unaligned,
	Contested,
	HumanSphere,
	VergnitzCourts,
	FederationReborn,
	OpenSkyRepublic,
	OriginNations,
	CoalitionOfConstellations,
	SlumberingIsles,
	ConfedStars
}

@export var AffiliationColors = {
	Affiliation.Unaligned :  Color.WHITE,
	Affiliation.Contested : Color.MAROON,
	Affiliation.HumanSphere : Color.GREEN,
	Affiliation.VergnitzCourts : Color.RED,
	Affiliation.FederationReborn : Color.TEAL,
	Affiliation.OpenSkyRepublic : Color.AQUAMARINE,
	Affiliation.OriginNations : Color.MEDIUM_ORCHID,
	Affiliation.CoalitionOfConstellations : Color.DARK_SLATE_GRAY,
	Affiliation.SlumberingIsles : Color.DARK_SALMON,
	Affiliation.ConfedStars : Color.TOMATO
}
