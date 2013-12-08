program DataStructureManipulation;

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

var EnemyListMeta : ListMeta;

procedure New_worm(var EnemyListMeta : ListMeta);
var Q:Wsk;
begin
New(Q);
Q^.data:= 6;
Q^.next := NIL;
Q^.previous := EnemyListMeta.tail
EnemyListMeta.tail := Q;

if (EnemyListMeta.head = NIL) then begin
    EnemyListMeta.head := Q;
end;

EnemyListMeta.count := EnemyListMeta.count + 1;
end;

procedure remove_worm(var EnemyListMeta : ListMeta);
var Q:Wsk;
begin

if (EnemyListMeta.count >0)  then
begin

EnemyListMeta.count := EnemyListMeta.count -1;
if Q^.previous <> nil then Q^.previous^.next := Q^.next
else EnemyListMeta.head := Q^.next;
if Q^.next <> nil then Q^.next^.previous := Q^.previous
else EnemyListMeta.tail := Q^.previous;
dispose(Q);
end;
end;

begin
EnemyListMeta.head := NIl;
EnemyListMeta.tail := NIL;
EnemyListMeta.count := 0;

New_worm(EnemyListMeta);
New_worm(EnemyListMeta);
New_worm(EnemyListMeta);

writeln(EnemyListMeta.count); {3}
writeln(EnemyListMeta.head^.data); {5}

remove_worm(EnemyListMeta);

writeln(EnemyListMeta.count); {2}
writeln(EnemyListMeta.head^.data); {5}

ReadKey;
end.
















