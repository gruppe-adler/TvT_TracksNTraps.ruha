#include "functions\callsign\CfgFunctions.hpp"
#include "functions\bft\CfgFunctions.hpp"
#include "functions\vehicleRespawn\CfgFunctions.hpp"
#include "functions\markRivers\CfgFunctions.hpp"
#include "functions\forceRespawn\CfgFunctions.hpp"
#include "functions\map\CfgFunctions.hpp"
#include "functions\flag\CfgFunctions.hpp"
#include "functions\groupSettings\CfgFunctions.hpp"
#include "functions\bridgeDestruction\CfgFunctions.hpp"

class gradTnT {

    class advanced_towing_custom {
      file = "functions\advanced_towing_custom";
      
      class CSAinit { postInit = 1; };
    };

    class bpz {
        file = "functions\bpz";

        class bpz_actions;
        class bpz_buildTrench;
        class bpz_buildTrench_buildFX;
        class bpz_buildTrench_destroyParticle;
        class bpz_buildTrench_pfhLocal;
        class bpz_buildTrenchLocal;
        class bpz_commanderActions { postInit = 1; };
        class bpz_configureBpzEast;
        class bpz_connectRopes;
        class bpz_dropRopes;
        class bpz_getCornerPoints;
        class bpz_pickupRopes;

        class bpz_pickupRopesAction { postInit = 1; };
        class bpz_prepareRopesCrane;
        class bpz_prepareRopesHook;
        class bpz_recoveryMode;
        class bpz_removeRopesCrane;
        class bpz_ropeUnwind;

        class spw60pu12_commanderActions { postInit = 1; };
        class spw60pu12_recoveryMode;
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
        class removeExplosive;
        class triggerExplosive;
    };

    class depot {
      file = "functions\depot";

      class depotActionDeploy;
      class depotActionDestroy;
      class depotAddRespawn;
      class depotBuild;
      class depotBuildAbort;
      class depotDestroy;
      class depotGetOffset;
      class depotInit { postInit = 1; };
      class depotMouseClick;
      class depotPlace;
    };

    class fieldManual {
      file = "functions\fieldManual";

      class fieldManualAddAction;
      class init { postInit = 1; };
    };

    class loadout {
      file = "functions\loadout";

      class loadoutInit { postInit = 1; };
    };

    class mapInfo {
      file = "functions\mapInfo";

       class createBar;
       class topBar { postInit = 1; };
    };

    class missionSetup {
      file = "functions\missionSetup";

      class clearForest;
      class coverMap;
      class createBorder { postInit = 1; };
      class deleteBorder {  };
      class endMissionLocal;
      class initGlobal { postInit = 1; };
      class nerfMines { postInit = 1; };
      class waitForTimeUp { postInit = 1; };

      class showGlitchLogo;
      class startPreparationTime;
      class preparationTimeCountdown;
    };

    class points {
      file = "functions\points";

      class countPoints { postInit = 1; };
      class addRespawnEventHandler { postInit = 1; };
      class showStats;
    };

    class tanktrapdestruction {
      file = "functions\tanktrapdestruction";

      class explodeFX;
      class hitPartEH;
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

      class addCamoActions;
      class getOpposingSide;
      class pathPrefix;
      class initVehicle;
      class preventMinesAtObjective { postInit = 1; };
      class side;
      class transferRadiosAcrossRespawn { postInit = 1; };
    };
};
