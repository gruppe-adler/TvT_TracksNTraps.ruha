class gradSB {
    class bridgeBuilding {
        file = "functions\bridgeBuilding";

        class bridgeActionBuild;
        class bridgeActionDestroy;
        class bridgeBuild;
        class bridgeDestroy;
        class bridgeMarker;
        class bridgeMouseClick;
        class bridgeMouseWheel;
        class bridgePlace;
    };

    class damageHandling {
        file = "functions\damageHandling";

        class canBeRepaired;
        class damageHandling;
        class damageHandlingAddAction;
        class damageRepair;
    };

    class depot {
      file = "functions\depot";
   
      class depotActionDeploy;
      class depotActionDestroy;
      class depotDrop;
      class depotInit;
      class depotMarker;
      class depotPlace;
    };

    class flagControl {
      file = "functions\flagControl";
   
      class flagAddAction;
      class flagAddControl;
      class flagCanRaise;
      class flagGetTexture;
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
      class coverMap;
      class deleteBorder { postInit = 1; };
      class markRivers { postInit = 1; };
      class nerfMines { postInit = 1; };
    };

    class points {
      file = "functions\points";

      class countPoints;
    };

    class vehicleRespawn {
      file = "functions\vehicleRespawn";

      class vehicleRespawnAdd;
      class vehicleRespawnCheck;
      class vehicleRespawnConfig;
      class vehicleRespawnSpawn;
    };
};
