unit pp2Graph;

{$mode objfpc}{$H+}

interface
         type
             BoardPointer = ^Board;
             Board = object
             private
                   padding, borderWidth : integer;
                   minX, minY, maxX, maxY : integer;

                   function setMinX(newMinX : integer) : boolean;
                   function setMaxX(newMaxX : integer) : boolean;
                   function setMinY(newMinY : integer) : boolean;
                   function setMaxY(newMaxY : integer) : boolean;
             public
                   function setPadding(newPadding : integer) : boolean;
                   function getPadding() : integer;

                   function setBorderWidth(newBorderWidth : integer) : boolean;
                   function getBorderWidth() : integer;

                   function getMinX() : integer;
                   function getMaxX() : integer;
                   function getMinY() : integer;
                   function getMaxY() : integer;

                   function calculateBoundaries() : boolean;
                   function draw() : boolean;
             end;

             Entity = object
             private
                    x, y : integer;
                    width, height : integer;
                    speed : integer;
             public
                   function setX(newX : integer) : boolean;
                   function getX() : integer;
                   function setY(newY : integer) : boolean;
                   function getY() : integer;

                   function setPosition(newX, newY : integer) : boolean;

                   function setWidth(newWidth : integer) : boolean;
                   function getWidth() : integer;
                   function setHeight(newHeight : integer) : boolean;
                   function getHeight() : integer;

                   function setDimensions(newWidth, newHeight : integer) : boolean;

                   function setSpeed(newSpeed : integer) : boolean;
                   function getSpeed() : integer;

                   {procedure clear();}
             end;

             PlayerPointer = ^Player;
             Player = object (Entity)
             end;

             EnemyPointer = ^Enemy;
             Enemy = object (Entity)
             private
                   ID : integer;

                   listNext : EnemyPointer;
                   listPrevious : EnemyPointer;
             public
                   function setID(newID : integer) : boolean;
                   function getID() : integer;

                   function setListNext(newListNext : EnemyPointer) : boolean;
                   function getListNext() : EnemyPointer;

                   function setListPrevious(newListPrevious : EnemyPointer) : boolean;
                   function getListPrevious() : EnemyPointer;
             end;

implementation
              uses classes, sysUtils, crt, graph;

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

              function Board.calculateBoundaries() : boolean; begin
              try
                 Board.setMinX(Board.getPadding());
                 Board.setMinY(Board.getPadding());
                 Board.setMaxX(GetMaxX() - Board.getPadding());
                 Board.setMaxY(GetMaxY() - Board.getPadding());
                 calculateBoundaries := true;
              except calculateBoundaries := false; end;
              end;

              function Board.draw() : boolean; begin
              try
                 SetLineStyle(0, 0, 1);
                 SetColor(white);
                 for counter := 1 to boardBorderWidth do begin
                  line(minX-counter, minY-boardBorderWidth, minX-counter, maxY+boardBorderWidth);
                  line(maxX+counter, minY-boardBorderWidth, maxX+counter, maxY+boardBorderWidth);
                  line(minX-boardBorderWidth, minY-counter, maxX+boardBorderWidth, minY-counter);
                  line(minX-boardBorderWidth, maxY+counter, maxX+boardBorderWidth, maxY+counter);
                 end;
                 draw := true;
              except draw := false; end;
              end;

              function Entity.setX(newX : integer) : boolean; begin
              try
                 X := newX;
                 setX := true;
              except setX := false; end;
              end;
              function Entity.getX() : integer; begin
               try
                  getX := X;
               except getX := 0; end;
              end;

              function Entity.setY(newY : integer) : boolean; begin
                       Y := newY;
                       setY := true;
              end;
              function Entity.getY() : integer; begin
                       getY := Y;
              end;

              function Entity.setPosition(newX, newY : integer) : boolean; begin
                       Entity.setX(newX);
                       Entity.setY(newY);

                       setPosition := true;
              end;

              function Entity.setWidth(newWidth : integer) : boolean; begin
                       width := newWidth;
                       setWidth := true;
              end;
              function Entity.getWidth() : integer; begin
                       getWidth := width;
              end;

              function Entity.setHeight(newHeight : integer) : boolean; begin
                       height := newHeight;
                       setHeight := true;
              end;
              function Entity.getHeight() : integer; begin
                       getHeight := height;
              end;

              function Entity.setDimensions(newWidth, newHeight : integer) : boolean; begin
                       Entity.setWidth(newWidth);
                       Entity.setHeight(newHeight);

                       setDimensions := true;
              end;

              function Entity.setSpeed(newSpeed : integer) : boolean; begin
                       speed := newSpeed;
                       setSpeed := true;
              end;
              function Entity.getSpeed() : integer; begin
                       getSpeed := speed;
              end;

              procedure clear();
              var x, y : integer;
              begin
              {for x := Entity.getX() to maxX-1 do begin
              for y := minY to maxY-1 do begin
              PutPixel(x, y, black);
              end;
              end;}
              end;

              function Enemy.setID(newID : integer) : boolean; begin
                       ID := newId;
                       setID := true;
              end;
              function Enemy.getID() : integer; begin
                       getID := ID;
              end;

              function Enemy.setListNext(newListNext : EnemyPointer) : boolean; begin
                       listNext := newListNext;
                       setListnext := true;
              end;
              function Enemy.getListNext() : EnemyPointer; begin
                       getListNext := listNext;
              end;

              function Enemy.setListPrevious(newListPrevious : EnemyPointer) : boolean; begin
                       listPrevious := newListPrevious;
              end;
              function Enemy.getListPrevious() : EnemyPointer; begin
                       getListPrevious := listPrevious;
              end;

end.

