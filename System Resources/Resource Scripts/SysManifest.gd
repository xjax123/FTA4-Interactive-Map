extends Resource

@export_category("System UI Information")
@export_multiline var SystemDescription : String

@export_category("System Display Information")
@export var ModulateColor : Color = Color(0.15,0.15,0.15)
@export var ModulateSunColor : Color = Color(1,1,1)

@export_category("System Mechanical Information")
@export var StarType : SysView.SystemType = SysView.SystemType.Mono
@export var StarSpinSpeed : float = 0.1
@export var StarSpinDirection : SysView.OrbitDirection = SysView.OrbitDirection.Left
@export var StarSizes : Array[int] = [5,5,5]
@export var StarGap : int = 10
@export var StarColors : Array[Color] = [Color("235a85"),Color("dd9f00"),Color("e64200")]
@export var Orbitals : Array[SysOrbital] = []
@export var StaticObjects : Array[SysObject] = []
