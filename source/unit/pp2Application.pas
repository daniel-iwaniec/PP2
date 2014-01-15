unit pp2Application;

{$mode objfpc}{$H+}

interface
         type
             ApplicationConfigurationPointer = ^ApplicationConfiguration;
             ApplicationConfiguration = object
             private
                   boardPadding : integer;
                   boardBorderWidth : integer;

                   graphMaxX, graphMaxY : integer;

                   function setBoardPadding(newBoardPadding : integer) : boolean;
                   function setBoardBorderWidth(newBoardBorderWidth : integer) : boolean;

                   function setGraphMaxX(newGraphMaxX: integer) : boolean;
                   function setGraphMaxY(newGraphMaxY: integer) : boolean;
             public
                   function getBoardPadding() : integer;
                   function getBoardBorderWidth() : integer;

                   function getGraphMaxX() : integer;
                   function getGraphMaxY() : integer;

                   constructor initialize();
             end;

             ApplicationPointer = ^Application;
             Application = object
             private
                   card : smallint;
                   mode : smallint;
                   lastPressedKey : char;

                   function setLastPressedKey(newLastPressedKey : char) : boolean;
             public
                   function setCard(newCard : smallint) : boolean;
                   function getCard() : smallint;

                   function setMode(newMode : smallint) : boolean;
                   function getMode() : smallint;

                   function isKeyPressed() : boolean;
                   function getLastPressedKey() : char;

                   constructor initialize(ApplicationConfiguration : ApplicationConfigurationPointer);
             end;

implementation
              uses classes, sysUtils, crt, graph;

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

              constructor Application.initialize(ApplicationConfiguration : ApplicationConfigurationPointer);
               var cardLocal, modeLocal : smallint;
               begin
                Application.setCard(0);
                Application.setMode(0);

                cardLocal := Application.getCard();
                modeLocal := Application.getMode();

                initGraph(cardLocal, modeLocal, '');
                ApplicationConfiguration^.setGraphMaxX(GetMaxX());
                ApplicationConfiguration^.setGraphMaxY(GetMaxY());
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

              constructor ApplicationConfiguration.initialize(); begin
                ApplicationConfiguration.setBoardPadding(50);
                ApplicationConfiguration.setBoardBorderWidth(4);
              end;
end.

