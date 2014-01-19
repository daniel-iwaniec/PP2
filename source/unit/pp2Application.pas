unit pp2Application;

{$mode objfpc}{$H+}

interface
         uses classes, sysUtils, crt, graph;

         type
             ApplicationConfigurationPointer = ^ApplicationConfiguration;
             ApplicationConfiguration = object
             private
                   boardPadding : integer;
                   boardBorderWidth : integer;

                   graphMaxX, graphMaxY : integer;

                   defaultPlayerSize, defaultPlayerSpeed : integer;

                   defaultEnemySize, defaultEnemySpeed: integer;
                   defaultEnemyMoveInterval : integer;

                   pointsForEnemy, pointsToWin : integer;
                   initialEnemyCount : integer;

                   enemyHatchInterval, enemyPopulationLimit : integer;

                   function setBoardPadding(newBoardPadding : integer) : boolean;
                   function setBoardBorderWidth(newBoardBorderWidth : integer) : boolean;

                   function setGraphMaxX(newGraphMaxX: integer) : boolean;
                   function setGraphMaxY(newGraphMaxY: integer) : boolean;

                   function setDefaultPlayerSize(newDefaultPlayerSize: integer) : boolean;
                   function setDefaultPlayerSpeed(newDefaultPlayerSpeed: integer) : boolean;

                   function setDefaultEnemySize(newDefaultEnemySize: integer) : boolean;
                   function setDefaultEnemySpeed(newDefaultEnemySpeed: integer) : boolean;
                   function setDefaultEnemyMoveInterval(newDefaultEnemyMoveInterval: integer) : boolean;

                   function setPointsForEnemy(newPointsForEnemy: integer) : boolean;
                   function setPointsToWin(newPointsToWin: integer) : boolean;
                   function setInitialEnemyCount(newInitialEnemyCount: integer) : boolean;

                   function setEnemyHatchInterval(newEnemyHatchInterval: integer) : boolean;
                   function setEnemyPopulationLimit(newEnemyPopulationLimit: integer) : boolean;
             public
                   function getBoardPadding() : integer;
                   function getBoardBorderWidth() : integer;

                   function getGraphMaxX() : integer;
                   function getGraphMaxY() : integer;

                   function getDefaultPlayerSize() : integer;
                   function getDefaultPlayerSpeed() : integer;

                   function getDefaultEnemySize() : integer;
                   function getDefaultEnemySpeed() : integer;
                   function getDefaultEnemyMoveInterval() : integer;

                   function getPointsForEnemy() : integer;
                   function getPointsToWin() : integer;

                   function getInitialEnemyCount() : integer;

                   function getEnemyHatchInterval() : integer;
                   function getEnemyPopulationLimit() : integer;

                   constructor initialize();
             end;

             ApplicationPointer = ^Application;
             Application = object
             private
                   card : smallint;
                   mode : smallint;
                   lastPressedKey : char;

                   function setLastPressedKey(newLastPressedKey : char) : boolean;
                   function setCard(newCard : smallint) : boolean;
                   function setMode(newMode : smallint) : boolean;
             public
                   function getCard() : smallint;
                   function getMode() : smallint;

                   function isKeyPressed() : boolean;
                   function getLastPressedKey() : char;

                   function isUpKeyPressed() : boolean;
                   function isDownKeyPressed() : boolean;
                   function isRightKeyPressed() : boolean;
                   function isLeftKeyPressed() : boolean;
                   function isCloseKeyPressed() : boolean;

                   constructor initialize(ApplicationConfiguration : ApplicationConfigurationPointer);
                   destructor close();
             end;

implementation
              function Application.setCard(newCard : smallint) : boolean; begin
              try
                 card := newCard;
                 setCard := true;
              except setCard := false; end;
              end;
              function Application.getCard() : smallint; begin
               try
                  getCard := card;
               except getCard := 0; end;
              end;

              function Application.setMode(newMode : smallint) : boolean; begin
              try
                 mode := newMode;
                 setMode := true;
              except setMode := false; end;
              end;
              function Application.getMode() : smallint; begin
               try
                  getMode := mode;
               except getMode := 0; end;
              end;

              function Application.setLastPressedKey(newLastPressedKey : char) : boolean; begin
              try
                 lastPressedKey := newLastPressedKey;
                 setLastPressedKey := true;
              except setLastPressedKey := false; end;
              end;
              function Application.getLastPressedKey() : char; begin
               try
                  getLastPressedKey := lastPressedKey;
               except getLastPressedKey := #0; end;
              end;

              function Application.isKeyPressed() : boolean; begin
               if (keyPressed) then begin
                  Application.setLastPressedKey(readKey);
                  isKeyPressed := true;
               end else begin
                  isKeyPressed := false;
               end;
              end;

              function Application.isUpKeyPressed() : boolean; begin
               try
                  if (Application.getLastPressedKey() = #72) then begin
                     isUpKeyPressed := true;
                  end else begin
                     isUpKeyPressed := false;
                  end;
               except isUpKeyPressed := false; end;
              end;
              function Application.isDownKeyPressed() : boolean; begin
               try
                  if (Application.getLastPressedKey() = #80) then begin
                     isDownKeyPressed := true;
                  end else begin
                     isDownKeyPressed := false;
                  end;
               except isDownKeyPressed := false; end;
              end;
              function Application.isRightKeyPressed() : boolean; begin
               try
                  if (Application.getLastPressedKey() = #77) then begin
                     isRightKeyPressed := true;
                  end else begin
                     isRightKeyPressed := false;
                  end;
               except isRightKeyPressed := false; end;
              end;
              function Application.isLeftKeyPressed() : boolean; begin
               try
                  if (Application.getLastPressedKey() = #75) then begin
                     isLeftKeyPressed := true;
                  end else begin
                     isLeftKeyPressed := false;
                  end;
               except isLeftKeyPressed := false; end;
              end;
              function Application.isCloseKeyPressed() : boolean; begin
               try
                  if (Application.getLastPressedKey() = #27) then begin
                     isCloseKeyPressed := true;
                  end else begin
                     isCloseKeyPressed := false;
                  end;
               except isCloseKeyPressed := false; end;
              end;

              constructor Application.initialize(ApplicationConfiguration : ApplicationConfigurationPointer);
               var cardLocal, modeLocal : smallint;
               begin
                randomize;

                Application.setCard(0);
                Application.setMode(0);

                cardLocal := Application.getCard();
                modeLocal := Application.getMode();

                initGraph(cardLocal, modeLocal, '');
                ApplicationConfiguration^.setGraphMaxX(GetMaxX());
                ApplicationConfiguration^.setGraphMaxY(GetMaxY());
              end;

              destructor Application.close(); begin
                closeGraph;
              end;

              function ApplicationConfiguration.setBoardPadding(newBoardPadding : integer) : boolean; begin
              try
                 boardPadding := newBoardPadding;
                 setBoardPadding := true;
              except setBoardPadding := false; end;
              end;
              function ApplicationConfiguration.getBoardPadding() : integer; begin
               try
                  getBoardPadding := boardPadding;
               except getBoardPadding := 0; end;
              end;
              function ApplicationConfiguration.setBoardBorderWidth(newBoardBorderWidth : integer) : boolean; begin
              try
                 boardBorderWidth := newBoardBorderWidth;
                 setBoardBorderWidth := true;
              except setBoardBorderWidth := false; end;
              end;
              function ApplicationConfiguration.getBoardBorderWidth() : integer; begin
               try
                  getBoardBorderWidth := boardBorderWidth;
               except getBoardBorderWidth := 0; end;
              end;

              function ApplicationConfiguration.setGraphMaxX(newGraphMaxX : integer) : boolean; begin
              try
                 graphMaxX := newGraphMaxX;
                 setGraphMaxX := true;
              except setGraphMaxX := false; end;
              end;
              function ApplicationConfiguration.getGraphMaxX() : integer; begin
               try
                  getGraphMaxX := graphMaxX;
               except getGraphMaxX := 0; end;
              end;
              function ApplicationConfiguration.setGraphMaxY(newGraphMaxY : integer) : boolean; begin
              try
                 graphMaxY := newGraphMaxY;
                 setGraphMaxY := true;
              except setGraphMaxY := false; end;
              end;
              function ApplicationConfiguration.getGraphMaxY() : integer; begin
               try
                  getGraphMaxY := graphMaxY;
               except getGraphMaxY := 0; end;
              end;

              function ApplicationConfiguration.setDefaultPlayerSize(newDefaultPlayerSize : integer) : boolean; begin
              try
                 defaultPlayerSize := newDefaultPlayerSize;
                 setDefaultPlayerSize := true;
              except setDefaultPlayerSize := false; end;
              end;
              function ApplicationConfiguration.getDefaultPlayerSize() : integer; begin
               try
                  getDefaultPlayerSize := defaultPlayerSize;
               except getDefaultPlayerSize := 0; end;
              end;
              function ApplicationConfiguration.setDefaultPlayerSpeed(newDefaultPlayerSpeed : integer) : boolean; begin
              try
                 defaultPlayerSpeed := newDefaultPlayerSpeed;
                 setDefaultPlayerSpeed := true;
              except setDefaultPlayerSpeed := false; end;
              end;
              function ApplicationConfiguration.getDefaultPlayerSpeed() : integer; begin
               try
                  getDefaultPlayerSpeed := defaultPlayerSpeed;
               except getDefaultPlayerSpeed := 0; end;
              end;

              function ApplicationConfiguration.setDefaultEnemySize(newDefaultEnemySize : integer) : boolean; begin
              try
                 defaultEnemySize := newDefaultEnemySize;
                 setDefaultEnemySize := true;
              except setDefaultEnemySize := false; end;
              end;
              function ApplicationConfiguration.getDefaultEnemySize() : integer; begin
               try
                  getDefaultEnemySize := defaultEnemySize;
               except getDefaultEnemySize := 0; end;
              end;
              function ApplicationConfiguration.setDefaultEnemySpeed(newDefaultEnemySpeed : integer) : boolean; begin
              try
                 defaultEnemySpeed := newDefaultEnemySpeed;
                 setDefaultEnemySpeed := true;
              except setDefaultEnemySpeed := false; end;
              end;
              function ApplicationConfiguration.getDefaultEnemySpeed() : integer; begin
               try
                  getDefaultEnemySpeed := defaultEnemySpeed;
               except getDefaultEnemySpeed := 0; end;
              end;
              function ApplicationConfiguration.setDefaultEnemyMoveInterval(newDefaultEnemyMoveInterval : integer) : boolean; begin
              try
                 defaultEnemyMoveInterval := newDefaultEnemyMoveInterval;
                 setDefaultEnemyMoveInterval := true;
              except setDefaultEnemyMoveInterval := false; end;
              end;
              function ApplicationConfiguration.getDefaultEnemyMoveInterval() : integer; begin
               try
                  getDefaultEnemyMoveInterval := defaultEnemyMoveInterval;
               except getDefaultEnemyMoveInterval := 0; end;
              end;

              function ApplicationConfiguration.setPointsForEnemy(newPointsForEnemy : integer) : boolean; begin
              try
                 pointsForEnemy := newPointsForEnemy;
                 setPointsForEnemy := true;
              except setPointsForEnemy := false; end;
              end;
              function ApplicationConfiguration.getPointsForEnemy() : integer; begin
               try
                  getPointsForEnemy := pointsForEnemy;
               except getPointsForEnemy := 0; end;
              end;
              function ApplicationConfiguration.setPointsToWin(newPointsToWin : integer) : boolean; begin
              try
                 pointsToWin := newPointsToWin;
                 setPointsToWin := true;
              except setPointsToWin := false; end;
              end;
              function ApplicationConfiguration.getPointsToWin() : integer; begin
               try
                  getPointsToWin := pointsToWin;
               except getPointsToWin := 0; end;
              end;

              function ApplicationConfiguration.setInitialEnemyCount(newInitialEnemyCount : integer) : boolean; begin
              try
                 initialEnemyCount := newInitialEnemyCount;
                 setInitialEnemyCount := true;
              except setInitialEnemyCount := false; end;
              end;
              function ApplicationConfiguration.getInitialEnemyCount() : integer; begin
               try
                 getInitialEnemyCount := initialEnemyCount;
               except getInitialEnemyCount := 0; end;
              end;

              function ApplicationConfiguration.setEnemyHatchInterval(newEnemyHatchInterval : integer) : boolean; begin
              try
                 enemyHatchInterval := newEnemyHatchInterval;
                 setEnemyHatchInterval := true;
              except setEnemyHatchInterval := false; end;
              end;
              function ApplicationConfiguration.getEnemyHatchInterval() : integer; begin
               try
                 getEnemyHatchInterval := enemyHatchInterval;
               except getEnemyHatchInterval := 0; end;
              end;
              function ApplicationConfiguration.setEnemyPopulationLimit(newEnemyPopulationLimit : integer) : boolean; begin
              try
                 enemyPopulationLimit := newEnemyPopulationLimit;
                 setEnemyPopulationLimit := true;
              except setEnemyPopulationLimit := false; end;
              end;
              function ApplicationConfiguration.getEnemyPopulationLimit() : integer; begin
               try
                 getEnemyPopulationLimit := enemyPopulationLimit;
               except getEnemyPopulationLimit := 0; end;
              end;

              constructor ApplicationConfiguration.initialize(); begin
                ApplicationConfiguration.setBoardPadding(50);
                ApplicationConfiguration.setBoardBorderWidth(4);

                ApplicationConfiguration.setDefaultPlayerSize(10);
                ApplicationConfiguration.setDefaultPlayerSpeed(8);

                ApplicationConfiguration.setDefaultEnemySize(5);
                ApplicationConfiguration.setDefaultEnemySpeed(2);
                ApplicationConfiguration.setDefaultEnemyMoveInterval(1000);

                ApplicationConfiguration.setPointsForEnemy(10);
                ApplicationConfiguration.setPointsToWin(100);

                ApplicationConfiguration.setInitialEnemyCount(5);

                ApplicationConfiguration.setEnemyHatchInterval(50000);
                ApplicationConfiguration.setEnemyPopulationLimit(20);
              end;
end.

