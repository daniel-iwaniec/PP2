unit pp2Unit;

{$mode objfpc}{$H+}

interface
         type
             PlayerPointer = ^Player;
             Player = object
                    private
                           ID : integer;
                           x, y : integer;
                           height, width : integer;
                           speed : integer;
                           next : PlayerPointer;
                           previous : PlayerPointer;
                    public
                          procedure setID(ID : integer);
                          procedure getID(ID : integer);
             end;

implementation
              uses classes, sysUtils, crt, graph;
              procedure Player.setSpeed(s : integer);
                        begin
                             speed := s;
                        end;
end.

