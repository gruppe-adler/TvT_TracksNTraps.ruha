#include "list_macros.hpp"

class sovjetGM {
    class AllUnits {
        primaryWeapon = "gm_mpiak74n_brn";
        primaryWeaponMagazine = "gm_30rnd_545x39mm_b_7n6_ak74_prp";
        primaryWeaponMuzzle = "";
        primaryWeaponPointer = "";
        primaryWeaponOptics = "";
        handgunWeapon = "";
        handgunWeaponMagazine = "";
        uniform = "gm_gc_army_uniform_soldier_80_str";
        vest = "gm_gc_army_vest_80_rifleman_str";
        backpack = "gm_gc_backpack_r105m_brn";
        headgear = "gm_gc_army_headgear_m56_net";
        binoculars = "gm_df7x40_blk";
        map = "ItemMap";
        radio = "TFAR_fadak";
        compass = "ItemCompass";
        watch = "itemWatch";
        nvgoggles = "";
        gps = "itemGPS";
        goggles = "";
    };

    class Type {
        class Soldier_F {
            uniform = "gm_gc_army_uniform_soldier_80_str";
            backpack = "gm_gc_backpack_r105m_brn";
            addItemsToUniform[] = {
                LIST_7("ACE_fieldDressing"),
                LIST_2("ACE_epinephrine"),
                LIST_3("ACE_morphine"),
                LIST_2("ACE_tourniquet"),
                "ACE_MapTools",
                "ACE_Flashlight_KSF1"
            };
            addItemsToBackpack[] = {
                "SmokeShell",
                LIST_5("gm_30rnd_545x39mm_b_7n6_ak74_prp"),
                LIST_2("gm_handgrenade_frag_rgd5"),
                LIST_2("gm_smokeshell_wht_gc")
            };
        };
        class Engineer_F: Soldier_F {
            primaryWeapon = "gm_mpikms72_brn_zvn64";
            primaryWeaponMagazine = "gm_30Rnd_762x39mm_B_M43_ak47_blk";
            uniform  = "gm_gc_army_uniform_soldier_gloves_80_str";
            vest = "gm_gc_vest_combatvest3_str";
            headgear = "gm_gc_headgear_fjh_model4_oli";
            backpack = "gm_gc_army_backpack_80_assaultpack_lmg_str";
            addItemsToVest[] = {
                LIST_5("gm_30Rnd_762x39mm_B_M43_ak47_blk"),
                LIST_2("gm_handgrenade_frag_rgd5"),
                LIST_2("gm_smokeshell_wht_gc"),
                "grad_axe",
                "ACE_EntrenchingTool",
                "ACE_DefusalKit"
            };
            addItemsToBackpack[] = {
                "ATMine_Range_Mag",
                LIST_6("ACE_fieldDressing"),
                LIST_2("ACE_epinephrine"),
                LIST_2("ACE_morphine"),
                LIST_2("ACE_rope15")
            };
        };
        class soldier_exp_F: Soldier_F {
            primaryWeapon = "gm_mpikms72_brn_zvn64";
            primaryWeaponMagazine = "gm_30Rnd_762x39mm_B_M43_ak47_blk";
            uniform  = "gm_gc_army_uniform_soldier_gloves_80_str";
            vest = "gm_gc_vest_combatvest3_str";
            headgear = "gm_gc_headgear_fjh_model4_oli";
            backpack = "gm_gc_army_backpack_80_assaultpack_lmg_str";
            goggles[] = {
                "gm_headgear_foliage_summer_grass_01",
                "gm_headgear_foliage_summer_grass_02",
                "gm_headgear_foliage_summer_grass_03",
                "gm_headgear_foliage_summer_grass_04"
            };
            addItemsToVest[] = {
                LIST_5("gm_30Rnd_762x39mm_B_M43_ak47_blk"),
                LIST_2("gm_handgrenade_frag_rgd5"),
                LIST_2("gm_smokeshell_wht_gc"),
                LIST_1("grad_axe"),
                LIST_1("ACE_EntrenchingTool"),
                LIST_1("ACE_DefusalKit")
            };
            addItemsToBackpack[] = {
                LIST_1("ATMine_Range_Mag")
            };
        };

        class HeavyGunner_F: Soldier_F {
            primaryWeapon = "gm_hmgpkm_prp";
            primaryWeaponMuzzle = "";
            primaryWeaponMagazine = "gm_100rnd_762x54mm_b_t_t46_pk_grn";
            primaryWeaponPointer = "";
            primaryWeaponOptics = "";
            vest = "gm_gc_army_vest_80_lmg_str";
            backpack = "gm_gc_army_backpack_80_assaultpack_lmg_str";
            addItemsToVest[] = {
                LIST_2("gm_handgrenade_frag_rgd5"),
                LIST_2("gm_smokeshell_wht_gc"),
                "gm_100rnd_762x54mm_b_t_t46_pk_grn"
            };
            addItemsToBackpack[] = {
                LIST_6("ACE_fieldDressing"),
                LIST_2("ACE_epinephrine"),
                LIST_2("ACE_morphine"),
                LIST_2("gm_100rnd_762x54mm_b_t_t46_pk_grn")
            };
        };
        class Soldier_AHAT_F: Soldier_F {
            addItemsToBackpack[] = {
                LIST_6("ACE_fieldDressing"),
                LIST_2("ACE_epinephrine"),
                LIST_2("ACE_morphine"),
                LIST_2("gm_1rnd_40mm_heat_pg7v_rpg7")
            };
        };
        class Soldier_AR_F: Soldier_F {
            primaryWeapon = "gm_lmgrpk74n_prp";
            primaryWeaponPointer = "";
            primaryWeaponOptics = "";
            primaryWeaponMagazine = "gm_45rnd_545x39mm_b_7n6_ak74_prp";
            primaryWeaponMuzzle = "";
            backpack = "gm_gc_army_backpack_80_lmg_str";
            addItemsToVest[] = {
                LIST_2("gm_handgrenade_frag_rgd5"),
                LIST_2("gm_smokeshell_wht_gc"),
                LIST_2("gm_handgrenade_frag_rgd5"),
                "gm_45rnd_545x39mm_b_7n6_ak74_prp"
            };
            addItemsToBackpack[] = {
                LIST_4("ACE_fieldDressing"),
                LIST_2("ACE_epinephrine"),
                LIST_2("ACE_morphine"),
                LIST_8("gm_45rnd_545x39mm_b_7n6_ak74_prp")
            };
        };

        class Soldier_AAR_F: Soldier_F {
            addItemsToVest[] = {
                LIST_2("gm_handgrenade_frag_rgd5"),
                LIST_2("gm_smokeshell_wht_gc"),
                LIST_2("gm_handgrenade_frag_rgd5"),
                "gm_100rnd_762x54mm_b_t_t46_pk_grn"
            };
        };
        //AT
        // gm_gc_army_antitank_mpiak74n_rpg7_80_str
        class Soldier_AT_F: Soldier_F {
            secondaryWeapon = "gm_rpg7_prp";
            secondaryWeaponMagazine = "gm_1rnd_40mm_heat_pg7v_rpg7";
            backpack = "gm_gc_army_backpack_80_at_str";
            vest = "gm_gc_army_vest_80_at_str";
            addItemsToBackpack[] = {
                LIST_6("ACE_fieldDressing"),
                LIST_2("ACE_epinephrine"),
                LIST_2("ACE_morphine"),
                "gm_1rnd_40mm_heat_pg7v_rpg7"
            };
        };
        class Soldier_A_F: Soldier_F {
            backpack = "gm_gc_army_backpack_80_lmg_str";
            addItemsToUniform[] = {
                "ACE_fieldDressing",
                "ACE_MapTools",
                "ACE_Flashlight_KSF1"
            };
            addItemsToBackpack[] = {
                LIST_6("ACE_fieldDressing"),
                LIST_2("ACE_epinephrine"),
                LIST_2("ACE_morphine"),
                LIST_4("gm_100rnd_762x54mm_b_t_t46_pk_grn")
            };
        };


        // no rpg26 equivalent in GM, so only 1 shot for him
        class Soldier_LAT_F: Soldier_F {
            secondaryWeapon = "gm_rpg7_prp";
            backpack = "gm_gc_army_backpack_80_at_str";
            addItemsToVest[] = {
                "SmokeShell",
                LIST_7("gm_30rnd_545x39mm_b_7n6_ak74_prp"),
                LIST_2("gm_handgrenade_frag_rgd5"),
                LIST_2("gm_smokeshell_wht_gc"),
                "gm_1rnd_40mm_heat_pg7v_rpg7"
            };
        };

        class Medic_F: Soldier_F {
            headgear = "gm_gc_army_headgear_m56_cover_str";
            backpack = "gm_gc_army_backpack_80_assaultpack_str";
            addItemsToBackpack[] = {
                LIST_10("ACE_fieldDressing"),
                LIST_10("ACE_morphine"),
                LIST_10("ACE_epinephrine"),
                LIST_8("ACE_bloodIV_250"),
                LIST_2("gm_handgrenade_frag_rgd5")
            };
        };
        class Soldier_TL_F: Soldier_F {
            headgear = "gm_gc_army_headgear_m56";
            handgunWeapon = "gm_lp1_blk";
            handgunWeaponMagazine = "gm_1Rnd_265mm_smoke_single_yel_gc";
            backpack = "gm_gc_backpack_r105m_brn";
            addItemsToUniform[] = {
                LIST_7("ACE_fieldDressing"),
                LIST_2("ACE_epinephrine"),
                LIST_2("ACE_morphine")
            };
            addItemsToVest[] = {
                LIST_2("gm_smokeshell_wht_gc"),
                LIST_2("gm_handgrenade_frag_rgd5"),
                LIST_5("gm_30rnd_545x39mm_b_7n6_ak74_prp")
            };
            addItemsToBackpack[] = {
                "ACE_Flashlight_KSF1",
                LIST_2("ACE_tourniquet"),
                "gm_smokeshell_wht_gc",
                LIST_3("gm_30rnd_545x39mm_b_7n6_ak74_prp"),
                LIST_2("gm_1Rnd_265mm_flare_single_grn_gc"),
                LIST_2("gm_1Rnd_265mm_flare_single_red_gc"),
                LIST_2("gm_1Rnd_265mm_smoke_single_yel_gc"),
                LIST_2("gm_1Rnd_265mm_smoke_single_blk_gc"),
                LIST_2("gm_1Rnd_265mm_smoke_single_blu_gc"),
                LIST_2("gm_1Rnd_265mm_flare_single_wht_gc")
            };
        };
        class Soldier_SL_F: Soldier_TL_F {
            uniform = "gm_gc_army_uniform_crew_80_oli";
            headgear = "gm_gc_headgear_beret_officer_blk";
            primaryWeapon = "gm_mpiaks74nk_brn";
            primaryWeaponMagazine = "gm_30Rnd_545x39mm_B_7N6_ak74_org";
            vest = "gm_gc_army_vest_80_rifleman_str";
            addItemsToVest[] = {
                LIST_2("gm_smokeshell_wht_gc"),
                LIST_2("gm_handgrenade_frag_rgd5"),
                LIST_3("gm_30Rnd_545x39mm_B_7N6_ak74_org")
            };
        };
        class officer_F: Soldier_SL_F {};
        class Crew_F: Soldier_F {
            uniform = "gm_gc_army_uniform_crew_80_oli";
            headgear = "gm_gc_army_headgear_crewhat_80_blk";
            primaryWeapon = "gm_mpiaks74nk_brn";
            primaryWeaponMagazine = "gm_30Rnd_545x39mm_B_7N6_ak74_org";
            vest = "gm_gc_army_vest_80_belt_str";
            addItemsToBackpack[] = {
                LIST_2("gm_smokeshell_wht_dm25"),
                LIST_4("gm_30Rnd_545x39mm_B_7N6_ak74_org")
            };
        };

        class Recon_F: Crew_F {

        };
        class Pilot_F: Crew_F {
            primaryWeapon = "";
            secondaryWeapon = "gm_pm_blk";
            secondaryWeaponMagazine = "gm_8Rnd_9x18mm_B_pst_pm_blk";
            headgear = "gm_gc_headgear_zsh3_wht";
            uniform = "gm_gc_airforce_uniform_pilot_80_blu";
            vest = "";
            backpack = "gm_gc_backpack_r105m_brn";
            addItemsToUniform[] = {
                LIST_7("ACE_fieldDressing"),
                LIST_2("ACE_epinephrine"),
                LIST_4("ACE_morphine"),
                LIST_2("ACE_tourniquet"),
                LIST_3("gm_8Rnd_9x18mm_B_pst_pm_blk"),
                "ACE_MapTools",
                "ACE_Flashlight_XL50"
            };
        };
    };
};