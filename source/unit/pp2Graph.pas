unit pp2Graph;

{$mode objfpc}{$H+}

interface
         uses classes, sysUtils, crt, graph, pp2Application;

         type
             BoardPointer = ^Board;
             PlayerPointer = ^Player;
             EnemyPointer = ^Enemy;

             Board = object
             private
                   padding, borderWidth : integer;
                   minX, minY, maxX, maxY : integer;

                   Player : PlayerPointer;
                   Enemy : EnemyPointer;

                   function setMinX(newMinX : integer) : boolean;
                   function setMaxX(newMaxX : integer) : boolean;
                   function setMinY(newMinY : integer) : boolean;
                   function setMaxY(newMaxY : integer) : boolean;

                   function setPadding(newPadding : integer) : boolean;
                   function setBorderWidth(newBorderWidth : integer) : boolean;

                   function draw() : boolean;
             public
                   function getPadding() : integer;
                   function getBorderWidth() : integer;

                   function getMinX() : integer;
                   function getMaxX() : integer;
                   function getMinY() : integer;
                   function getMaxY() : integer;

                   function setPlayer(newPlayer : PlayerPointer; selfPointer : BoardPointer) : boolean;
                   function getPlayer() : PlayerPointer;

                   function setEnemy(newEnemy : EnemyPointer; selfPointer : BoardPointer) : boolean;
                   function getEnemy() : EnemyPointer;

                   constructor initialize(ApplicationConfiguration : ApplicationConfigurationPointer);
             end;

             Entity = object
             private
                    x, y : integer;
                    size, speed : integer;
             public
                   function setX(newX : integer) : boolean;
                   function getX() : integer;
                   function setY(newY : integer) : boolean;
                   function getY() : integer;

                   function setSize(newSize : integer) : boolean;
                   function getSize() : integer;

                   function setSpeed(newSpeed : integer) : boolean;
                   function getSpeed() : integer;

                   function clear() : boolean;
             end;

             Player = object (Entity)
             private
                   Board : BoardPointer;

                   function setBoard(newBoard : BoardPointer) : boolean;
             public
                   function draw() : boolean;

                   function moveUp() : boolean;
                   function moveDown() : boolean;
                   function moveRight() : boolean;
                   function moveLeft() : boolean;

                   function randomizePosition() : boolean;

                   function getBoard() : BoardPointer;

                   constructor initialize(ApplicationConfiguration : ApplicationConfigurationPointer);
             end;

             Enemy = object (Entity)
             private
                   Board : BoardPointer;

                   function setBoard(newBoard : BoardPointer) : boolean;
             public
                   function draw() : boolean;

                   function moveUp() : boolean;
                   function moveDown() : boolean;
                   function moveRight() : boolean;
                   function moveLeft() : boolean;

                   function randomizePosition() : boolean;

                   function getBoard() : BoardPointer;

                   constructor initialize(ApplicationConfiguration : ApplicationConfigurationPointer);
             end;

implementation
              function Board.setPadding(newPadding : integer) : boolean; begin
              try
                 padding := newPadding;
                 setPadding := true;
              except setPadding := false; end;
              end;
              function Board.getPadding() : integer; begin
               try
                  getPadding := padding;
               except getPadding := 0; end;
              end;

              function Board.setBorderWidth(newBorderWidth : integer) : boolean; begin
              try
                 borderWidth := newBorderWidth;
                 setBorderWidth := true;
              except setBorderWidth := false; end;
              end;
              function Board.getBorderWidth() : integer; begin
               try
                  getBorderWidth := borderWidth;
               except getBorderWidth := 0; end;
              end;

              function Board.setMinX(newMinX : integer) : boolean; begin
              try
                 minX := newMinX;
                 setMinX := true;
              except setMinX := false; end;
              end;
              function Board.getMinX() : integer; begin
               try
                  getMinX := minX;
               except getMinX := 0; end;
              end;

              function Board.setMaxX(newMaxX : integer) : boolean; begin
              try
                 maxX := newMaxX;
                 setMaxX := true;
              except setMaxX := false; end;
              end;
              function Board.getMaxX() : integer; begin
               try
                  getMaxX := maxX;
               except getMaxX := 0; end;
              end;

              function Board.setMinY(newMinY : integer) : boolean; begin
              try
                 minY := newMinY;
                 setMinY := true;
              except setMinY := false; end;
              end;
              function Board.getMinY() : integer; begin
               try
                  getMinY := minY;
               except getMinY := 0; end;
              end;

              function Board.setMaxY(newMaxY : integer) : boolean; begin
              try
                 maxY := newMaxY;
                 setMaxY := true;
              except setMaxY := false; end;
              end;
              function Board.getMaxY() : integer; begin
               try
                 getMaxY := maxY;
               except getMaxY := 0; end;
              end;

              function Board.draw() : boolean;
              var i : integer;
              begin try
                 SetLineStyle(0, 0, 1);
                 SetColor(white);
                 for i := 1 to Board.getBorderWidth() do begin
                  line(Board.getMinX() - i, Board.getMinY() - Board.getBorderWidth(), Board.getMinX() - i, Board.getMaxY() + Board.getBorderWidth());
                  line(Board.getMaxX() + i, Board.getMinY() - Board.getBorderWidth(), Board.getMaxX() + i, Board.getMaxY() + Board.getBorderWidth());
                  line(Board.getMinX() - Board.getBorderWidth(), Board.getMinY() - i, Board.getMaxX() + Board.getBorderWidth(), Board.getMinY() - i);
                  line(Board.getMinX() - Board.getBorderWidth(), Board.getMaxY() + i, Board.getMaxX() + Board.getBorderWidth(), Board.getMaxY() + i);
                 end;

                 draw := true;
              except draw := false; end;
              end;

              function Board.setPlayer(newPlayer : PlayerPointer; selfPointer : BoardPointer) : boolean;  begin
               try
                newPlayer^.setBoard(selfPointer);
                Player := newPlayer;
                setPlayer := true;
               except setPlayer := false; end;
              end;
              function Board.getPlayer() : PlayerPointer; begin
               try
                 getPlayer := Player;
               except getPlayer := nil; end;
              end;

              function Board.setEnemy(newEnemy : EnemyPointer; selfPointer : BoardPointer) : boolean;  begin
               try
                newEnemy^.setBoard(selfPointer);
                Enemy := newEnemy;
                setEnemy := true;
               except setEnemy := false; end;
              end;
              function Board.getEnemy() : EnemyPointer; begin
               try
                 getEnemy := Enemy;
               except getEnemy := nil; end;
              end;

              constructor Board.initialize(ApplicationConfiguration : ApplicationConfigurationPointer); begin
                 Board.setPadding(ApplicationConfiguration^.getBoardPadding());
                 Board.setBorderWidth(ApplicationConfiguration^.getBoardBorderWidth());

                 Board.setMinX(Board.getPadding());
                 Board.setMinY(Board.getPadding());
                 Board.setMaxX(ApplicationConfiguration^.getGraphMaxX() - Board.getPadding());
                 Board.setMaxY(ApplicationConfiguration^.getGraphMaxY() - Board.getPadding());

                 Board.draw();
              end;

              function Entity.setX(newX : integer) : boolean; begin
              try
                 x := newX;
                 setX := true;
              except setX := false; end;
              end;
              function Entity.getX() : integer; begin
               try
                  getX := x;
               except getX := 0; end;
              end;

              function Entity.setY(newY : integer) : boolean; begin
              try
                 y := newY;
                 setY := true;
              except setY := false; end;
              end;
              function Entity.getY() : integer; begin
               try
                  getY := y;
               except getY := 0; end;
              end;

              function Entity.setSize(newSize : integer) : boolean; begin
               try
                       if (newSize < 2) then begin
                           setSize := false;
                       end else begin
                           size := newSize;
                           setSize := true;
                       end;
               except setSize := false; end;
              end;
              function Entity.getSize() : integer; begin
               try
                       getSize := size;
               except getSize := 0; end;
              end;

              function Entity.setSpeed(newSpeed : integer) : boolean; begin
               try
                       speed := newSpeed;
                       setSpeed := true;
               except setSpeed := false; end;
              end;
              function Entity.getSpeed() : integer; begin
               try
                       getSpeed := speed;
               except getSpeed := 0; end;
              end;

              function Entity.clear() : boolean;
              var localX, localY : integer;
              begin
               try
                for localX := Entity.getX() to (Entity.getX() + Entity.getSize() - 1) do begin
                 for localY := Entity.getY() to (Entity.getY() + Entity.getSize() - 1) do begin
                  PutPixel(localX, localY, black);
                 end;
                end;
                clear := true;
               except clear := false; end;
              end;

              function Player.draw() : boolean; begin
               try
                setFillStyle(solidFill, LightBlue);
                bar(Player.getX(), Player.getY(), Player.getX() + Player.getSize() - 1, Player.getY() + Player.getSize() - 1);
                draw := true;
               except draw := false; end;
              end;

              function Player.moveUp() : boolean; begin
               try
                  if (Player.getY() >= (Player.getSpeed() + Player.getBoard()^.getMinY())) then begin
                     self.clear();
                     Player.setY(Player.getY() - Player.getSpeed());
                     Player.draw();
                  end else if (Player.getY() > Player.getBoard()^.getMinY()) then begin
                     Player.clear();
                     Player.setY(Player.getBoard()^.getMinX());
                     Player.draw();
                  end;
                moveUp := true;
               except moveUp := false; end;
              end;

              function Player.moveDown() : boolean; begin
               try
                 if ((Player.getBoard()^.getMaxY() - Player.getY() - Player.getSize() + 1) >= Player.getSpeed()) then begin
                     self.clear();
                     Player.setY(Player.getY() + Player.getSpeed());
                     Player.draw();
                  end else if ((Player.getBoard()^.getMaxY() - Player.getY() - Player.getSize() + 1) > 0) then begin
                     Player.clear();
                     Player.setY(Player.getBoard()^.getMaxY() - Player.getSize() + 1);
                     Player.draw();
                  end;
                moveDown := true;
               except moveDown := false; end;
              end;

              function Player.moveRight() : boolean; begin
               try
                  if ((Player.getBoard()^.getMaxX() - Player.getX() - Player.getSize() + 1) >= Player.getSpeed()) then begin
                     self.clear();
                     Player.setX(Player.getX() + Player.getSpeed());
                     Player.draw();
                  end else if ((Player.getBoard()^.getMaxX() - Player.getX() - Player.getSize() + 1) > 0) then begin
                     Player.clear();
                     Player.setX(Player.getBoard()^.getMaxX() - Player.getSize() + 1);
                     Player.draw();
                  end;
                moveRight := true;
               except moveRight := false; end;
              end;

              function Player.moveLeft() : boolean; begin
               try
                  if (Player.getX() >= (Player.getSpeed() + Player.getBoard()^.getMinX())) then begin
                     self.clear();
                     Player.setX(Player.getX() - Player.getSpeed());
                     Player.draw();
                  end else if (Player.getX() > Player.getBoard()^.getMinX()) then begin
                     Player.clear();
                     Player.setX(Board^.getMinX());
                     Player.draw();
                  end;
                moveLeft := true;
               except moveLeft := false; end;
              end;

              function Player.randomizePosition() : boolean; begin
               try
                Player.setX(random(Player.getBoard()^.getMaxX() - Player.getBoard()^.getMinX() - Player.getSize()) + Player.getBoard()^.getMinX());
                Player.setY(random(Player.getBoard()^.getMaxY() - Player.getBoard()^.getMinY() - Player.getSize()) + Player.getBoard()^.getMinY());
                randomizePosition := true;
               except randomizePosition := false; end;
              end;

              function Player.setBoard(newBoard : BoardPointer) : boolean;  begin
               try
                Board := newBoard;
                setBoard := true;
               except setBoard := false; end;
              end;
              function Player.getBoard() : BoardPointer; begin
               try
                 getBoard := Board;
               except getBoard := nil; end;
              end;

              constructor Player.initialize(ApplicationConfiguration : ApplicationConfigurationPointer); begin
                Player.setSize(ApplicationConfiguration^.getDefaultPlayerSize());
                Player.setSpeed(ApplicationConfiguration^.getDefaultPlayerSpeed());
              end;

              function Enemy.draw() : boolean; begin
               try
                setFillStyle(solidFill, Red);
                bar(Enemy.getX(), Enemy.getY(), Enemy.getX() + Enemy.getSize() - 1, Enemy.getY() + Enemy.getSize() - 1);
                draw := true;
               except draw := false; end;
              end;

              function Enemy.moveUp() : boolean; begin
               try
                  if (Enemy.getY() >= (Enemy.getSpeed() + Enemy.getBoard()^.getMinY())) then begin
                     self.clear();
                     Enemy.setY(Enemy.getY() - Enemy.getSpeed());
                     Enemy.draw();
                  end else if (Enemy.getY() > Enemy.getBoard()^.getMinY()) then begin
                     Enemy.clear();
                     Enemy.setY(Enemy.getBoard()^.getMinX());
                     Enemy.draw();
                  end;
                moveUp := true;
               except moveUp := false; end;
              end;

              function Enemy.moveDown() : boolean; begin
               try
                 if ((Enemy.getBoard()^.getMaxY() - Enemy.getY() - Enemy.getSize() + 1) >= Enemy.getSpeed()) then begin
                     self.clear();
                     Enemy.setY(Enemy.getY() + Enemy.getSpeed());
                     Enemy.draw();
                  end else if ((Enemy.getBoard()^.getMaxY() - Enemy.getY() - Enemy.getSize() + 1) > 0) then begin
                     Enemy.clear();
                     Enemy.setY(Enemy.getBoard()^.getMaxY() - Enemy.getSize() + 1);
                     Enemy.draw();
                  end;
                moveDown := true;
               except moveDown := false; end;
              end;

              function Enemy.moveRight() : boolean; begin
               try
                  if ((Enemy.getBoard()^.getMaxX() - Enemy.getX() - Enemy.getSize() + 1) >= Enemy.getSpeed()) then begin
                     self.clear();
                     Enemy.setX(Enemy.getX() + Enemy.getSpeed());
                     Enemy.draw();
                  end else if ((Enemy.getBoard()^.getMaxX() - Enemy.getX() - Enemy.getSize() + 1) > 0) then begin
                     Enemy.clear();
                     Enemy.setX(Enemy.getBoard()^.getMaxX() - Enemy.getSize() + 1);
                     Enemy.draw();
                  end;
                moveRight := true;
               except moveRight := false; end;
              end;

              function Enemy.moveLeft() : boolean; begin
               try
                  if (Enemy.getX() >= (Enemy.getSpeed() + Enemy.getBoard()^.getMinX())) then begin
                     self.clear();
                     Enemy.setX(Enemy.getX() - Enemy.getSpeed());
                     Enemy.draw();
                  end else if (Enemy.getX() > Enemy.getBoard()^.getMinX()) then begin
                     Enemy.clear();
                     Enemy.setX(Board^.getMinX());
                     Enemy.draw();
                  end;
                moveLeft := true;
               except moveLeft := false; end;
              end;

              function Enemy.randomizePosition() : boolean; begin
               try
                Enemy.setX(random(Enemy.getBoard()^.getMaxX() - Enemy.getBoard()^.getMinX() - Enemy.getSize()) + Enemy.getBoard()^.getMinX());
                Enemy.setY(random(Enemy.getBoard()^.getMaxY() - Enemy.getBoard()^.getMinY() - Enemy.getSize()) + Enemy.getBoard()^.getMinY());
                randomizePosition := true;
               except randomizePosition := false; end;
              end;

              function Enemy.setBoard(newBoard : BoardPointer) : boolean;  begin
               try
                Board := newBoard;
                setBoard := true;
               except setBoard := false; end;
              end;
              function Enemy.getBoard() : BoardPointer; begin
               try
                 getBoard := Board;
               except getBoard := nil; end;
              end;

              constructor Enemy.initialize(ApplicationConfiguration : ApplicationConfigurationPointer); begin
                Enemy.setSize(ApplicationConfiguration^.getDefaultEnemySize());
                Enemy.setSpeed(ApplicationConfiguration^.getDefaultEnemySpeed());
              end;
end.

