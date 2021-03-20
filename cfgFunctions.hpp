class gradTnT {
    class bft {
        file = "functions\bft";

        class bftAdd;
        class bftChangeGroupId;
        class bftDrawIcons;
        class bftInit { postInit = 1; };
        class bftMarkerDead;
    };

    class bpz {
        file = "functions\bpz";

        class fn_configureBpzEast;
    };

    class bridgeBuilding {
        file = "functions\bridgeBuilding";

        class bridgeActionBuild;
        class bridgeActionDestroy;
        class bridgeBuild;
        class bridgeBuildAbort;
        class bridgeDestroy;
        class bridgeInit { postInit = 1; };
        class bridgeMarker;
        class bridgeMouseClick;
        class bridgeMouseWheel;
        class bridgePlace;
    };

    class damageHandling {
        file = "functions\damageHandling";

        class addExplosiveAction;
        class canBeRepaired;
        class damageHandling;
        class damageHandlingAddAction;
        class damageRepair;
        class removeExplosive;
        class triggerExplosive;
    };

    class depot {
      file = "functions\depot";

      class depotActionDeploy;
      class depotActionDestroy;
      class depotBuild;
      class depotBuildAbort;
      class depotDestroy;
      class depotGetOffset;
      class depotInit { postInit = 1; };
      class depotMarker;
      class depotMouseClick;
      class depotPlace;
    };

    class fieldManual {
      file = "functions\fieldManual";

      class fieldManualAddAction;
      class init { postInit = 1; };
    };

    class flagControl {
      file = "functions\flagControl";

      class flagAddAction;
      class flagAddControl;
      class flagCanRaise;
      class flagEvents { postInit = 1; };
      class flagGetTexture;
      class flagMapMarker;
      class flagMapMarkerInit { postInit = 1; };
      class flagRaise;
      class flagTake;
      class flagTakeAction;
    };

    class loadout {
      file = "functions\loadout";

      class loadoutInit { postInit = 1; };
    };

    class missionSetup {
      file = "functions\missionSetup";

      class clearForest;
      class deleteBorder { postInit = 1; };
      class markRivers { postInit = 1; };
      class nerfMines { postInit = 1; };
    };

    class points {
      file = "functions\points";

      class countPoints { postInit = 1; };
      class addRespawnEventHandler { postInit = 1; };
      class showStats;
    };

    class taxi {
      file = "functions\taxi";

      class addFlagInteraction;
      class addGetInHandler;
      class addInteraction;
      class taxiDialogClose;
      class taxiDialogOpen;
      class setTaxiWaypoint;
      class taxiOpenMap;
      class taxiCloseMap;
      class taxiStop;
      class taxiSpawn;
    };

    class misc {
      file = "functions\misc";

      class addVehicleAction;
      class configureBpzEast;
      class configureVehicleMarkings;
      class getOpposingSide;
      class initVehicle {};
    };

    class vehicleRespawn {
      file = "functions\vehicleRespawn";

      class vehicleRespawnAdd;
      class vehicleRespawnTrigger;
      class vehicleRespawnTryRespawn;
    };
};
