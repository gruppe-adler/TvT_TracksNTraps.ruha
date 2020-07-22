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

    class depot {
      file = "functions\depot";

      class deleteBorder { postInit = 1; };
      class depotAction;
      class depotDestroy;
      class depotDrop;
      class depotMarker;
    };

    class missionSetup {
      file = "functions\missionSetup";

      class clearForest;
      class coverMap;
      class markRivers { postInit = 1; };
      class nerfMines { postInit = 1; };
    };
};
