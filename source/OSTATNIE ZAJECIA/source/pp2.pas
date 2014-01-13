program pp2;

{$mode objfpc}{$H+}
{$UNITPATH ./units}

uses classes, sysUtils, crt, graph, pp2Unit;

var
card : smallint = 0;
mode : smallint = 0;

x : integer = 320;
y  :integer = 242;

playerSize : smallint = 10;
playerSpeed  :smallint = 10;

button : char;
boardPadding : integer = 100;
minX, minY, maxX, maxY : integer;

Player : PlayerPointer;

begin
     Player := new (PlayerPointer);

     initGraph(card, mode, '');
     maxX := GetMaxX() - boardPadding;
     maxY := GetMaxY() - boardPadding;
     minX := 0 + boardPadding;
     minY := 0 + boardPadding;

     SetLineStyle(0, 0, 1);
     SetColor(white);
     setFillStyle(solidFill, brown);

     repeat
           if (keyPressed) then begin
              button := readKey;
              if (button = #75) then begin
                  if (x >= (playerSpeed + minX + 1)) then begin
                     x := x - playerSpeed;
                  end else if (x > minX + 1) then begin
                     x := minX + 1;
                  end;
              end else if  (button = #72) then begin
                  if (y >= (playerSpeed + minY + 1)) then begin
                     y := y - playerSpeed;
                  end else if (y > minY + 1) then begin
                     y := minY + 1;
                  end;
              end else if  (button = #77) then begin
                  if ((maxX - x - playerSize - 1) >= playerSpeed) then begin
                     x := x + playerSpeed;
                  end else if ((maxX - x - playerSize) > 0) then begin
                     x := x + (maxX - x - playerSize) - 1;
                  end;
              end else if  (button = #80) then begin
                 if ((maxY - y - playerSize - 1) >= playerSpeed) then begin
                     y := y + playerSpeed;
                  end else if ((maxY - y - playerSize) > 0) then begin
                     y := y + (maxY - y - playerSize) - 1;
                  end;
              end;
           end;
           clearDevice;

           Rectangle(minX,minY,maxX,maxY);
           bar(x, y, x + playerSize, y + playerSize);

           {Place to generate enemies and interact with them}
     until (button = #27);

     closeGraph;
end.
