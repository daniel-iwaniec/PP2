program pp2;

{$mode objfpc}{$H+}
{$UNITPATH ./units}

uses classes, sysUtils, crt, graph, pp2Memory, pp2Graph, pp2Application;

var
Application : ApplicationPointer;

Board : BoardPointer;
boardPadding : smallint = 100;
boardBorderWidth : smallint = 2;
minX, minY, maxX, maxY : integer;

Player : PlayerPointer;


{---------DO REFAKTORYZACJI----------------------------}
playerSize : smallint = 10;
playerSpeed  :smallint = 5;

x : integer;
y : integer;

EnemyCount : integer = 5;
EnemyX : integer;
EnemyY : integer;
EnemySize : integer = 5;
counter : integer;

procedure clear(minX,minY,maxX,maxY : integer);
var x, y : integer;
begin
  for x := minX to maxX-1 do begin
    for y := minY to maxY-1 do begin
      PutPixel(x, y, black);
    end;
  end;
end;
{-------------------------------------------------}

begin
     Application := new (ApplicationPointer, initialize);
     Board := new (BoardPointer);
     Player := new (PlayerPointer);

     maxX := GetMaxX() - boardPadding - 1;
     maxY := GetMaxY() - boardPadding;
     minX := 0 + boardPadding;
     minY := 0 + boardPadding;

     SetLineStyle(0, 0, 1);
     SetColor(white);
     Rectangle(minX,minY,maxX,maxY);

     randomize;
     x := random(maxX - minX) + minX;
     y := random(maxY - minY) + minY;

     setFillStyle(SolidFill, Red);
     for counter := 0 to EnemyCount do begin
      EnemyX := random(maxX - minX) + minX;
      EnemyY := random(maxY - minY) + minY;
      bar(EnemyX, EnemyY, EnemyX + EnemySize-1, EnemyY + EnemySize-1);
     end;

     setFillStyle(solidFill, LightBlue);
     bar(x, y, x + playerSize-1, y + playerSize-1);

     repeat
           if (Application^.isKeyPressed()) then begin
              if (Application^.getLastPressedKey() = #75) then begin
                  if (x >= (playerSpeed + minX + 1)) then begin
                     clear(x, y, x + playerSize, y + playerSize);
                     x := x - playerSpeed;
                     bar(x, y, x + playerSize-1, y + playerSize-1);
                  end else if (x > minX + 1) then begin
                     clear(x, y, x + playerSize, y + playerSize);
                     x := minX + 1;
                     bar(x, y, x + playerSize-1, y + playerSize-1);
                  end;
              end else if (Application^.getLastPressedKey() = #72) then begin
                  if (y >= (playerSpeed + minY + 1)) then begin
                     clear(x, y, x + playerSize, y + playerSize);
                     y := y - playerSpeed;
                     bar(x, y, x + playerSize-1, y + playerSize-1);
                  end else if (y > minY + 1) then begin
                     clear(x, y, x + playerSize, y + playerSize);
                     y := minY + 1;
                     bar(x, y, x + playerSize-1, y + playerSize-1);
                  end;
              end else if (Application^.getLastPressedKey() = #77) then begin
                  if ((maxX - x - playerSize) >= playerSpeed) then begin
                     clear(x, y, x + playerSize, y + playerSize);
                     x := x + playerSpeed;
                     bar(x, y, x + playerSize-1, y + playerSize-1);
                  end else if ((maxX - x - playerSize) > 0) then begin
                     clear(x, y, x + playerSize, y + playerSize);
                     x := x + (maxX - x - playerSize);
                     bar(x, y, x + playerSize-1, y + playerSize-1);
                  end;
              end else if (Application^.getLastPressedKey() = #80) then begin
                 if ((maxY - y - playerSize) >= playerSpeed) then begin
                     clear(x, y, x + playerSize, y + playerSize);
                     y := y + playerSpeed;
                     bar(x, y, x + playerSize-1, y + playerSize-1);
                  end else if ((maxY - y - playerSize) > 0) then begin
                     clear(x, y, x + playerSize, y + playerSize);
                     y := y + (maxY - y - playerSize);
                     bar(x, y, x + playerSize-1, y + playerSize-1);
                  end;
              end;
           end;

           {Place to generate enemies and interact with them?}

     until (Application^.getLastPressedKey() = #27);

     closeGraph;
end.

