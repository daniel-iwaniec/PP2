unit pp2Graph;

{$mode objfpc}{$H+}

interface
         uses classes, sysUtils, crt, graph, pp2Application;

         type
             BoardPointer = ^Board;
             PlayerPointer = ^Player;
             EnemyPointer = ^Enemy;
             EnemyListPointer = ^EnemyList;

             Board = object
             private
                   padding, borderWidth : integer;
                   minX, minY, maxX, maxY : integer;

                   Player : PlayerPointer;
                   Enemy : EnemyPointer;
                   EnemyList : EnemyListPointer;

                   points, pointsToWin : integer;
                   win : boolean;

                   function setMinX(newMinX : integer) : boolean;
                   function setMaxX(newMaxX : integer) : boolean;
                   function setMinY(newMinY : integer) : boolean;
                   function setMaxY(newMaxY : integer) : boolean;

                   function setPadding(newPadding : integer) : boolean;
                   function setBorderWidth(newBorderWidth : integer) : boolean;

                   function setPointsToWin(newPointsToWin : integer) : boolean;
                   function setWin(newWin : boolean) : boolean;

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

                   function setEnemyList(newEnemyList : EnemyListPointer; selfPointer : BoardPointer) : boolean;
                   function getEnemyList() : EnemyListPointer;

                   function setPoints(newPoints : integer) : boolean;
                   function getPoints() : integer;
                   function getPointsToWin() : integer;
                   function printPoints() : boolean;

                   function getWin() : boolean;
                   function checkForWin() : boolean;

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

                   function checkForCollision(Enemy : EnemyPointer) : boolean;
                   function checkForCollisions(EnemyList : EnemyListPointer) : boolean;

                   constructor initialize(ApplicationConfiguration : ApplicationConfigurationPointer);
             end;

             Enemy = object (Entity)
             private
                   Board : BoardPointer;

                   moveInterval, moveCounter : integer;

                   alive : boolean;
                   value : integer;

                   id : integer;
                   next, previous : EnemyPointer;

                   function setBoard(newBoard : BoardPointer) : boolean;
                   function setMoveInterval(newMoveInterval : integer) : boolean;
                   function getMoveInterval() : integer;
                   function setMoveCounter(newMoveCounter : integer) : boolean;
                   function getMoveCounter() : integer;

                   function setAlive(newAlive : boolean) : boolean;
                   function getAlive() : boolean;

                   function setValue(newValue : integer) : boolean;
                   function getValue() : integer;
             public
                   function draw() : boolean;
                   function randomizePosition() : boolean;

                   function moveUp() : boolean;
                   function moveDown() : boolean;
                   function moveRight() : boolean;
                   function moveLeft() : boolean;
                   function move() : boolean;

                   function setId(newId : integer) : boolean;
                   function getId() : integer;
                   function setNext(newNext : EnemyPointer) : boolean;
                   function getNext() : EnemyPointer;
                   function setPrevious(newPrevious : EnemyPointer) : boolean;
                   function getPrevious() : EnemyPointer;

                   function getBoard() : BoardPointer;
                   constructor initialize(ApplicationConfiguration : ApplicationConfigurationPointer);
                   destructor kill();
             end;

             EnemyList = object
                 private
                  head, tail: EnemyPointer;
                  initialCount, count: integer;

                  Board : BoardPointer;

                  enemyHatchInterval, enemyHatchCounter, enemyPopulationLimit : integer;

                  function setInitialCount(newInitialCount : integer) : boolean;
                  function getInitialCount() : integer;

                  function setBoard(newBoard : BoardPointer) : boolean;
                 public
                  function getBoard() : BoardPointer;

                  function setHead(newHead : EnemyPointer) : boolean;
                  function getHead() : EnemyPointer;
                  function setTail(newTail : EnemyPointer) : boolean;
                  function getTail() : EnemyPointer;
                  function setCount(newCount : integer) : boolean;
                  function getCount() : integer;

                  function add() : integer;
                  function remove(enemyId : integer) : boolean;
                  function getEnemy(enemyId : integer) : EnemyPointer;
                  function initializeEnemies() : boolean;

                  function move() : boolean;

                  function setEnemyHatchInterval(newEnemyHatchInterval: integer) : boolean;
                  function getEnemyHatchInterval() : integer;
                  function setEnemyHatchCounter(newEnemyHatchCounter: integer) : boolean;
                  function getEnemyHatchCounter() : integer;
                  function setEnemyPopulationLimit(newEnemyPopulationLimit: integer) : boolean;
                  function getEnemyPopulationLimit() : integer;

                  function hatch() : boolean;

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

              function Board.setEnemyList(newEnemyList : EnemyListPointer; selfPointer : BoardPointer) : boolean;  begin
               try
                newEnemyList^.setBoard(selfPointer);
                EnemyList := newEnemyList;
                setEnemyList := true;
               except setEnemyList := false; end;
              end;
              function Board.getEnemyList() : EnemyListPointer; begin
               try
                 getEnemyList := EnemyList;
               except getEnemyList := nil; end;
              end;

              function Board.setPoints(newPoints : integer) : boolean; begin
              try
                 points := newPoints;
                 setPoints := true;
              except setPoints := false; end;
              end;
              function Board.getPoints() : integer; begin
               try
                  getPoints := points;
               except getPoints := 0; end;
              end;
              function Board.setPointsToWin(newPointsToWin : integer) : boolean; begin
              try
                 pointsToWin := newPointsToWin;
                 setPointsToWin := true;
              except setPointsToWin := false; end;
              end;
              function Board.getPointsToWin() : integer; begin
               try
                  getPointsToWin := pointsToWin;
               except getPointsToWin := 0; end;
              end;
              function Board.printPoints() : boolean;
              var pointsString : string; localX, localY : integer; localTextHeight, localTextWidth : word;
              begin
               try
                  SetTextStyle(3, 0, 0);
                  str(Board.getPoints(), pointsString);
                  pointsString := 'Points: ' + pointsString;
                  localTextHeight := TextHeight(pointsString);
                  localTextWidth := TextWidth(pointsString);

                  for localX := Board.getPadding() to (Board.getPadding() + localTextWidth - 2) do begin
                   for localY := (Board.getPadding() - Board.getBorderWidth() - localTextHeight - 2) to (Board.getPadding() - Board.getBorderWidth() - localTextHeight - 4 + localTextHeight) do begin
                    PutPixel(localX, localY, black);
                   end;
                  end;

                  OutTextXY(Board.getPadding(), (Board.getPadding() - Board.getBorderWidth() - localTextHeight - 2), pointsString);
                  printPoints := true;
               except printPoints := false; end;
              end;

              function Board.setWin(newWin : boolean) : boolean; begin
              try
                 win := newWin;
                 setWin := true;
              except setWin := false; end;
              end;
              function Board.getWin() : boolean; begin
               try
                  getWin := win;
               except getWin := false; end;
              end;

              function Board.checkForWin() : boolean; begin
               try
                  if (Board.getPoints() >= Board.getPointsToWin()) then begin
                   Board.setWin(true);

                   SetTextStyle(3, 0, 0);
                   OutTextXY(300, 300, 'Winner');

                   checkForWin := true;
                  end else begin
                   Board.setWin(false);
                   checkForWin := false;
                  end;
               except checkForWin := false; end;
              end;

              constructor Board.initialize(ApplicationConfiguration : ApplicationConfigurationPointer); begin
                 Board.setPadding(ApplicationConfiguration^.getBoardPadding());
                 Board.setBorderWidth(ApplicationConfiguration^.getBoardBorderWidth());

                 Board.setMinX(Board.getPadding());
                 Board.setMinY(Board.getPadding());
                 Board.setMaxX(ApplicationConfiguration^.getGraphMaxX() - Board.getPadding());
                 Board.setMaxY(ApplicationConfiguration^.getGraphMaxY() - Board.getPadding());

                 Board.draw();

                 Board.setPoints(0);
                 Board.setPointsToWin(ApplicationConfiguration^.getPointsToWin());
                 Board.printPoints();
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

              function Player.checkForCollision(Enemy : EnemyPointer) : boolean; begin
               try
                 if ((Player.getX() <= (Enemy^.getX() + Enemy^.getSize() - 1))
                     and ((Player.getX() + Player.getSize() - 1) >= Enemy^.getX())
                     and (Player.getY() <= (Enemy^.getY() + Enemy^.getSize() - 1))
                     and ((Player.getY() + Player.getSize() - 1) >= Enemy^.getY())
                     and (Enemy^.getAlive())) then begin
                  Player.getBoard()^.setPoints(Player.getBoard()^.getPoints + Enemy^.getValue());
                  Player.getBoard()^.printPoints();

                  Enemy^.clear();
                  Player.draw();

                  Enemy^.setAlive(false);
                  Player.getBoard()^.checkForWin();
                  checkForCollision := true;
                 end else begin
                  checkForCollision := false;
                 end;
               except checkForCollision := false; end;
              end;

              function Player.checkForCollisions(EnemyList : EnemyListPointer) : boolean;
              var i : integer; Enemy : EnemyPointer;
              begin
               try
                for i := 1 to EnemyList^.getCount() do begin
                 Enemy := EnemyList^.getEnemy(i);
                 Player.checkForCollision(Enemy);
                end;
                checkForCollisions := true;
               except checkForCollisions := false; end;
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

              function Enemy.move() : boolean;
              var direction, localMoveInterval, localMoveCounter : integer;
              begin
               try
                if (Enemy.getAlive()) then begin
                 localMoveInterval := Enemy.getMoveInterval();
                 localMoveCounter := Enemy.getMoveCounter();

                 if (localMoveCounter >= localMoveInterval) then begin
                  Enemy.setMoveCounter(0);
                  direction := random(4) + 1;

                  if (direction = 1) then begin
                   Enemy.moveUp();
                  end else if (direction = 2) then begin
                   Enemy.moveDown();
                  end else if (direction = 3) then begin
                   Enemy.moveRight();
                  end else if (direction = 4) then begin
                   Enemy.moveLeft();
                  end;
                 end else begin
                  localMoveCounter := localMoveCounter + 1;
                  Enemy.setMoveCounter(localMoveCounter);
                 end;
                 move := true;
                end else begin
                 move := false;
                end;
               except move := false; end;
              end;

              function Enemy.randomizePosition() : boolean;
              var isColliding : boolean; i : integer; EnemyLocal : EnemyPointer;
              begin
               try
                isColliding := false;

                repeat
                 Enemy.setX(random(Enemy.getBoard()^.getMaxX() - Enemy.getBoard()^.getMinX() - Enemy.getSize()) + Enemy.getBoard()^.getMinX());
                 Enemy.setY(random(Enemy.getBoard()^.getMaxY() - Enemy.getBoard()^.getMinY() - Enemy.getSize()) + Enemy.getBoard()^.getMinY());

                  for i := 1 to Enemy.getBoard()^.getEnemyList()^.getCount() do begin
                   if (Enemy.getId() <> i) then begin
                    EnemyLocal := Enemy.getBoard()^.getEnemyList()^.getEnemy(i);

                    if ((Enemy.getX() <= (EnemyLocal^.getX() + EnemyLocal^.getSize() - 1))
                     and ((Enemy.getX() + Enemy.getSize() - 1) >= EnemyLocal^.getX())
                     and (Enemy.getY() <= (EnemyLocal^.getY() + EnemyLocal^.getSize() - 1))
                     and ((Enemy.getY() + Enemy.getSize() - 1) >= EnemyLocal^.getY())) then begin
                      isColliding := true;
                      break;
                    end;
                   end;
                  end;

                  if (isColliding = false) then begin
                   if ((Enemy.getBoard()^.getPlayer()^.getX() <= (Enemy.getX() + Enemy.getSize() - 1))
                      and ((Enemy.getBoard()^.getPlayer()^.getX() + Enemy.getBoard()^.getPlayer()^.getSize() - 1) >= Enemy.getX())
                      and (Enemy.getBoard()^.getPlayer()^.getY() <= (Enemy.getY() + Enemy.getSize() - 1))
                      and ((Enemy.getBoard()^.getPlayer()^.getY() + Enemy.getBoard()^.getPlayer()^.getSize() - 1) >= Enemy.getY())) then begin
                       isColliding := true;
                   end;
                  end;
                until not(isColliding);

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

              function Enemy.setMoveInterval(newMoveInterval : integer) : boolean;  begin
               try
                moveInterval := newMoveInterval;
                setMoveInterval := true;
               except setMoveInterval := false; end;
              end;
              function Enemy.getMoveInterval() : integer; begin
               try
                 getMoveInterval := moveInterval;
               except getMoveInterval := 0; end;
              end;

              function Enemy.setMoveCounter(newMoveCounter : integer) : boolean;  begin
               try
                moveCounter := newMoveCounter;
                setMoveCounter := true;
               except setMoveCounter := false; end;
              end;
              function Enemy.getMoveCounter() : integer; begin
               try
                 getMoveCounter := moveCounter;
               except getMoveCounter := 0; end;
              end;

              function Enemy.setAlive(newAlive : boolean) : boolean;  begin
               try
                alive := newAlive;
                setAlive := true;
               except setAlive := false; end;
              end;
              function Enemy.getAlive() : boolean; begin
               try
                 getAlive := alive;
               except getAlive := true; end;
              end;

              function Enemy.setValue(newValue : integer) : boolean; begin
              try
                 value := newValue;
                 setValue := true;
              except setValue := false; end;
              end;
              function Enemy.getValue() : integer; begin
               try
                  getValue := value;
               except getValue := 0; end;
              end;

              function Enemy.setId(newId : integer) : boolean; begin
              try
                 id := newId;
                 setId := true;
              except setId := false; end;
              end;
              function Enemy.getId() : integer; begin
               try
                  getId := id;
               except getId := 0; end;
              end;
              function Enemy.setNext(newNext : EnemyPointer) : boolean; begin
              try
                 next := newNext;
                 setNext := true;
              except setNext := false; end;
              end;
              function Enemy.getNext() : EnemyPointer; begin
               try
                  getNext := next;
               except getNext := nil; end;
              end;
              function Enemy.setPrevious(newPrevious : EnemyPointer) : boolean; begin
              try
                 previous := newPrevious;
                 setPrevious := true;
              except setPrevious := false; end;
              end;
              function Enemy.getPrevious() : EnemyPointer; begin
               try
                  getPrevious := previous;
               except getPrevious := nil; end;
              end;

              constructor Enemy.initialize(ApplicationConfiguration : ApplicationConfigurationPointer); begin
                Enemy.setSize(ApplicationConfiguration^.getDefaultEnemySize());
                Enemy.setSpeed(ApplicationConfiguration^.getDefaultEnemySpeed());
                Enemy.setMoveInterval(ApplicationConfiguration^.getDefaultEnemyMoveInterval());
                Enemy.setMoveCounter(0);

                Enemy.setAlive(true);
                Enemy.setValue(ApplicationConfiguration^.getPointsForEnemy());

                Enemy.setId(0);
                Enemy.setNext(nil);
                Enemy.setPrevious(nil);
              end;

              destructor Enemy.kill(); begin
                Enemy.setId(0);
                Enemy.setNext(nil);
                Enemy.setPrevious(nil);
              end;

              function EnemyList.setInitialCount(newInitialCount : integer) : boolean; begin
              try
                 initialCount := newInitialCount;
                 setInitialCount := true;
              except setInitialCount := false; end;
              end;
              function EnemyList.getInitialCount() : integer; begin
               try
                 getInitialCount := initialCount;
               except getInitialCount := 0; end;
              end;

              function EnemyList.setBoard(newBoard : BoardPointer) : boolean;  begin
               try
                Board := newBoard;
                setBoard := true;
               except setBoard := false; end;
              end;
              function EnemyList.getBoard() : BoardPointer; begin
               try
                 getBoard := Board;
               except getBoard := nil; end;
              end;

              function EnemyList.setHead(newHead : EnemyPointer) : boolean;  begin
               try
                head := newHead;
                setHead := true;
               except setHead := false; end;
              end;
              function EnemyList.getHead() : EnemyPointer; begin
               try
                 getHead := head;
               except getHead := nil; end;
              end;
              function EnemyList.setTail(newTail : EnemyPointer) : boolean;  begin
               try
                tail := newTail;
                setTail := true;
               except setTail := false; end;
              end;
              function EnemyList.getTail() : EnemyPointer; begin
               try
                 getTail := tail;
               except getTail := nil; end;
              end;
              function EnemyList.setCount(newCount : integer) : boolean;  begin
               try
                count := newCount;
                setCount := true;
               except setCount := false; end;
              end;
              function EnemyList.getCount() : integer; begin
               try
                 getCount := count;
               except getCount := 0; end;
              end;

              function EnemyList.add() : integer;
              var Enemy : EnemyPointer; ApplicationConfiguration : ApplicationConfigurationPointer;
              begin
               try
                EnemyList.setCount(EnemyList.getCount() + 1);

                ApplicationConfiguration := new (ApplicationConfigurationPointer, initialize);
                Enemy := new (EnemyPointer, initialize(ApplicationConfiguration));
                EnemyList.getBoard()^.setEnemy(Enemy, EnemyList.getBoard());

                Enemy^.setNext(nil);
                Enemy^.setPrevious(EnemyList.getTail());

                if (EnemyList.getTail() <> nil) then begin
                   EnemyList.getTail()^.setNext(Enemy);
                   Enemy^.setId(EnemyList.getTail()^.getId() + 1);
                end else begin
                   Enemy^.setId(1);
                end;

                EnemyList.setTail(Enemy);

                if (EnemyList.getHead() = nil) then begin
                  EnemyList.setHead(Enemy);
                end;

                add := Enemy^.getId();
               except add := 0; end;
              end;

              function EnemyList.remove(enemyId : integer) : boolean;
              var Enemy : EnemyPointer;
              begin
               try
                  if EnemyList.getCount() > 0  then begin
                     EnemyList.setCount(EnemyList.getCount() - 1);

                     Enemy := EnemyList.getEnemy(enemyId);
                     if (Enemy <> nil) then begin
                        if (Enemy^.getPrevious() <> nil) then begin
                           Enemy^.getPrevious()^.setNext(Enemy^.getNext());
                        end;

                        if (Enemy^.getNext() <> nil) then begin
                           Enemy^.getNext()^.setPrevious(Enemy^.getPrevious());
                        end;
                     end;

                     if (Enemy <> nil) then dispose(Enemy, kill);
                  end;
                remove := true;
               except remove := false; end;
              end;

              function EnemyList.getEnemy(enemyId : integer) : EnemyPointer;
              var Enemy : EnemyPointer;
              begin
               try
                Enemy := nil;
                repeat
                      if (Enemy = nil) then Enemy := EnemyList.getHead() else Enemy := Enemy^.getNext();
                      if (Enemy = nil) then break;
                until (Enemy^.getId() = enemyId);

                getEnemy := Enemy;
               except getEnemy := nil; end;
              end;

              function EnemyList.initializeEnemies() : boolean;
              var i : integer; Enemy : EnemyPointer;
              begin
                try
                  for i := 1 to EnemyList.getInitialCount() do begin
                    EnemyList.add();
                    Enemy := EnemyList.getEnemy(i);
                    Enemy^.randomizePosition();
                    Enemy^.draw();
                  end;

                  initializeEnemies := true;
                except initializeEnemies := false; end;
              end;

              function EnemyList.move() : boolean;
              var i : integer; Enemy : EnemyPointer;
              begin
               try
                for i := 1 to EnemyList.getCount() do begin
                 Enemy := EnemyList.getEnemy(i);
                 Enemy^.move();
                end;

                move := true;
               except move := false; end;
              end;

              function EnemyList.hatch() : boolean;
              var localHatchCounter, localHatchInterval, id : integer; Enemy : EnemyPointer;
              begin
               try
                 if (EnemyList.getCount() < EnemyList.getEnemyPopulationLimit()) then begin
                    localHatchInterval := EnemyList.getEnemyHatchInterval();
                    localHatchCounter := EnemyList.getEnemyHatchCounter();

                    if (localHatchCounter >= localHatchInterval) then begin
                       EnemyList.setEnemyHatchCounter(0);

                       id := EnemyList.add();
                       Enemy := EnemyList.getEnemy(id);
                       Enemy^.randomizePosition();
                       Enemy^.draw();
                    end else begin
                       localHatchCounter := localHatchCounter + 1;
                       EnemyList.setEnemyHatchCounter(localHatchCounter);
                    end;
                 end;
                hatch := true;
               except hatch := false; end;
              end;

              function EnemyList.setEnemyHatchInterval(newEnemyHatchInterval : integer) : boolean; begin
              try
                 enemyHatchInterval := newEnemyHatchInterval;
                 setEnemyHatchInterval := true;
              except setEnemyHatchInterval := false; end;
              end;
              function EnemyList.getEnemyHatchInterval() : integer; begin
               try
                 getEnemyHatchInterval := enemyHatchInterval;
               except getEnemyHatchInterval := 0; end;
              end;
              function EnemyList.setEnemyHatchCounter(newEnemyHatchCounter : integer) : boolean; begin
              try
                 enemyHatchCounter := newEnemyHatchCounter;
                 setEnemyHatchCounter := true;
              except setEnemyHatchCounter := false; end;
              end;
              function EnemyList.getEnemyHatchCounter() : integer; begin
               try
                 getEnemyHatchCounter := enemyHatchCounter;
               except getEnemyHatchCounter := 0; end;
              end;
              function EnemyList.setEnemyPopulationLimit(newEnemyPopulationLimit : integer) : boolean; begin
              try
                 enemyPopulationLimit := newEnemyPopulationLimit;
                 setEnemyPopulationLimit := true;
              except setEnemyPopulationLimit := false; end;
              end;
              function EnemyList.getEnemyPopulationLimit() : integer; begin
               try
                 getEnemyPopulationLimit := enemyPopulationLimit;
               except getEnemyPopulationLimit := 0; end;
              end;

              constructor EnemyList.initialize(ApplicationConfiguration : ApplicationConfigurationPointer); begin
               EnemyList.setInitialCount(ApplicationConfiguration^.getInitialEnemyCount());

               EnemyList.setEnemyHatchInterval(ApplicationConfiguration^.getEnemyHatchInterval());
               EnemyList.setEnemyHatchCounter(0);
               EnemyList.setEnemyPopulationLimit(ApplicationConfiguration^.getEnemyPopulationLimit());

               EnemyList.setHead(nil);
               EnemyList.setTail(nil);
               EnemyList.setCount(0);
              end;
end.

