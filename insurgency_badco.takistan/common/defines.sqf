#define DEBUG		false

//Constants
#define VIEWDISTANCE		3500
#define SPAWNRANGE 			700
#define WEP_DESPAWN_RANGE	1000

//Misc Functions
// getDirTo - vector of X towards Y in degrees while Y can be either a position or an object; 
// if X is in the East of Y, vector is from 0.01° to 179.99° and if on the West it's from -0.01° to -179.99° (N is 0°, S is 180°)
#define getDirTo(X,Y)       (((if(typeName Y == "OBJECT")then{getPosATL Y}else{Y} select 0) - (getPosATL X select 0)) atan2 ((if(typeName Y == "OBJECT")then{getPosATL Y}else{Y} select 1) - (getPosATL X select 1)))  

//Params
if (isNil "paramsArray") then {
    if (isClass (missionConfigFile/"Params")) then {
        for "_i" from 0 to (count (missionConfigFile/"Params") - 1) do {
            _paramName = configName ((missionConfigFile >> "Params") select _i);
            missionNamespace setVariable [_paramName, getNumber (missionConfigFile >> "Params" >> _paramName >> "default")];
        };
    };
} else {
    for "_i" from 0 to (count paramsArray - 1) do {
        missionNamespace setVariable [configName ((missionConfigFile >> "Params") select _i), paramsArray select _i];
    };
}; 

aiMonitorRemote = {
	_ai  = _this select 0;
	_plr = _this select 1;
	_gun = _this select 2;
	if !isNull _ai then {
		//_ai reveal _plr;
		_ai setUnitPos "UP";
		//_ai doWatch _plr;
		_ai doWatch (getpos _plr);
		_ai doMove getPosATL _plr;
	};
	if !isNull _gun then {
		_gun reveal _plr;
		_dir = ((getPosATL _plr select 0) - (getPosATL _gun select 0)) atan2 ((getPosATL _plr select 1) - (getPosATL _gun select 1)); 
		group _gun setFormDir _dir;
		_gun doTarget _plr;
		sleep 1;
		curTime = time;
		while { time - curTime < 5 } do {
			vehicle _gun fireAtTarget [_plr,currentWeapon vehicle _gun];
			sleep (0.1 + random 0.2);
		};			
	};
};

// return true when distance to spawnPos is less than 1000m unless the unit is flying (i.e. altitude higher than 50m)
is_Dead = {
	!alive _this || {getPosATL _this select 2 < 50 && {(_this distance spawnPos) < 500}}
};
#define isDead(X) (X call is_Dead)
#define startLocation       (if (isDead(MHQ)) then{HQ}else{MHQ})
#define startPos            (getPosATL fieldHospital)
#define livesLeft           (startLives - westDeaths)

//AI
#define infDeleteTime		180

//String Functions
#define squadNumber(X)      call compile toString[toArray(str X) select 7]
#define squadString(X)      ("Hitman1" + str squadNumber(X))
#define squadUnitStrings(X)	[X+"1",X+"2",X+"3",X+"4",X+"5"]
#define unitNumber(X)		call compile toString[toArray(str X) select (count toArray(str X) - 1)]
#define vehicleSquad(X)     (call compile ("Hitman1" + str unitNumber(X)))
#define getName(X)          (playerNames select (westPlayerStrings find str X))
#define squadLeader(X)      (squadString(X)+"1")

// these macros do NOT return the actual name of the unit - these are only for text references
#define squadVictor(X)      ("Victor-1-" + str squadNumber(X))
#define vehicleID(X)		("Hitman-1-" + str unitNumber(X))
#define squadID(X)          ("Hitman-1-" + str squadNumber(X))
#define unitID(X)           ("Hitman-1-" + str squadNumber(X) + "-" + str unitNumber(X))

#define victorID(X)         (\
if(typeOf X == ATVTYPE)then{"ATV-1-" + str unitNumber(X)}else{\
if(typeOf X == HELITYPE)then{"Heli"}else{\
if(typeOf X == MHQTYPE)then{"MHQ"}else{\
"Victor-1-" + str unitNumber(X)}}})

#define IEDList             ["IEDUrbanSmall_Remote_Mag","IEDUrbanBig_Remote_Mag","IEDLandSmall_Remote_Mag","IEDLandBig_Remote_Mag"]
#define cacheType 			"Box_CSAT_Equip_F"
#define ammoBoxType			"B_supplyCrate_F"
#define westVehicles 		[humv11,humv12,humv13,humv14,humv15,humv16,atv11,atv12,atv13,atv14,atv15,heli,MHQ]
#define westVehicleStrings	["humv11","humv12","humv13","humv14","humv15","humv16","atv11","atv12","atv13","atv14","atv15","heli","MHQ"]
#define westPlayerStrings	["Hitman111","Hitman112","Hitman113","Hitman114","Hitman115",\
							"Hitman121","Hitman122","Hitman123","Hitman124","Hitman125",\
							"Hitman131","Hitman132","Hitman133","Hitman134","Hitman135",\
							"Hitman141","Hitman142","Hitman143","Hitman144","Hitman145",\
							"Hitman151","Hitman152","Hitman153","Hitman154","Hitman155",\
							"Hitman161","Hitman162","Hitman163","Hitman164","Hitman165"]
#define eastPlayerStrings   ["east1","east2","east3","east4"]
#define westAllClasses		(westSoldierClasses + westVehicleClasses)
#define eastStationaryGuns	["rhs_KORD_high_MSV","rhsgref_ins_DSHKM","RHS_ZU23_MSV","RHS_AGS30_TriPod_MSV"]

#define eastVclClasses 	["LOP_TKA_Mi24V_UPK23","rhsgref_BRDM2_ins","LOP_TKA_T34","LOP_AM_OPF_Landrover_M2","LOP_AM_OPF_Offroad_AT","LOP_TKA_T55","LOP_TKA_BTR70","LOP_TKA_BTR60","LOP_AM_OPF_Landrover_SPG9","LOP_AM_OPF_Nissan_PKM","LOP_AM_OPF_Offroad_M2","LOP_AM_OPF_UAZ_AGS","LOP_AM_OPF_UAZ_DshKM","LOP_AM_OPF_UAZ_SPG","LOP_TKA_BMP1","LOP_TKA_BMP2","LOP_TKA_Mi8MTV3_UPK23","LOP_AM_OPF_Landrover","LOP_AM_OPF_Offroad","LOP_AM_OPF_UAZ","LOP_AFR_OPF_M113_W","LOP_AM_OPF_UAZ_Open","C_Van_01_transport_F","C_Quadbike_01_F","rhsgref_ins_zil131_flatbed","rhsgref_ins_zil131_flatbed_cover","rhsgref_ins_ural_work","rhsgref_ins_gaz66_repair","rhsgref_ins_gaz66_ammo","rhsgref_ins_ural_Zu23"]

#define eastRanks			["CAPTAIN","LIEUTENANT","SERGEANT","CORPORAL","PRIVATE"] 

#define eastInfClasses		[\
"LOP_AM_OPF_Infantry_Rifleman_4",\
"LOP_AM_OPF_Infantry_Rifleman",\
"LOP_AM_OPF_Infantry_AR",\
"LOP_AM_OPF_Infantry_GL",\
"LOP_AM_OPF_Infantry_Corpsman",\
"LOP_AM_OPF_Infantry_Marksman",\
"LOP_AM_OPF_Infantry_Rifleman_5",\
"LOP_AM_OPF_Infantry_AT",\
"LOP_AM_OPF_Infantry_AR_Asst",\
"LOP_AM_OPF_Infantry_Rifleman_9",\
"LOP_AM_OPF_Infantry_Rifleman_8",\
"LOP_AM_OPF_Infantry_Rifleman_7",\
"LOP_AM_OPF_Infantry_SL"\
]

#define eastAllClasses      (eastInfClasses + eastStationaryGuns + eastVclClasses)

//////class definitions						//Change vehicles, Helis to ACE
#define westVehicleClasses  	["RHS_MELB_MH6M","RHS_UH1Y_d","RHS_MELB_AH6M","RHS_UH60M_MEV_d","I_Heli_light_03_dynamicLoadout_F","B_T_VTOL_01_infantry_F","RHS_UH60M_d","rhsusf_m998_d_2dr_fulltop","rhsusf_m1025_d_m2","rhsusf_stryker_m1126_m2_d"]
#define westSoldierClasses 		["rhsusf_army_ocp_teamleader","rhsusf_army_ocp_medic","rhsusf_army_ocp_engineer","rhsusf_army_ocp_riflemanat","rhsusf_army_ocp_autorifleman","rhsusf_army_ocp_helipilot"]

//////unit definitions
#define ATVTYPE         (\
if(INS_ATVType1 == 1)then{"rhsusf_m998_d_2dr_fulltop"}else{\
if(INS_ATVType1 == 2)then{"rhsusf_m998_d_2dr_fulltop"}else{\
if(INS_ATVType1 == 3)then{"rhsusf_m998_d_2dr_fulltop"}else{\
if(INS_ATVType1 == 4)then{"rhsusf_m998_d_2dr_fulltop"}else{\
if(INS_ATVType1 == 5)then{"rhsusf_m998_d_2dr_fulltop"}else{\
if(INS_ATVType1 == 6)then{"rhsusf_m998_d_2dr_fulltop"}else{\
if(INS_ATVType1 == 7)then{"rhsusf_m998_d_2dr_fulltop"}else{\
if(INS_ATVType1 == 8)then{"rhsusf_m998_d_2dr_fulltop"}else{\
if(INS_ATVType1 == 10)then{"rhsusf_m998_d_2dr_fulltop"}else{\
"rhsusf_m998_d_2dr_fulltop"}}}}}}}}})

#define HELITYPE         (\
if(INS_AdvanceType == 1)then{"RHS_MELB_MH6M"}else{\
if(INS_AdvanceType == 2)then{"RHS_UH1Y_d"}else{\
if(INS_AdvanceType == 3)then{"RHS_MELB_AH6M"}else{\
if(INS_AdvanceType == 4)then{"RHS_UH60M_MEV_d"}else{\
if(INS_AdvanceType == 5)then{"I_Heli_light_03_dynamicLoadout_F"}else{\
if(INS_AdvanceType == 6)then{"B_T_VTOL_01_infantry_F"}else{\
"RHS_UH60M_d"}}}}}})

	#define PILOTTYPE          "rhsusf_army_ocp_helipilot"
	
	#define CAR1TYPE         (\
if(INS_CarType1 == 1)then{"rhsusf_m1025_d_m2"}else{\
if(INS_CarType1 == 2)then{"rhsusf_m1025_d_m2"}else{\
if(INS_CarType1 == 3)then{"rhsusf_m1025_d_m2"}else{\
if(INS_CarType1 == 4)then{"rhsusf_m1025_d_m2"}else{\
if(INS_CarType1 == 5)then{"rhsusf_m1025_d_m2"}else{\
if(INS_CarType1 == 6)then{"rhsusf_m1025_d_m2"}else{\
if(INS_CarType1 == 7)then{"rhsusf_m1025_d_m2"}else{\
if(INS_CarType1 == 8)then{"rhsusf_m1025_d_m2"}else{\
"rhsusf_m1025_d_m2"}}}}}}}})

	#define CAR2TYPE         (\
if(INS_CarType2 == 1)then{"rhsusf_m1025_d_m2"}else{\
if(INS_CarType2 == 2)then{"rhsusf_m1025_d_m2"}else{\
if(INS_CarType2 == 3)then{"rhsusf_m1025_d_m2"}else{\
if(INS_CarType2 == 4)then{"rhsusf_m1025_d_m2"}else{\
if(INS_CarType2 == 5)then{"rhsusf_m1025_d_m2"}else{\
if(INS_CarType2 == 6)then{"rhsusf_m1025_d_m2"}else{\
if(INS_CarType2 == 7)then{"rhsusf_m1025_d_m2"}else{\
if(INS_CarType2 == 8)then{"rhsusf_m1025_d_m2"}else{\
"rhsusf_m1025_d_m2"}}}}}}}})

#define MHQTYPE            "rhsusf_stryker_m1126_m2_d"

/*
#define humvMagazines [\
["ACE_30Rnd_556x45_SB_Stanag",12],\
["ACE_5Rnd_762x51_T_M24",4],\
["100Rnd_762x51_M240",3],\
["200Rnd_556x45_M249",3],\
["ACE_20Rnd_762x51_SB_SCAR",6],\
["ACE_Rope_TOW_M_5",1],\
["15Rnd_9x19_M9",12],\
["HandGrenade_West",10],\
["SmokeShell",4],\
["SmokeShellBlue",4],\
["SmokeShellGreen",4],\
["SmokeShellOrange",4],\
["SmokeShellPurple",4],\
["SmokeShellRed",4],\
["SmokeShellYellow",4],\
["ACE_M7A3",4],\
["ACE_ANM14",4],\
["ACE_M84",4],\
["1Rnd_HE_M203",12],\
["IR_Strobe_Target",6],\
["ACE_Bandage",10],\
["ACE_LargeBandage",10],\
["ACE_Morphine",5],\
["ACE_Epinephrine",5],\
["ACE_Medkit",6],\
["ACE_Bodybag",5]\
]
*/

#define humvMagazines [\
["rhs_mag_m18_green",2],\
["rhs_mag_an_m8hc",2],\
["rhs_mag_m18_purple",2],\
["rhs_mag_m18_red",2],\
["rhs_mag_m67",2],\
["rhs_mag_30Rnd_556x45_M855A1_Stanag_No_Tracer",6],\
["rhs_mag_m18_yellow",2]\
]

/*
#define humvItems [\
["ACE_Stretcher",1],\
["ACE_VTAC_RUSH72_ACU",2],\
["ACE_VTAC_RUSH72",2]\
]*/

#define humvItems [\
["ACE_fieldDressing",12],\
["ACE_morphine",2],\
["rhs_weap_M136_hedp",1]\
]

/*
#define heliMagazines [\
["ACE_30Rnd_556x45_SB_Stanag",4],\
["ACE_20Rnd_762x51_SB_HK417",4],\
["ACE_5Rnd_762x51_T_M24",4],\
["100Rnd_762x51_M240",1],\
["200Rnd_556x45_M249",1],\
["ACE_20Rnd_762x51_SB_SCAR",4],\
["ACE_30Rnd_9x19_S_MP5",8],\
["ACE_LargeBandage",7],\
["15Rnd_9x19_M9",8],\
["HandGrenade_West",8],\
["SmokeShell",2],\
["SmokeShellBlue",2],\
["SmokeShellGreen",2],\
["SmokeShellOrange",2],\
["SmokeShellPurple",2],\
["SmokeShellRed",2],\
["SmokeShellYellow",2],\
["ACE_ANM14",2],\
["IR_Strobe_Target",2],\
["ACE_Bandage",7],\
["ACE_Morphine",7],\
["ACE_Epinephrine",7],\
["ACE_Medkit",8],\
["ACE_Rope_M5",1],\
["ACE_Rope_M_120",1],\
["ACE_Bodybag",5]\
]
*/
#define heliMagazines [\
["rhs_mag_m18_green",2],\
["rhs_mag_an_m8hc",2],\
["rhs_mag_m18_purple",2],\
["rhs_mag_m18_red",2],\
["rhs_mag_m67",2],\
["rhs_mag_30Rnd_556x45_M855A1_Stanag_No_Tracer",6],\
["rhs_mag_m18_yellow",2]\
]

/*
#define heliItems [\
["ACE_Stretcher",1],\
["ACE_ParachutePack",10],\
["ACE_ParachuteRoundPack",10],\
["ACE_MP5A5",2],\
["ACE_VTAC_RUSH72_ACU",2],\
["ACE_VTAC_RUSH72",2]\
]
*/

#define heliItems [\
["ACE_NonSteerableParachute",10],\
["ACE_fieldDressing",12],\
["ACE_morphine",2]\
]
