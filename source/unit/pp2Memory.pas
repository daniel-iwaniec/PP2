unit pp2Memory;

{$mode objfpc}{$H+}

interface
         type
             ListEntityPointer = ^ListEntity;

             List = object
                 private
                        listHead: ListEntityPointer;
                        listTail: ListEntityPointer;
                        listCount: integer;
                 public
                        j:integer;
                        {meotdy do wlasciwosci}
             end;

             ListEntity = object
                 private
                        ID: integer;
                        previousListEntity: ListEntityPointer;
                        nextListEntity: ListEntityPointer;
                 public
                        i:integer;
                        {metody do wlasciwosci}
             end;

implementation
              uses classes, sysUtils, crt, graph;



end.

