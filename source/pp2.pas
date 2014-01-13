program pp2;

{$mode objfpc}{$H+}
{$UNITPATH ./units}

uses classes, sysUtils, crt, graph, pp2Unit;

var
card : smallint = 0;
mode : smallint = 0;

x : integer;
y : integer;

playerSize : smallint = 10;
playerSpeed  :smallint = 5;

button : char;
boardPadding : integer = 100;
minX, minY, maxX, maxY : integer;

EnemyCount : integer = 5;
EnemyX : integer;
EnemyY : integer;
EnemySize : integer = 5;

counter : integer;

Player : PlayerPointer;

procedure clear(minX,minY,maxX,maxY : integer);
var x, y : integer;
begin
  for x := minX to maxX-1 do begin
    for y := minY to maxY-1 do begin
      PutPixel(x, y, black);
    end;
  end;
end;

begin
     Player := new (PlayerPointer);

     initGraph(card, mode, '');
     maxX := GetMaxX() - boardPadding;
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
     {clear(x, y, x + playerSize, y + playerSize);}

     repeat
           if (keyPressed) then begin
              button := readKey;
              if (button = #75) then begin
                  if (x >= (playerSpeed + minX + 1)) then begin
                     clear(x, y, x + playerSize, y + playerSize);
                     x := x - playerSpeed;
                     bar(x, y, x + playerSize-1, y + playerSize-1);
                  end else if (x > minX + 1) then begin
                     clear(x, y, x + playerSize, y + playerSize);
                     x := minX + 1;
                     bar(x, y, x + playerSize-1, y + playerSize-1);
                  end;
              end else if  (button = #72) then begin
                  if (y >= (playerSpeed + minY + 1)) then begin
                     clear(x, y, x + playerSize, y + playerSize);
                     y := y - playerSpeed;
                     bar(x, y, x + playerSize-1, y + playerSize-1);
                  end else if (y > minY + 1) then begin
                     clear(x, y, x + playerSize, y + playerSize);
                     y := minY + 1;
                     bar(x, y, x + playerSize-1, y + playerSize-1);
                  end;
              end else if  (button = #77) then begin
                  if ((maxX - x - playerSize) >= playerSpeed) then begin
                     clear(x, y, x + playerSize, y + playerSize);
                     x := x + playerSpeed;
                     bar(x, y, x + playerSize-1, y + playerSize-1);
                  end else if ((maxX - x - playerSize) > 0) then begin
                     clear(x, y, x + playerSize, y + playerSize);
                     x := x + (maxX - x - playerSize);
                     bar(x, y, x + playerSize-1, y + playerSize-1);
                  end;
              end else if  (button = #80) then begin
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
           {clearDevice;}




           {Place to generate enemies and interact with them}
     until (button = #27);

     closeGraph;
end.

