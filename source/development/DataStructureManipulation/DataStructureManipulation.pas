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

function Get_worm(var EnemyListMeta : ListMeta; EnemyID:integer):Wsk;
var Q:Wsk;
begin
     Q := NIL;
     repeat
          if (Q = NIL) then Q := EnemyListMeta.head else Q := Q^.next;
          if (Q = NIL) then break;
     until (Q^.data = EnemyID);

     Get_worm := Q;
end;

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

procedure remove_worm(var EnemyListMeta : ListMeta; wormID : integer = 0);
var Q:Wsk;
begin
    if EnemyListMeta.count > 0  then begin
        EnemyListMeta.count := EnemyListMeta.count - 1;

        if (wormID = 0) then begin
            Q := EnemyListMeta.tail;

            if Q^.previous <> nil then Q^.previous^.next := Q^.next
            else EnemyListMeta.head := Q^.next;

            if Q^.next <> nil then Q^.next^.previous := Q^.previous
            else EnemyListMeta.tail := Q^.previous;
        end else begin
            Q := Get_worm(EnemyListMeta, wormID);
            if (Q <> NIL) then begin
                if (Q^.previous <> NIL) then begin
                    Q^.previous^.next := Q^.next;
                end;

                if (Q^.next <> NIL) then begin
                    Q^.next^.previous := Q^.previous;
                end;
            end;
        end;

        if (Q <> NIL) then dispose(Q);
    end;
end;

begin
EnemyListMeta.head := NIl;
EnemyListMeta.tail := NIL;
EnemyListMeta.count := 0;

New_worm(EnemyListMeta);
New_worm(EnemyListMeta);
New_worm(EnemyListMeta);
New_worm(EnemyListMeta);

EnemyListMeta.head^.data := 24;
EnemyListMeta.head^.next^.data := 7;

writeln(EnemyListMeta.count); {4}
writeln(EnemyListMeta.head^.data); {24}

remove_worm(EnemyListMeta, 24);

writeln(EnemyListMeta.count); {3}
writeln(EnemyListMeta.head^.data); {24}

ReadKey;
end.
