program pp2;

{$mode objfpc}{$H+}
{$UNITPATH ./units}

uses classes, sysUtils, crt, graph, pp2Memory, pp2Graph, pp2Application;

var
Application : ApplicationPointer;
ApplicationConfiguration : ApplicationConfigurationPointer;

Board : BoardPointer;
Player : PlayerPointer;

{EnemyPointer}
{
 W konfiguracji ustawic size, speed, ilosc, czestotliwosc
 losowac polozenie
 rysowac

 potem musze sie rusza
 potem wykrywanie kolizji
 potem event na kolizje i obsluga eventu (zwlaszcza w pamieci)
}

begin
     ApplicationConfiguration := new (ApplicationConfigurationPointer, initialize);
     Application := new (ApplicationPointer, initialize(ApplicationConfiguration));

     Board := new (BoardPointer, initialize(ApplicationConfiguration));
     {przeypisanie do board playera}

     Player := new (PlayerPointer, initialize(ApplicationConfiguration));
     {metoda set random position}
     Player^.setX(random(Board^.getMaxX() - Board^.getMinX() - Player^.getSize()) + Board^.getMinX());
     Player^.setY(random(Board^.getMaxY() - Board^.getMinY() - Player^.getSize()) + Board^.getMinY());
     Player^.draw();

     repeat
           if (Application^.isKeyPressed()) then begin
              if (Application^.getLastPressedKey() = #75) then begin
                 {wrzucic to wszystko do moveLeft}
                  if (Player^.getX() >= (Player^.getSpeed() + Board^.getMinX())) then begin
                     Player^.moveLeft();
                  end else if (Player^.getX() > Board^.getMinX()) then begin
                     Player^.clear();
                     Player^.setX(Board^.getMinX());
                     Player^.draw();
                  end;
                  {/}
              end else if (Application^.getLastPressedKey() = #72) then begin
                  {wrzucic to wszystko do moveUp}
                  if (Player^.getY() >= (Player^.getSpeed() + Board^.getMinY())) then begin
                     Player^.moveUp();
                  end else if (Player^.getY() > Board^.getMinY()) then begin
                     Player^.clear();
                     Player^.setY(Board^.getMinX());
                     Player^.draw();
                  end;
                  {/}
              end else if (Application^.getLastPressedKey() = #77) then begin
                  {wrzucic to wszystko do moveRight}
                  if ((Board^.getMaxX() - Player^.getX() - Player^.getSize() + 1) >= Player^.getSpeed()) then begin
                     Player^.moveRight();
                  end else if ((Board^.getMaxX() - Player^.getX() - Player^.getSize() + 1) > 0) then begin
                     Player^.clear();
                     Player^.setX(Board^.getMaxX() - Player^.getSize() + 1);
                     Player^.draw();
                  end;
                  {/}
              end else if (Application^.getLastPressedKey() = #80) then begin
                 {wrzucic to wszystko do moveLeft}
                 if ((Board^.getMaxY() - Player^.getY() - Player^.getSize() + 1) >= Player^.getSpeed()) then begin
                     Player^.moveDown();
                  end else if ((Board^.getMaxY() - Player^.getY() - Player^.getSize() + 1) > 0) then begin
                     Player^.clear();
                     Player^.setY(Board^.getMaxY() - Player^.getSize() + 1);
                     Player^.draw();
                  end;
                  {/}
              end;
           end;

     until (Application^.getLastPressedKey() = #27);

     Application^.close();
end.

