program DataStructureRetrieving;

{$mode objfpc}{$H+}

uses Classes, crt;

type
    Wsk =^Element;
    Element = record
        data: integer;
        previous: Wsk;
        next: Wsk;
    end;

    ListMeta = record
        head: Wsk;
        tail: Wsk;
        count: integer;
    end;

var EnemyListMeta : ListMeta; Q: Wsk;
procedure New_worm(var EnemyListMeta : ListMeta);
var Q:Wsk;
begin
New(Q);
Q^.data:= 5;

Q^.next := NIL;
Q^.previous := EnemyListMeta.tail;

if (EnemyListMeta.tail <> NIL) then begin
    EnemyListMeta.tail^.next := Q;
end;

   EnemyListMeta.tail := Q;

if (EnemyListMeta.head = NIL) then begin
    EnemyListMeta.head := Q;
end;

EnemyListMeta.count := EnemyListMeta.count + 1;
end;


function Get_worm(var EnemyListMeta : ListMeta; EnemyID:integer):Wsk;
var Q:Wsk;

begin
Q := NIL;

     repeat
     begin
     if (Q = NIL) then Q := EnemyListMeta.head
     else Q := Q^.next;
     if (Q^.data = EnemyID) then break;
     end;

     until(Q <> NIL);

     Get_worm := Q;

end;

begin
EnemyListMeta.head := NIL;
EnemyListMeta.tail := NIL;
EnemyListMeta.count := 0;

New_worm(EnemyListMeta);
New_worm(EnemyListMeta);
New_worm(EnemyListMeta);

writeln(EnemyListMeta.count); {3}
writeln(EnemyListMeta.head^.data); {5}

EnemyListMeta.head^.data := 3;
EnemyListMeta.head^.next^.data := 7;



writeln;
writeln(EnemyListMeta.head^.data);
writeln(EnemyListMeta.head^.next^.data);
writeln(EnemyListMeta.head^.next^.next^.data);

writeln;

Q := Get_worm(EnemyListMeta, 7);

writeln(Q^.data);
writeln;
writeln(EnemyListMeta.head^.data);
writeln(EnemyListMeta.head^.next^.data);
writeln(EnemyListMeta.head^.next^.next^.data);

writeln;

ReadKey;
end.

