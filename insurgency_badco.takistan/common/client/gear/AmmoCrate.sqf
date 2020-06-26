//................................
//	Fill Ammo Box Script by Lzryde (v0.2)
// Based on Lzryde version, improved by Kol9yN special for ACE Insurgency, further additions and modifications by K.Hunter for "Hunter'z"
//................................
// Make box is Global!
if (isServer) then {
	stuffbox = _this select 0;
	publicVariable "stuffbox";  
};

// Settings
_amountWeapon = 5;
_amountammo = 60;
_amountammoMag = 1;
_amountForSquads = 2;
_amountCSWDM = 30;
_amountCSW = 2;
_refreshTime = 600; // refresh every 10 minutes

// Loop
while {alive stuffbox} do {

	// Clear box
	clearWeaponCargo stuffbox;
	clearMagazineCargo stuffbox;

	// Fill box

	//For Heli's
	stuffbox addWeaponCargo ["ACE_ParachutePack",6];
	stuffbox addWeaponCargo ["ACE_ParachuteRoundPack",6];
	stuffbox addMagazineCargo ["ACE_VS17Panel_M",5];
	stuffbox addMagazineCargo ["ACE_Rope_M_50",5];
	stuffbox addMagazineCargo ["ACE_Rope_M_60",5];
	stuffbox addMagazineCargo ["ACE_Rope_M_90",5];
	stuffbox addMagazineCargo ["ACE_Rope_M_120",5];
	stuffbox addMagazineCargo ["ACE_Rope_M5",5];
	stuffbox addMagazineCargo ["ACE_Rope_TOW_M_5",5];

	//soflam
	stuffbox addWeaponCargo ["Laserdesignator", _amountForSquads];
	stuffbox addMagazineCargo ["Laserbatteries", 5];

	//M14
	stuffbox addWeaponCargo ["M14_EP1", _amountForSquads];
	stuffbox addWeaponCargo ["ACE_M14_ACOG", _amountForSquads];

	//M16 Family
    
	stuffbox addWeaponCargo ["ACE_M4A1_RCO_GL", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_M4A1_HWS_GL_SD_Camo_UP", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_M4A1_GL_SD", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_M4A1_Aim_SD", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_M4A1_AIM_GL", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_M4A1_AIM_GL_SD", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_M4_RCO_GL", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_M4_GL", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_M4_Eotech_GL", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_M4_Eotech", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_M4", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_M4_AIM_GL", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_M4_Aim", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_M4_ACOG", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_M16A4_Iron", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_M16A4_CCO_GL", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_M16A4_ACG_GL_UP", _amountWeapon];
    	stuffbox addWeaponCargo ["ACE_M16A4_GL_UP", _amountWeapon];
    	stuffbox addWeaponCargo ["ACE_M4A1_GL", _amountweapon];
    	stuffbox addWeaponCargo ["ACE_M4A1_GL_SD", _amountweapon];
    	stuffbox addWeaponCargo ["ACE_M4A1_ACOG", _amountweapon];
    	stuffbox addWeaponCargo ["ACE_M4A1_ACOG_SD", _amountweapon];
    	stuffbox addWeaponCargo ["ACE_M4A1_AIM_SD", _amountweapon];
    	stuffbox addWeaponCargo ["ACE_M4A1_AIM_GL", _amountweapon];
    	stuffbox addWeaponCargo ["ACE_M4A1_AIM_GL_SD", _amountweapon];
    	stuffbox addWeaponCargo ["ACE_M4A1_Eotech", _amountweapon];
    	stuffbox addWeaponCargo ["ACE_M4A1_RCO2_GL", _amountweapon];
    	stuffbox addWeaponCargo ["ACE_M4A1_RCO_GL", _amountweapon];
    	stuffbox addWeaponCargo ["ACE_SOC_M4A1_Aim", _amountweapon];
    	stuffbox addWeaponCargo ["ACE_SOC_M4A1_AIM_SD", _amountweapon];
    	stuffbox addWeaponCargo ["ACE_SOC_M4A1_Eotech", _amountweapon];
    	stuffbox addWeaponCargo ["ACE_SOC_M4A1_GL_13", _amountweapon];
    	stuffbox addWeaponCargo ["ACE_SOC_M4A1_GL_EOTECH", _amountweapon];
    	stuffbox addWeaponCargo ["ACE_SOC_M4A1_SD_9", _amountweapon];
    	stuffbox addWeaponCargo ["ACE_SOC_M4A1_SHORTDOT", _amountweapon];
    	stuffbox addWeaponCargo ["ACE_SOC_M4A1_SHORTDOT_SD", _amountweapon];
    	stuffbox addWeaponCargo ["ACE_SOC_M4A1_RCO_GL", _amountweapon];
    	stuffbox addWeaponCargo ["ACE_SOC_M4A1_GL_AIMPOINT", _amountweapon];
    	stuffbox addWeaponCargo ["ACE_SOC_M4A1", _amountweapon];
    	stuffbox addWeaponCargo ["ACE_SOC_M4A1_Eotech_4x", _amountweapon];
    	stuffbox addWeaponCargo ["ACE_SOC_M4A1_GL", _amountweapon];
    	stuffbox addWeaponCargo ["ACE_SOC_M4A1_GL_SD", _amountweapon];
    
	//HK family
	stuffbox addWeaponCargo ["ACE_HK416_D10", _amountweapon];
	stuffbox addWeaponCargo ["ACE_HK416_D10_SD", _amountweapon];
	stuffbox addWeaponCargo ["ACE_HK416_D10_AIM", _amountweapon];
	stuffbox addWeaponCargo ["ACE_HK416_D10_M320", _amountweapon];
	stuffbox addWeaponCargo ["ACE_HK416_D10_COMPM3", _amountweapon];
	stuffbox addWeaponCargo ["ACE_HK416_D10_COMPM3_SD", _amountweapon];
	stuffbox addWeaponCargo ["ACE_HK416_D10_Holo", _amountweapon];
	stuffbox addWeaponCargo ["ACE_HK416_D10_M320_UP", _amountweapon];
	stuffbox addWeaponCargo ["ACE_HK416_D14", _amountweapon];
	stuffbox addWeaponCargo ["ACE_HK416_D14_SD", _amountweapon];
	stuffbox addWeaponCargo ["ACE_HK416_D14_ACOG_PVS14", _amountweapon];
	stuffbox addWeaponCargo ["ACE_HK416_D14_COMPM3", _amountweapon];
	stuffbox addWeaponCargo ["ACE_HK416_D14_COMPM3_M320", _amountweapon];
	stuffbox addWeaponCargo ["ACE_HK417_Eotech_4x", _amountweapon];
	stuffbox addWeaponCargo ["ACE_HK417_leupold", _amountweapon];
	stuffbox addWeaponCargo ["ACE_HK417_micro", _amountweapon];
	stuffbox addWeaponCargo ["ACE_HK417_Shortdot", _amountweapon];
	
	//SCAR family
	stuffbox addWeaponCargo ["SCAR_L_CQC_EGLM_Holo", _amountWeapon];
	stuffbox addWeaponCargo ["SCAR_L_STD_EGLM_RCO", _amountWeapon];
	stuffbox addWeaponCargo ["SCAR_L_CQC", _amountWeapon];
	stuffbox addWeaponCargo ["SCAR_L_CQC_Holo", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_SCAR_H_STD_Spect", _amountWeapon];
	stuffbox addWeaponCargo ["SCAR_H_STD_EGLM_Spect", _amountWeapon];
	stuffbox addWeaponCargo ["SCAR_H_CQC_CCO", _amountWeapon];
	stuffbox addWeaponCargo ["SCAR_L_CQC_CCO_SD", _amountWeapon];
	stuffbox addWeaponCargo ["SCAR_L_STD_Mk4CQT", _amountWeapon];
	stuffbox addWeaponCargo ["SCAR_H_CQC_CCO_SD", _amountWeapon];

	//L85 family
	stuffbox addWeaponCargo ["BAF_L85A2_RIS_ACOG", _amountWeapon];
	stuffbox addWeaponCargo ["BAF_L85A2_RIS_Holo", _amountWeapon];
	stuffbox addWeaponCargo ["BAF_L85A2_RIS_SUSAT", _amountWeapon];
	stuffbox addWeaponCargo ["BAF_L85A2_UGL_ACOG", _amountWeapon];
	stuffbox addWeaponCargo ["BAF_L85A2_UGL_Holo", _amountWeapon];
	stuffbox addWeaponCargo ["BAF_L85A2_UGL_SUSAT", _amountWeapon];
	stuffbox addWeaponCargo ["BAF_L85A2_RIS_CWS", _amountWeapon];

	//G36 family
    
	stuffbox addWeaponCargo ["G36C", _amountweapon];
	stuffbox addWeaponCargo ["G36_C_SD_eotech", _amountweapon];
	stuffbox addWeaponCargo ["G36C_camo", _amountweapon];
	stuffbox addWeaponCargo ["G36_C_SD_camo", _amountweapon];
	stuffbox addWeaponCargo ["ACE_G36A1_AG36A1", _amountweapon];
	stuffbox addWeaponCargo ["ACE_G36A1_AG36A1_D", _amountweapon];
	stuffbox addWeaponCargo ["ACE_G36A2", _amountweapon];
	stuffbox addWeaponCargo ["ACE_G36A2_Bipod", _amountweapon];
	stuffbox addWeaponCargo ["ACE_G36K_EOTech", _amountweapon];
	stuffbox addWeaponCargo ["ACE_G36K_EOTech_D", _amountweapon];
	stuffbox addWeaponCargo ["ACE_G36K_iron", _amountweapon];
	stuffbox addWeaponCargo ["ACE_G36K_iron_D", _amountweapon];

	//M8 family

	stuffbox addWeaponCargo ["m8_holo_sd", _amountWeapon];
	stuffbox addWeaponCargo ["m8_carbine", _amountWeapon];
	stuffbox addWeaponCargo ["m8_carbine_pmc", _amountWeapon];
	stuffbox addWeaponCargo ["m8_carbineGL", _amountWeapon];
	stuffbox addWeaponCargo ["m8_compact", _amountWeapon];
	stuffbox addWeaponCargo ["m8_compact_pmc", _amountWeapon];

	//G3 family
	stuffbox addWeaponCargo ["ACE_G3A3_RSAS", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_G3A3", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_G3SG1", _amountWeapon]; 

	//MGs
	stuffbox addWeaponCargo ["ACE_M27_IAR", _amountForSquads];
	stuffbox addWeaponCargo ["ACE_M27_IAR_ACOG", _amountForSquads];
	stuffbox addWeaponCargo ["M240", _amountForSquads];
	stuffbox addWeaponCargo ["m249", _amountForSquads];
	stuffbox addWeaponCargo ["BAF_L7A2_GPMG", _amountForSquads];
	stuffbox addWeaponCargo ["ACE_BAF_L7A2_GPMG", _amountForSquads];
	stuffbox addWeaponCargo ["ACE_M249_PIP_ACOG", _amountForSquads];
	stuffbox addWeaponCargo ["M60A4_EP1", _amountForSquads];
	stuffbox addWeaponCargo ["Mk_48_DES_EP1", _amountForSquads];
	stuffbox addWeaponCargo ["ACE_M60", _amountForSquads];
	stuffbox addWeaponCargo ["BAF_L86A2_ACOG", _amountForSquads];
	stuffbox addWeaponCargo ["M8_SAW", _amountForSquads];
	stuffbox addWeaponCargo ["MG36_camo", _amountForSquads];
	stuffbox addWeaponCargo ["MG36", _amountForSquads];
	stuffbox addWeaponCargo ["Mk_48", _amountForSquads];
	stuffbox addWeaponCargo ["ACE_M240G_M145", _amountForSquads];
	stuffbox addWeaponCargo ["ACE_M249Para", _amountForSquads];
	stuffbox addWeaponCargo ["ACE_M249Para_M145", _amountForSquads];
	stuffbox addWeaponCargo ["BAF_L110A1_Aim", _amountForSquads];


	//Snipers and DMRs
	stuffbox addWeaponCargo ["ACE_Mk12mod1", _amountForSquads];
	stuffbox addWeaponCargo ["DMR", _amountForSquads];
	stuffbox addWeaponCargo ["ACE_M110", _amountForSquads];
	stuffbox addWeaponCargo ["ACE_M109", _amountForSquads];
	stuffbox addWeaponCargo ["M107", _amountForSquads];
	stuffbox addWeaponCargo ["M110_NVG_EP1", _amountForSquads];
	stuffbox addWeaponCargo ["M24_des_EP1", _amountForSquads];
	stuffbox addWeaponCargo ["SCAR_H_LNG_Sniper", _amountForSquads];
	stuffbox addWeaponCargo ["SCAR_H_LNG_Sniper_SD", _amountForSquads];
	stuffbox addWeaponCargo ["ACE_Mk12mod1_SD", _amountForSquads];
	stuffbox addWeaponCargo ["ACE_M4SPR_SD", _amountForSquads];
	stuffbox addWeaponCargo ["M4SPR", _amountForSquads];
	stuffbox addWeaponCargo ["M40A3", _amountForSquads];
	stuffbox addWeaponCargo ["ACE_AS50", _amountForSquads];
	stuffbox addWeaponCargo ["M8_sharpshooter", _amountForSquads];
	stuffbox addWeaponCargo ["BAF_LRR_scoped_W", _amountForSquads];
	stuffbox addWeaponCargo ["BAF_LRR_scoped", _amountForSquads];
	stuffbox addWeaponCargo ["ACE_TAC50_SD", _amountForSquads];
	stuffbox addWeaponCargo ["ACE_TAC50", _amountForSquads];
	stuffbox addWeaponCargo ["ACE_M110_SD", _amountForSquads];
	stuffbox addWeaponCargo ["BAF_AS50_scoped", _amountForSquads];



	//MISC guns
	stuffbox addWeaponCargo ["M1014", _amountWeapon];
	stuffbox addWeaponCargo ["AA12_PMC", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_M1014_Eotech", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_SPAS12", _amountWeapon];
	stuffbox addWeaponCargo ["M79_EP1", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_SKS", _amountweapon];
	stuffbox addWeaponCargo ["LeeEnfield", _amountweapon];


	//Launchers
	stuffbox addWeaponCargo ["Javelin", _amountForSquads];
	stuffbox addWeaponCargo ["Stinger", _amountForSquads];
	stuffbox addMagazineCargo ["Stinger", _amountammo];
	stuffbox addWeaponCargo ["SMAW", _amountForSquads];
	stuffbox addWeaponCargo ["MAAWS", _amountForSquads];
	stuffbox addWeaponCargo ["M32_EP1", _amountForSquads];
	stuffbox addWeaponCargo ["ACE_RPOM", _amountForSquads];
	stuffbox addWeaponCargo ["ACE_RPG29", _amountForSquads];
	stuffbox addWeaponCargo ["ACE_RPG27", _amountForSquads];
	stuffbox addWeaponCargo ["BAF_NLAW_Launcher", _amountForSquads];
	stuffbox addWeaponCargo ["ACE_RPG22", _amountForSquads];
	stuffbox addWeaponCargo ["RPG18", _amountForSquads];
	stuffbox addWeaponCargo ["ACE_RPG7V_PGO7", _amountForSquads];
	stuffbox addWeaponCargo ["ACE_RSHG1", _amountForSquads];
	stuffbox addWeaponCargo ["ACE_RMG", _amountForSquads];
	stuffbox addWeaponCargo ["MetisLauncher", _amountForSquads];
	stuffbox addMagazineCargo ["SMAW_HEAA", _amountammo];
	stuffbox addMagazineCargo ["SMAW_HEDP", _amountammo];
	stuffbox addMagazineCargo ["ACE_SMAW_NE", _amountammo];
	stuffbox addMagazineCargo ["ACE_SMAW_Spotting", _amountammo];
	stuffbox addMagazineCargo ["MAAWS_HEAT", _amountammo];
	stuffbox addMagazineCargo ["MAAWS_HEDP", _amountammo];
	stuffbox addMagazineCargo ["ACE_MAAWS_HE", _amountammo];
	stuffbox addMagazineCargo ["ACE_RPG29_PG29", _amountammo];
	stuffbox addMagazineCargo ["ACE_RPG29_TBG29", _amountammo];
	stuffbox addMagazineCargo ["AT13", _amountammo];
	stuffbox addMagazineCargo ["ACE_AT13TB", _amountammo];
	stuffbox addMagazineCargo ["ACE_OG7_PGO7", _amountammo];
	stuffbox addMagazineCargo ["ACE_PG7V_PGO7", _amountammo];
	stuffbox addMagazineCargo ["ACE_PG7VL_PGO7", _amountammo];
	stuffbox addMagazineCargo ["ACE_PG7VM_PGO7", _amountammo];
	stuffbox addMagazineCargo ["ACE_TBG7V_PGO7", _amountammo];
	stuffbox addMagazineCargo ["ACE_PG7VR_PGO7", _amountammo];
	stuffbox addWeaponCargo ["ACE_M136_CSRS", _amountForSquads];
	stuffbox addWeaponCargo ["M136", _amountForSquads];
	stuffbox addWeaponCargo ["ACE_M72A2", _amountForSquads];
	stuffbox addMagazineCargo ["ACE_6Rnd_40mm_M32", _amountammo];
	stuffbox addMagazineCargo ["ace_6rnd_cs_m32", _amountammo];
	stuffbox addMagazineCargo ["6Rnd_FlareGreen_M203", _amountammo];
	stuffbox addMagazineCargo ["6Rnd_FlareRed_M203", _amountammo];
	stuffbox addMagazineCargo ["6Rnd_FlareWhite_M203", _amountammo];
	stuffbox addMagazineCargo ["6Rnd_FlareYellow_M203", _amountammo];
	stuffbox addMagazineCargo ["6Rnd_Smoke_M203", _amountammo];
	stuffbox addMagazineCargo ["6Rnd_SmokeGreen_M203", _amountammo];
	stuffbox addMagazineCargo ["6Rnd_SmokeRed_M203", _amountammo];
	stuffbox addMagazineCargo ["6Rnd_SmokeYellow_M203", _amountammo];


	//ACRE Rucks
	
        stuffbox addWeaponCargo ["ACRE_PRC117F", _amountForSquads]; 
        stuffbox addWeaponCargo ["acre_prc148", _amountWeapon]; 
        stuffbox addWeaponCargo ["ACRE_PRC148_UHF", _amountWeapon];
        
        //EOD
      //  stuffbox addWeaponCargo ["sr5_thor3", _amountForSquads];
       // stuffbox addWeaponCargo ["sr5_thor3_mar", _amountForSquads];
      //  stuffbox addWeaponCargo ["sr5_thor3_acu", _amountForSquads];
        

	//Rucks
	stuffbox addWeaponCargo ["ACE_VTAC_RUSH72_ACU", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_VTAC_RUSH72", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_VTAC_RUSH72_OD", _amountWeapon];

	//pistols
	stuffbox addWeaponCargo ["Colt1911", _amountWeapon];
	stuffbox addWeaponCargo ["M9", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_P226", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_L9A1", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_Flaregun", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_Glock18", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_Glock17", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_MugLite", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_P8", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_USP", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_USPSD", _amountWeapon];
	stuffbox addWeaponCargo ["revolver_EP1", _amountWeapon];
	stuffbox addMagazineCargo ["ACE_13Rnd_9x19_L9A1", _amountammo];
	stuffbox addMagazineCargo ["ACE_SSGreen_FG", _amountammo];
	stuffbox addMagazineCargo ["ACE_SSRed_FG", _amountammo];
	stuffbox addMagazineCargo ["ACE_SSWhite_FG", _amountammo];
	stuffbox addMagazineCargo ["ACE_SSYellow_FG", _amountammo];
	stuffbox addMagazineCargo ["17Rnd_9x19_glock17", _amountammo];
	stuffbox addMagazineCargo ["ACE_33Rnd_9x19_G18", _amountammo];
	stuffbox addMagazineCargo ["ACE_15Rnd_9x19_P8", _amountammo];
	stuffbox addMagazineCargo ["ACE_12Rnd_45ACP_USP", _amountammo];
	stuffbox addMagazineCargo ["ACE_12Rnd_45ACP_USPSD", _amountammo];
	stuffbox addMagazineCargo ["6Rnd_45ACP", _amountammo];

	//Mini smg
	stuffbox addWeaponCargo ["M9SD", _amountWeapon];
	stuffbox addWeaponCargo ["UZI_EP1", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_KAC_PDW", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_MP5A4", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_MP5A5", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_MP5SD", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_MP7", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_MP7_RSAS", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_UMP45", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_UMP45_AIM", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_UMP45_AIM_SD", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_UMP45_SD", _amountWeapon];
	stuffbox addMagazineCargo ["20Rnd_B_765x17_Ball", _amountammo];
	stuffbox addMagazineCargo ["ACE_30Rnd_6x35_B_PDW", _amountammo];
	stuffbox addMagazineCargo ["30Rnd_9x19_MP5SD", _amountammo];
	stuffbox addMagazineCargo ["ACE_40Rnd_B_46x30_MP7", _amountammo];


	//MISC amountAmmo
	stuffbox addWeaponCargo ["ACE_Javelin_CLU", _amountForSquads];  
	stuffbox addMagazineCargo ["ACE_Bandage", _amountammo];
	stuffbox addMagazineCargo ["ACE_LargeBandage", _amountammo];
	stuffbox addMagazineCargo ["ACE_Morphine", _amountammo];
	stuffbox addMagazineCargo ["ACE_Epinephrine", _amountammo];
	stuffbox addMagazineCargo ["ACE_Medkit", _amountammo];

	stuffbox addMagazineCargo ["ACE_8Rnd_12Ga_Buck00", _amountammo];
	stuffbox addMagazineCargo ["ACE_8Rnd_12Ga_Slug", _amountammo];
	stuffbox addMagazineCargo ["ACE_Knicklicht_B", _amountammo];
	stuffbox addMagazineCargo ["ACE_Knicklicht_G", _amountammo];
	stuffbox addMagazineCargo ["ACE_Knicklicht_IR", _amountammo];
	stuffbox addMagazineCargo ["ACE_Knicklicht_R", _amountammo];
	stuffbox addMagazineCargo ["ACE_Knicklicht_W", _amountammo];
	stuffbox addMagazineCargo ["ACE_Knicklicht_Y", _amountammo];
	stuffbox addMagazineCargo ["ACE_FlareIR_M203", _amountammo];
	stuffbox addMagazineCargo ["ACE_SSYellow_M203", _amountammo];
	stuffbox addMagazineCargo ["ACE_SSGreen_M203", _amountammo];
	stuffbox addMagazineCargo ["ACE_SSRed_M203", _amountammo];
	stuffbox addMagazineCargo ["1Rnd_Smoke_M203", _amountammo];
	stuffbox addMagazineCargo ["1Rnd_SmokeRed_M203", _amountammo];
	stuffbox addMagazineCargo ["1Rnd_SmokeGreen_M203", _amountammo];
	stuffbox addMagazineCargo ["1Rnd_SmokeYellow_M203", _amountammo];
	stuffbox addMagazineCargo ["IR_Strobe_Marker", _amountammo];
	stuffbox addMagazineCargo ["IR_Strobe_Target", _amountammo];
	stuffbox addMagazineCargo ["Mine", _amountammo];
	stuffbox addMagazineCargo ["SmokeShell", _amountammo];
	stuffbox addMagazineCargo ["SmokeShellBlue", _amountammo];
	stuffbox addMagazineCargo ["SmokeShellGreen", _amountammo];
	stuffbox addMagazineCargo ["SmokeShellOrange", _amountammo];
	stuffbox addMagazineCargo ["SmokeShellPurple", _amountammo];
	stuffbox addMagazineCargo ["SmokeShellRed", _amountammo];
	stuffbox addMagazineCargo ["SmokeShellYellow", _amountammo];
	stuffbox addMagazineCargo ["ACE_M7A3", _amountammo];
	stuffbox addMagazineCargo ["ACE_M34", _amountammo];
	stuffbox addMagazineCargo ["ACE_ANM14", _amountammo];
	stuffbox addWeaponCargo ["ACE_GlassesSunglasses", _amountweapon];
	stuffbox addWeaponCargo ["ACE_GlassesBalaklava", _amountweapon];
	stuffbox addWeaponCargo ["ACE_GlassesBalaklavaGray", _amountweapon];
	stuffbox addWeaponCargo ["ACE_GlassesBalaklavaOlive", _amountweapon];
	stuffbox addWeaponCargo ["Binocular", _amountweapon];
	stuffbox addWeaponCargo ["ItemCompass", _amountweapon];
	stuffbox addWeaponCargo ["ACE_DAGR", _amountweapon];
	stuffbox addWeaponCargo ["ACE_Earplugs", _amountweapon];
	stuffbox addWeaponCargo ["ItemGPS", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_HuntIR_monitor", _amountweapon];
	stuffbox addWeaponCargo ["ACE_Kestrel4500", _amountForSquads];
	stuffbox addWeaponCargo ["ItemMap", _amountammo];
	stuffbox addWeaponCargo ["NVGoggles", _amountammo];
	stuffbox addWeaponCargo ["ItemRadio", _amountammo];
	stuffbox addWeaponCargo ["ACE_GlassesLHD_glasses", _amountammo];
	stuffbox addWeaponCargo ["ACE_SpottingScope", _amountForSquads];
	stuffbox addWeaponCargo ["ACE_Rangefinder_OD", _amountweapon];
	stuffbox addWeaponCargo ["Binocular_Vector", _amountweapon];
	stuffbox addWeaponCargo ["ItemWatch", _amountWeapon];
	stuffbox addWeaponCargo ["ACE_WireCutter", _amountForSquads];
	stuffbox addWeaponCargo ["ACE_SOFLAMTripod", _amountForSquads];
	stuffbox addWeaponCargo ["ACE_Map_Tools", _amountweapon];
	stuffbox addWeaponCargo ["ACE_KeyCuffs", _amountammo];
	stuffbox addWeaponCargo ["ACE_GlassesTactical", _amountammo];
	stuffbox addWeaponCargo ["ACE_GlassesGasMask_US", _amountammo];
	stuffbox addWeaponCargo ["ACE_YardAge450", _amountForSquads];
	stuffbox addWeaponCargo ["ACE_Minedetector_US", _amountForSquads];

	//MAGS amountAmmoMag
	stuffbox addMagazineCargo ["ACE_10Rnd_127x99_Raufoss_m107", _amountammo];
	stuffbox addMagazineCargo ["ACE_10Rnd_127x99_T_m107", _amountammo];
	stuffbox addMagazineCargo ["ACE_100Rnd_556x45_T_M249", _amountammo];
	stuffbox addMagazineCargo ["ACE_200Rnd_556x45_T_M249", _amountammo];
	stuffbox addMagazineCargo ["ACE_30Rnd_556x45_SB_Stanag", _amountammo];
	stuffbox addMagazineCargo ["ACE_30Rnd_556x45_T_Stanag", _amountammo];
	stuffbox addMagazineCargo ["20Rnd_556x45_Stanag", _amountammo];
	stuffbox addMagazineCargo ["ACE_5Rnd_127x99_B_TAC50", _amountammo];
	stuffbox addMagazineCargo ["ACE_5Rnd_127x99_T_TAC50", _amountammo];
	stuffbox addMagazineCargo ["ACE_20Rnd_762x51_SB_M110", _amountammo];
	stuffbox addMagazineCargo ["ACE_20Rnd_762x51_T_M110", _amountammo];
	stuffbox addMagazineCargo ["20Rnd_762x51_DMR", _amountammo];
	stuffbox addMagazineCargo ["ACE_5Rnd_762x51_T_M24", _amountammo];
	stuffbox addMagazineCargo ["ACE_5Rnd_25x59_HEDP_Barrett", _amountammo];
	stuffbox addMagazineCargo ["5Rnd_127x99_as50", _amountammo];
	stuffbox addMagazineCargo ["5Rnd_762x51_M24", _amountammo];
	stuffbox addMagazineCargo ["ACE_20Rnd_762x51_B_M14", _amountammo];
	stuffbox addMagazineCargo ["ACE_20Rnd_762x51_T_DMR", _amountammo];
	stuffbox addMagazineCargo ["10x_303", _amountammo];
	stuffbox addMagazineCargo ["10Rnd_127x99_m107", _amountammo];
	stuffbox addMagazineCargo ["200Rnd_556x45_L110A1", _amountammo];
	stuffbox addMagazineCargo ["5Rnd_86x70_L115A1", _amountammo];
	stuffbox addMagazineCargo ["20Rnd_762x51_FNFAL", _amountammo];
	stuffbox addMagazineCargo ["30Rnd_556x45_Stanag", _amountammo];
	stuffbox addMagazineCargo ["ACE_5Rnd_762x51_T_M24", _amountammo];
	stuffbox addMagazineCargo ["100Rnd_762x51_M240", _amountammo];
	stuffbox addMagazineCargo ["100Rnd_556x45_M249", _amountammo];
	stuffbox addMagazineCargo ["200Rnd_556x45_M249", _amountammo];
	stuffbox addMagazineCargo ["20Rnd_762x51_B_SCAR", _amountammo];
	stuffbox addMagazineCargo ["PipeBomb", _amountammo];
	stuffbox addMagazineCargo ["15Rnd_9x19_M9", _amountammo];
	stuffbox addMagazineCargo ["7Rnd_45ACP_1911", _amountammo];
	stuffbox addMagazineCargo ["ACE_15Rnd_9x19_P226", _amountammo];
	stuffbox addMagazineCargo ["HandGrenade_West", _amountammo];
	stuffbox addMagazineCargo ["FlareWhite_M203", _amountammo];
	stuffbox addMagazineCargo ["FlareYellow_M203", _amountammo];
	stuffbox addMagazineCargo ["FlareGreen_M203", _amountammo];
	stuffbox addMagazineCargo ["FlareRed_M203", _amountammo];
	stuffbox addMagazineCargo ["ACE_Battery_Rangefinder", 5];
	stuffbox addMagazineCargo ["ACE_Flashbang", _amountammo];
	stuffbox addMagazineCargo ["ACE_20Rnd_762x51_SB_SCAR", _amountammo];

	stuffbox addMagazineCargo ["ACE_10Rnd_762x39_B_SKS", _amountammo];
	stuffbox addMagazineCargo ["ACE_10Rnd_762x39_T_SKS", _amountammo];


	//m203

	stuffbox addMagazineCargo ["ACE_HuntIR_M203", _amountammo];
	stuffbox addMagazineCargo ["ACE_1Rnd_HE_M203", _amountammo];
	stuffbox addMagazineCargo ["1Rnd_HE_M203", _amountammo];
	stuffbox addMagazineCargo ["ACE_1Rnd_CS_M203", _amountammo];
	stuffbox addMagazineCargo ["ACE_1Rnd_PR_M203", _amountammo];
	stuffbox addMagazineCargo ["ACE_M576", _amountammo];

	stuffbox addMagazineCargo ["BAF_L109A1_HE", _amountammo];
	stuffbox addMagazineCargo ["ACE_M84", _amountammo];
	stuffbox addMagazineCargo ["ACE_Claymore_M", _amountammo];
	stuffbox addMagazineCargo ["ACE_C4_M", _amountammo];
	stuffbox addMagazineCargo ["ACE_OSM4_M", _amountammo];
	stuffbox addMagazineCargo ["ACE_MON50_M", _amountammo];
	stuffbox addMagazineCargo ["ACE_TRIPFLARE_M", _amountammo];
	stuffbox addMagazineCargo ["ACE_M4SLAM_M", _amountammo];
	stuffbox addMagazineCargo ["ACE_M2SLAM_M", _amountammo];
	stuffbox addMagazineCargo ["ACE_DM31_M", _amountammo];
	stuffbox addMagazineCargo ["ACE_BBETTY_M", _amountammo];

	stuffbox addMagazineCargo ["ACE_25Rnd_1143x23_B_UMP45", _amountammo];
	stuffbox addMagazineCargo ["20Rnd_B_AA12_74Slug", _amountammo];
	stuffbox addMagazineCargo ["20Rnd_B_AA12_HE", _amountammo];
	stuffbox addMagazineCargo ["20Rnd_B_AA12_Pellets", _amountammo];
	stuffbox addMagazineCargo ["ACE_20Rnd_762x51_T_HK417", _amountammo];
	stuffbox addMagazineCargo ["ACE_20Rnd_762x51_B_HK417", _amountammo];
	stuffbox addMagazineCargo ["ACE_20Rnd_762x51_SB_HK417", _amountammo];
	stuffbox addMagazineCargo ["ACE_20Rnd_762x51_T_G3", _amountammo];
	stuffbox addMagazineCargo ["ACE_20Rnd_762x51_B_G3", _amountammo];
	stuffbox addMagazineCargo ["30Rnd_556x45_G36", _amountammo];

	//CSW

	stuffbox addWeaponCargo ["ACE_M220TripodProxy",_amountCSW];
	stuffbox addWeaponCargo ["ACE_M220Proxy",_amountCSW];
	stuffbox addWeaponCargo ["ACE_M224TripodProxy",_amountCSW];
	stuffbox addWeaponCargo ["ACE_M224Proxy",_amountCSW];
	stuffbox addWeaponCargo ["ACE_M252TripodProxy",_amountCSW];
	stuffbox addWeaponCargo ["ACE_M252Proxy",_amountCSW];
	stuffbox addWeaponCargo ["ACE_M3TripodProxy",_amountCSW];
	stuffbox addWeaponCargo ["ACE_M2HBProxy",_amountCSW];
	stuffbox addWeaponCargo ["ACE_MK19MOD3Proxy",_amountCSW];
	stuffbox addWeaponCargo ["ACE_BAF_L2A1Proxy",_amountCSW];
	stuffbox addWeaponCargo ["ACE_BAF_static_GMGProxy",_amountCSW];
	stuffbox addWeaponCargo ["ACE_M122TripodProxy",_amountCSW];
	stuffbox addMagazineCargo ["ACE_TOW_CSWDM",_amountCSWDM];
	stuffbox addMagazineCargo ["ACE_M224HE_CSWDM",_amountCSWDM];
	stuffbox addMagazineCargo ["ACE_M224WP_CSWDM",_amountCSWDM];
	stuffbox addMagazineCargo ["ACE_M224IL_CSWDM",_amountCSWDM];
	stuffbox addMagazineCargo ["ACE_M252HE_CSWDM",_amountCSWDM];
	stuffbox addMagazineCargo ["ACE_M252WP_CSWDM",_amountCSWDM];
	stuffbox addMagazineCargo ["ACE_M252IL_CSWDM",_amountCSWDM];
	stuffbox addMagazineCargo ["ACE_M2_CSWDM",_amountCSWDM];
	stuffbox addMagazineCargo ["ACE_MK19_CSWDM",_amountCSWDM];
	stuffbox addMagazineCargo ["ACE_GMG_CSWDM",_amountCSWDM];

// Wait the duration of _refreshTime
	sleep _refreshTime;
};