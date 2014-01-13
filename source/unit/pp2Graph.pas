unit pp2Graph;

{$mode objfpc}{$H+}

interface
         type
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

                   procedure clear();
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

