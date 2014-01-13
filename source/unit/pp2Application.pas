unit pp2Application;

{$mode objfpc}{$H+}

interface
         type
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

                   constructor initialize();
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

              constructor Application.initialize();
               var cardLocal, modeLocal : smallint;
               begin
                Application.setCard(0);
                Application.setMode(0);

                cardLocal := Application.getCard();
                modeLocal := Application.getMode();

                initGraph(cardLocal, modeLocal, '');
              end;
end.

