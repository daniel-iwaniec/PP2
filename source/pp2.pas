program pp2;

{$mode objfpc}{$H+}
{$UNITPATH ./units}

uses classes, sysUtils, crt, graph, pp2Memory, pp2Graph, pp2Application;

var
Application : ApplicationPointer;
Board : BoardPointer;
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
  for x := minX to maxX-1 do begin  {-1 tylko dla size wiekszych od 1}
    for y := minY to maxY-1 do begin   {-1 tylko dla size wiekszych od 1}
      PutPixel(x, y, black);
    end;
  end;
end;
{-------------------------------------------------}

begin
     Application := new (ApplicationPointer, initialize);
     Board := new (BoardPointer);

     Board^.setPadding(50);
     Borad^.setBorderWidth(4);
     Board^.calculateBoundaries();

     Player := new (PlayerPointer);

     randomize;
     setFillStyle(SolidFill, Red);
     for counter := 0 to EnemyCount do begin
      EnemyX := random(maxX - minX) + minX;
      EnemyY := random(maxY - minY) + minY;
      bar(EnemyX, EnemyY, EnemyX + EnemySize-1, EnemyY + EnemySize-1); {-1 tylko dla size wiekszych od 1}
     end;

     setFillStyle(solidFill, LightBlue);
     x := random(maxX - minX) + minX;
     y := random(maxY - minY) + minY;
     bar(x, y, x + playerSize-1, y + playerSize-1); {-1 tylko dla size wiekszych od 1}

     repeat
           if (Application^.isKeyPressed()) then begin
              if (Application^.getLastPressedKey() = #75) then begin
                  if (x >= (playerSpeed + minX)) then begin
                     clear(x, y, x + playerSize, y + playerSize);
                     x := x - playerSpeed;
                     bar(x, y, x + playerSize-1, y + playerSize-1);    {-1 tylko dla size wiekszych od 1}
                  end else if (x > minX) then begin
                     clear(x, y, x + playerSize, y + playerSize);
                     x := minX;
                     bar(x, y, x + playerSize-1, y + playerSize-1);    {-1 tylko dla size wiekszych od 1}
                  end;
              end else if (Application^.getLastPressedKey() = #72) then begin
                  if (y >= (playerSpeed + minY)) then begin
                     clear(x, y, x + playerSize, y + playerSize);
                     y := y - playerSpeed;
                     bar(x, y, x + playerSize-1, y + playerSize-1);   {-1 tylko dla size wiekszych od 1}
                  end else if (y > minY) then begin
                     clear(x, y, x + playerSize, y + playerSize);
                     y := minY;
                     bar(x, y, x + playerSize-1, y + playerSize-1);  {-1 tylko dla size wiekszych od 1}
                  end;
              end else if (Application^.getLastPressedKey() = #77) then begin
                  if ((maxX - x - playerSize + 1) >= playerSpeed) then begin
                     clear(x, y, x + playerSize, y + playerSize);
                     x := x + playerSpeed;
                     bar(x, y, x + playerSize-1, y + playerSize-1);    {-1 tylko dla size wiekszych od 1}
                  end else if ((maxX - x - playerSize + 1) > 0) then begin
                     clear(x, y, x + playerSize, y + playerSize);
                     x := maxX - playerSize + 1;
                     bar(x, y, x + playerSize-1, y + playerSize-1);     {-1 tylko dla size wiekszych od 1}
                  end;
              end else if (Application^.getLastPressedKey() = #80) then begin
                 if ((maxY - y - playerSize + 1) >= playerSpeed) then begin
                     clear(x, y, x + playerSize, y + playerSize);
                     y := y + playerSpeed;
                     bar(x, y, x + playerSize-1, y + playerSize-1);       {-1 tylko dla size wiekszych od 1}
                  end else if ((maxY - y - playerSize + 1) > 0) then begin
                     clear(x, y, x + playerSize, y + playerSize);
                     y := maxY - playerSize + 1;
                     bar(x, y, x + playerSize-1, y + playerSize-1);   {-1 tylko dla size wiekszych od 1}
                  end;
              end;
           end;

           {Place to generate enemies and interact with them?}

     until (Application^.getLastPressedKey() = #27);

     closeGraph;
end.

