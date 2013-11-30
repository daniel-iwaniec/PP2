program pp2;

{$mode objfpc}{$H+}

uses classes, sysutils, crt, graph;

var
card:smallint = 0;
mode:smallint = 0;

x:integer = 320;
y:integer = 240;

playerSize:smallint = 5;
playerSpeed:smallint = 5;

button:char;

begin
     initGraph(card, mode, '');
     setFillStyle(solidFill, brown);

     repeat
           if (keyPressed) then begin
              button := readKey;
              case button of
                   #75: x := x - playerSpeed;
                   #72: y := y - playerSpeed;
                   #77: x := x + playerSpeed;
                   #80: y := y + playerSpeed;
              end;
           end;
           clearDevice;

           bar(x - playerSize, y - playerSize, x, y);

           {Place to generate enemies and interact with them}
     until (button = #27);

     closeGraph;
end.

