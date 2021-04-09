#include "list_macros.hpp"

class bwGM {
    class AllUnits {
        primaryWeapon = "gm_g3a3_oli";
        primaryWeaponMagazine = "gm_20rnd_762x51mm_b_t_dm21a1_g3_blk";
        primaryWeaponPointer = "";
        primaryWeaponOptics = "";
        handgunWeapon = "";
        handgunWeaponMagazine = "";
        uniform = "gm_ge_army_uniform_soldier_80_oli";
        vest = "gm_ge_army_vest_80_crew";
        backpack = "gm_ge_backpack_sem35_oli";
        headgear = "gm_ge_headgear_m62_net";
        binoculars = "gm_ferod16_oli";
        map = "ItemMap";
        radio = "TFAR_anprc152";
        compass = "ItemCompass";
        watch = "gm_watch_kosei_80";
        nvgoggles = "";
        goggles = "";
        gps = "itemGPS";
    };

    class Type {
        class Soldier_F {
            headgear = "gm_ge_headgear_crewhat_80_blk";
            uniform = "gm_ge_army_uniform_crew_80_oli";
            backpack = "gm_ge_backpack_sem35_oli";
            addItemsToUniform[] = {
                LIST_7("ACE_fieldDressing"),
                LIST_2("ACE_epinephrine"),
                LIST_3("ACE_morphine"),
                LIST_2("ACE_tourniquet"),
                "ACE_MapTools",
                "ACE_Flashlight_XL50",
                "ACE_key_west"
            };
            addItemsToBackpack[] = {
                LIST_5("gm_20Rnd_762x51mm_B_DM41_g3_blk"),
                LIST_2("gm_handgrenade_frag_dm51"),
                LIST_2("gm_smokeshell_wht_dm25")
            };
        };
        class Engineer_F: Soldier_F {
            uniform = "gm_ge_army_uniform_soldier_80_ols";
            headgear = "gm_ge_headgear_m62_net";
            vest = "gm_ge_army_vest_80_leader";
            backpack = "gm_ge_army_backpack_80_engineer_oli";
            addItemsToVest[] = {
                LIST_2("gm_smokeshell_wht_dm25"),
                LIST_5("gm_20rnd_762x51mm_b_t_dm21a1_g3_blk"),
                LIST_1("grad_axe"),
                LIST_1("ACE_EntrenchingTool"),
                LIST_1("ACE_DefusalKit")
            };
            addItemsToBackpack[] = {
                LIST_1("gm_mine_at_dm21"),
                LIST_6("ACE_fieldDressing"),
                LIST_2("ACE_epinephrine"),
                LIST_2("ACE_morphine")
            };
        };
        class Soldier_exp_F: Soldier_F {
            uniform = "gm_ge_army_uniform_soldier_80_ols";
            headgear = "gm_ge_headgear_m62_net";
            vest = "gm_ge_army_vest_80_leader";
            backpack = "gm_ge_army_backpack_80_engineer_oli";
            goggles[] = {
                "gm_headgear_foliage_summer_grass_01",
                "gm_headgear_foliage_summer_grass_02",
                "gm_headgear_foliage_summer_grass_03",
                "gm_headgear_foliage_summer_grass_04"
            };
            addItemsToVest[] = {
                LIST_2("gm_smokeshell_wht_dm25"),
                LIST_5("gm_20rnd_762x51mm_b_t_dm21a1_g3_blk"),
                LIST_1("grad_axe"),
                LIST_1("ACE_EntrenchingTool"),
                LIST_1("ACE_DefusalKit")
            };
            addItemsToBackpack[] = {
                LIST_1("gm_mine_at_dm21"),
                LIST_1("toolkit"),
                LIST_6("ACE_fieldDressing"),
                LIST_2("ACE_epinephrine"),
                LIST_2("ACE_morphine")
            };
        };
        class HeavyGunner_F: Soldier_F {
            primaryWeapon = "gm_mg3_blk";
            primaryWeaponMagazine = "gm_120rnd_762x51mm_b_t_dm21a1_mg3_grn";
            vest = "gm_ge_army_vest_80_machinegunner";
            addItemsToUniform[] = {
                LIST_5("ACE_fieldDressing"),
                LIST_2("ACE_epinephrine"),
                LIST_3("ACE_morphine"),
                LIST_2("ACE_tourniquet"),
                "ACE_MapTools",
                "ACE_Flashlight_XL50"
            };
            addItemsToVest[] = {
                "gm_handgrenade_frag_dm51",
                "gm_smokeshell_wht_dm25",
                LIST_2("gm_120rnd_762x51mm_b_t_dm21a1_mg3_grn")
            };
            addItemsToBackpack[] = {
                LIST_2("gm_120rnd_762x51mm_b_t_dm21a1_mg3_grn")
            };
        };
        class Soldier_AR_F: Soldier_F {
            primaryWeapon = "gm_mg3_blk";
            primaryWeaponMagazine = "gm_120rnd_762x51mm_b_t_dm21a1_mg3_grn";
            vest = "gm_ge_army_vest_80_machinegunner";
            addItemsToUniform[] = {
                LIST_5("ACE_fieldDressing"),
                LIST_2("ACE_epinephrine"),
                LIST_3("ACE_morphine"),
                LIST_2("ACE_tourniquet"),
                "ACE_MapTools",
                "ACE_Flashlight_XL50"
            };
            addItemsToVest[] = {
                "gm_handgrenade_frag_dm51",
                LIST_2("gm_smokeshell_wht_dm25"),
                LIST_2("gm_120rnd_762x51mm_b_t_dm21a1_mg3_grn")
            };
            addItemsToBackpack[] = {
                LIST_2("gm_120rnd_762x51mm_b_t_dm21a1_mg3_grn")
            };
        };
        class Soldier_AAR_F: Soldier_F {
            addItemsToUniform[] = {
                LIST_5("ACE_fieldDressing"),
                LIST_2("ACE_epinephrine"),
                LIST_3("ACE_morphine"),
                LIST_2("ACE_tourniquet"),
                "ACE_MapTools",
                "ACE_Flashlight_XL50"
            };
            addItemsToBackpack[] = {
                LIST_2("gm_120rnd_762x51mm_b_t_dm21a1_mg3_grn")
            };
        };

        class Soldier_A_F: Soldier_F {
            addItemsToVest[] = {
                LIST_8("gm_20rnd_762x51mm_b_t_dm21a1_g3_blk"),
                LIST_2("gm_handgrenade_frag_dm51"),
                LIST_2("gm_smokeshell_wht_dm25")
            };
            addItemsToBackpack[] = {
                LIST_2("gm_120rnd_762x51mm_b_t_dm21a1_mg3_grn")
            };
        };

        // heavy at
        class Soldier_AT_F: Soldier_F {
            vest = "gm_ge_army_vest_80_demolition";
            secondaryWeapon = "gm_pzf84_oli";
            secondaryWeaponMagazine = "gm_1rnd_84x245mm_heat_t_dm12a1_carlgustaf";
            backpack = "B_Carryall_cbr";
            addItemsToUniform[] = {
                LIST_5("ACE_fieldDressing"),
                LIST_2("ACE_epinephrine"),
                LIST_3("ACE_morphine"),
                LIST_2("ACE_tourniquet"),
                "ACE_MapTools",
                "ACE_Flashlight_XL50"
            };
            addItemsToVest[] = {
                LIST_3("gm_20rnd_762x51mm_b_t_dm21a1_g3_blk"),
                "gm_smokeshell_wht_dm25"
            };
            addItemsToBackpack[] = {
                "gm_1rnd_84x245mm_heat_t_dm12a1_carlgustaf"
            };
        };

        // heavy at ammo carrier
        class Soldier_AAT_F: Soldier_F {
            addItemsToBackpack[] = {
                LIST_6("ACE_fieldDressing"),
                LIST_2("ACE_epinephrine"),
                LIST_2("ACE_morphine"),
                LIST_2("gm_1rnd_84x245mm_heat_t_dm12a1_carlgustaf")
            };
        };

        class Soldier_LAT_F: Soldier_F {
            vest = "gm_ge_army_vest_80_demolition";
            secondaryWeapon = "gm_pzf44_2_oli";
            secondaryWeaponMagazine = "gm_1rnd_44x537mm_heat_dm32_pzf44_2";
            addItemsToUniform[] = {
                LIST_5("ACE_fieldDressing"),
                LIST_2("ACE_epinephrine"),
                LIST_3("ACE_morphine"),
                LIST_2("ACE_tourniquet"),
                "ACE_MapTools",
                "ACE_Flashlight_XL50",
                "gm_1rnd_84x245mm_heat_t_dm12a1_carlgustaf"
            };
        };

        class Medic_F: Soldier_F {
            headgear = "gm_ge_headgear_m62";
            vest = "gm_ge_army_vest_80_medic";
            backpack = "gm_ge_backpack_satchel_80_san";
            addItemsToBackpack[] = {
                LIST_10("ACE_fieldDressing"),
                LIST_10("ACE_morphine"),
                LIST_10("ACE_epinephrine"),
                LIST_8("ACE_bloodIV_250"),
                LIST_2("gm_handgrenade_frag_dm51")
            };
        };
        class Soldier_TL_F: Soldier_F {
            headgear = "gm_ge_headgear_m62";
            vest = "gm_ge_army_vest_80_leader";
            handgunWeapon = "gm_p2a1_blk";
            handgunWeaponMagazine = "gm_1Rnd_265mm_smoke_single_yel_DM19";
            addItemsToUniform[] = {
                LIST_7("ACE_fieldDressing"),
                LIST_2("ACE_epinephrine"),
                LIST_4("ACE_morphine"),
                LIST_2("ACE_tourniquet"),
                "ACE_MapTools",
                "ACE_Flashlight_XL50",
                "ACE_key_west"
            };
            addItemsToVest[] = {
                LIST_2("gm_handgrenade_frag_dm51"),
                LIST_2("gm_smokeshell_wht_dm25"),
                LIST_3("gm_20rnd_762x51mm_b_t_dm21a1_g3_blk")
            };
            addItemsToBackpack[] = {
                LIST_5("gm_20rnd_762x51mm_b_t_dm21a1_g3_blk"),
                LIST_2("gm_1Rnd_265mm_flare_single_grn_DM11"),
                LIST_2("gm_1Rnd_265mm_flare_single_red_DM13"),
                LIST_2("gm_1Rnd_265mm_smoke_single_yel_DM19"),
                LIST_2("gm_1Rnd_265mm_smoke_single_org_DM22"),
                LIST_2("gm_1Rnd_265mm_smoke_single_vlt_DM24"),
                LIST_2("gm_1Rnd_265mm_flare_single_wht_DM15")
            };
        };
        class Soldier_SL_F: Soldier_TL_F {
            headgear = "gm_ge_headgear_beret_crew_red_opcom";
            backpack = "TFAR_rt1523g_green";
            goggles = "";
            addItemsToUniform[] = {
                LIST_7("ACE_fieldDressing"),
                LIST_2("ACE_epinephrine"),
                LIST_4("ACE_morphine"),
                LIST_2("ACE_tourniquet"),
                "ACE_MapTools",
                "ACE_Flashlight_XL50",
                "ACE_key_west"
            };
        };
        class officer_F: Soldier_SL_F {};
        class Crew_F: Soldier_F {
            uniform = "gm_ge_army_uniform_crew_80_oli";
            headgear = "gm_ge_headgear_crewhat_80_blk";
            primaryWeapon = "gm_mp2a1_blk";
            primaryWeaponMagazine = "gm_32Rnd_9x19mm_B_DM11_mp2_blk";
            vest = "gm_ge_army_vest_80_crew";
            addItemsToBackpack[] = {
                LIST_6("gm_32Rnd_9x19mm_B_DM11_mp2_blk"),
                LIST_2("gm_handgrenade_frag_dm51"),
                LIST_2("gm_smokeshell_wht_dm25")
            };
        };
        class Recon_F: Crew_F {

        };
        class Pilot_F: Crew_F {
            primaryWeapon = "";
            secondaryWeapon = "gm_p1_blk";
            secondaryWeaponMagazine = "gm_8Rnd_9x19mm_B_DM11_p1_blk";
            headgear = "gm_ge_headgear_sph4_oli";
            uniform = "gm_ge_army_vest_pilot_oli";
            vest = "";
            backpack = "gm_gc_backpack_r105m_brn";
            addItemsToUniform[] = {
                LIST_7("ACE_fieldDressing"),
                LIST_2("ACE_epinephrine"),
                LIST_4("ACE_morphine"),
                LIST_2("ACE_tourniquet"),
                LIST_3("gm_8Rnd_9x19mm_B_DM11_p1_blk"),
                "ACE_MapTools",
                "ACE_Flashlight_XL50",
                "ACE_key_west"
            };
        };
    };
};