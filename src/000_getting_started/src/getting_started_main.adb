-----------------------------------------------------------------------
--                              Ada Labs                             --
--                                                                   --
--                 Copyright (C) 2008-2023, AdaCore                  --
--                                                                   --
-- This program is free software: you can redistribute it and/or     --
-- modify it under the terms of the GNU General Public License as    --
-- published by the Free Software Foundation, either version 3 of    --
-- the License, or (at your option) any later version.               --
--                                                                   --
-- This program is distributed in the hope that it will be useful,   --
-- but WITHOUT ANY WARRANTY; without even the implied warranty of    --
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the     --
-- GNU General Public License for more details.                      --
--                                                                   --
-- You should have received a copy of the GNU General Public License --
-- along with this program.  If not, see                             --
-- <https://www.gnu.org/licenses/>.                                  --
-----------------------------------------------------------------------

with Mage;          use Mage;
with Mage.Draw;     use Mage.Draw;
with Mage.Event;    use Mage.Event;
with Ada.Real_Time; use Ada.Real_Time;

procedure Getting_Started_Main is
   Width       : constant := 240.0;
   Height      : constant := 320.0;
   Ball_Radius : constant := 20.0;

   X       : Float              := 0.0;
   Y       : Float              := 0.0;
   Speed_X : Float              := 2.0;
   Speed_Y : Float              := 4.0;
   Next    : Time;
   Period  : constant Time_Span := Milliseconds (40);

   --  reference to the application window
   Window : Window_ID;

   --  reference to the graphical canvas associated with the application window
   Canvas : Canvas_ID;

begin
   Window :=
     Create_Window
       (Width => Integer (Width), Height => Integer (Height),
        Name  => "Bouncing ball");
   Canvas := Get_Canvas (Window);

   Next := Clock + Period;

   while not Is_Killed loop

      if (abs X) + Ball_Radius >= Width / 2.0 then
         Speed_X := -Speed_X;
      end if;

      if (abs Y) + Ball_Radius >= Height / 2.0 then
         Speed_Y := -Speed_Y;
      end if;

      X := X + Speed_X;
      Y := Y + Speed_Y;

      Draw_Sphere
        (Canvas => Canvas, Position => (X, Y, 0.0), Radius => Ball_Radius,
         Color  => Red);

      Handle_Events (Window);

      delay until Next;
      Next := Next + Period;

   end loop;

end Getting_Started_Main;
