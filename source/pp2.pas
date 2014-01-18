program pp2;

{$mode objfpc}{$H+}
{$UNITPATH ./units}

uses pp2Memory, pp2Graph, pp2Application;

var
Application : ApplicationPointer;
ApplicationConfiguration : ApplicationConfigurationPointer;

Board : BoardPointer;
Player : PlayerPointer;

Enemy : EnemyPointer;

begin
     ApplicationConfiguration := new (ApplicationConfigurationPointer, initialize);
     Application := new (ApplicationPointer, initialize(ApplicationConfiguration));

     Board := new (BoardPointer, initialize(ApplicationConfiguration));
     Player := new (PlayerPointer, initialize(ApplicationConfiguration));
     Board^.setPlayer(Player, Board);

     Player^.randomizePosition();
     Player^.draw();

     Enemy := new (EnemyPointer, initialize(ApplicationConfiguration));
     Board^.setEnemy(Enemy, Board);
     Enemy^.randomizePosition();
     Enemy^.draw();

     repeat
           if (Application^.isKeyPressed()) then begin
              if (Application^.isUpKeyPressed()) then begin
                 Player^.moveUp();
              end else if (Application^.isDownKeyPressed()) then begin
                 Player^.moveDown();
              end else if (Application^.isRightKeyPressed()) then begin
                 Player^.moveRight();
              end else if (Application^.isLeftKeyPressed()) then begin
                 Player^.moveLeft();
              end;
           end;

           Enemy^.move();
           Player^.checkForCollision(Enemy);

     until (Application^.isCloseKeyPressed());

     Application^.close();
end.

