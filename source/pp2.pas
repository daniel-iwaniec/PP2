program pp2;

{$mode objfpc}{$H+}

uses
  Classes,
  CRT,
  GRAPH;

Var
  ster, tryb:smallint;
  ch:char;
  x, y : integer;


begin
  ster := VGA;
  tryb := VGAHi;

  x := 320;
  y := 240;

  InitGraph(ster, tryb, '');
  Rectangle(x-5,y-5,x,y);

  Repeat
   ch := ReadKey;
   case ch of
     #75 : x := x-5;
     'H' : y := y-5;
     #77 : x := x+5;
     'P' : y := y+5;
   end;

   ClearDevice;
   Rectangle(x-5,y-5,x,y);

   Until ch = #27;

   CloseGraph;
end.

