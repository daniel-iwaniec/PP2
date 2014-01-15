program pp2;

{$mode objfpc}{$H+}
{$UNITPATH ./units}

uses classes, sysUtils, crt, graph, pp2Memory, pp2Graph, pp2Application;

var
Application : ApplicationPointer;
ApplicationConfiguration : ApplicationConfigurationPointer;

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
     ApplicationConfiguration := new (ApplicationConfigurationPointer, initialize);
     Application := new (ApplicationPointer, initialize(ApplicationConfiguration));
     Board := new (BoardPointer, initialize(ApplicationConfiguration));

     Player := new (PlayerPointer);

     randomize;
     setFillStyle(SolidFill, Red);
     for counter := 0 to EnemyCount do begin
      EnemyX := random(Board^.getMaxX() - Board^.getMinX()) + Board^.getMinX();
      EnemyY := random(Board^.getMaxY() - Board^.getMinY()) + Board^.getMinY();
      bar(EnemyX, EnemyY, EnemyX + EnemySize-1, EnemyY + EnemySize-1); {-1 tylko dla size wiekszych od 1}
     end;

     setFillStyle(solidFill, LightBlue);
     x := random(Board^.getMaxX() - Board^.getMinX()) + Board^.getMinX();
     y := random(Board^.getMaxY() - Board^.getMinY()) + Board^.getMinY();
     bar(x, y, x + playerSize-1, y + playerSize-1); {-1 tylko dla size wiekszych od 1}

     repeat
           if (Application^.isKeyPressed()) then begin
              if (Application^.getLastPressedKey() = #75) then begin
                  if (x >= (playerSpeed + Board^.getMinX())) then begin
                     clear(x, y, x + playerSize, y + playerSize);
                     x := x - playerSpeed;
                     bar(x, y, x + playerSize-1, y + playerSize-1);    {-1 tylko dla size wiekszych od 1}
                  end else if (x > Board^.getMinX()) then begin
                     clear(x, y, x + playerSize, y + playerSize);
                     x := Board^.getMinX();
                     bar(x, y, x + playerSize-1, y + playerSize-1);    {-1 tylko dla size wiekszych od 1}
                  end;
              end else if (Application^.getLastPressedKey() = #72) then begin
                  if (y >= (playerSpeed + Board^.getMinY())) then begin
                     clear(x, y, x + playerSize, y + playerSize);
                     y := y - playerSpeed;
                     bar(x, y, x + playerSize-1, y + playerSize-1);   {-1 tylko dla size wiekszych od 1}
                  end else if (y > Board^.getMinY()) then begin
                     clear(x, y, x + playerSize, y + playerSize);
                     y := Board^.getMinY();
                     bar(x, y, x + playerSize-1, y + playerSize-1);  {-1 tylko dla size wiekszych od 1}
                  end;
              end else if (Application^.getLastPressedKey() = #77) then begin
                  if ((Board^.getMaxX() - x - playerSize + 1) >= playerSpeed) then begin
                     clear(x, y, x + playerSize, y + playerSize);
                     x := x + playerSpeed;
                     bar(x, y, x + playerSize-1, y + playerSize-1);    {-1 tylko dla size wiekszych od 1}
                  end else if ((Board^.getMaxX() - x - playerSize + 1) > 0) then begin
                     clear(x, y, x + playerSize, y + playerSize);
                     x := Board^.getMaxX() - playerSize + 1;
                     bar(x, y, x + playerSize-1, y + playerSize-1);     {-1 tylko dla size wiekszych od 1}
                  end;
              end else if (Application^.getLastPressedKey() = #80) then begin
                 if ((Board^.getMaxY() - y - playerSize + 1) >= playerSpeed) then begin
                     clear(x, y, x + playerSize, y + playerSize);
                     y := y + playerSpeed;
                     bar(x, y, x + playerSize-1, y + playerSize-1);       {-1 tylko dla size wiekszych od 1}
                  end else if ((Board^.getMaxY() - y - playerSize + 1) > 0) then begin
                     clear(x, y, x + playerSize, y + playerSize);
                     y := Board^.getMaxY() - playerSize + 1;
                     bar(x, y, x + playerSize-1, y + playerSize-1);   {-1 tylko dla size wiekszych od 1}
                  end;
              end;
           end;

           {Place to generate enemies and interact with them?}

     until (Application^.getLastPressedKey() = #27);

     closeGraph;
end.

