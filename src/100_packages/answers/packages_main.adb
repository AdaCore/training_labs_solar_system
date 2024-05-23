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

with Ada.Real_Time; use Ada.Real_Time;
with Mage;          use Mage;
with Mage.Draw;     use Mage.Draw;
with Mage.Event;    use Mage.Event;
with Solar_System;          use Solar_System;
with Solar_System.Graphics; use Solar_System.Graphics;

procedure Packages_Main is

   Bodies : Bodies_Array_T;

   Next : Time;

   Period : constant Time_Span := Milliseconds (40);

   --  reference to the application window
   Window : Window_ID;

   --  reference to the graphical canvas associated with the application window
   Canvas : Canvas_ID;

begin

   --  Create the main window
   Window :=
     Create_Window (Width => 240, Height => 320, Name => "Solar System");
   --  retrieve the graphical canvas associated with the main window
   Canvas := Get_Canvas (Window);

   --  initialize Bodies variable with parameters for each body using an
   --  aggregate
   Bodies :=
     (Sun =>
        (Distance     => 0.0,
         Speed        => 0.0,
         Radius       => 20.0,
         X            => 0.0,
         Y            => 0.0,
         Visible      => True,
         Angle        => 0.0,
         Color        => Yellow,
         Turns_Around => Sun),
      Earth =>
        (Distance     => 50.0,
         Speed        => 0.02,
         Radius       => 5.0,
         X            => 0.0,
         Y            => 0.0,
         Visible      => True,
         Angle        => 0.0,
         Color        => Blue,
         Turns_Around => Sun),
      Moon =>
        (Distance     => 15.0,
         Speed        => 0.04,
         Radius       => 2.0,
         X            => 0.0,
         Y            => 0.0,
         Visible      => True,
         Angle        => 0.0,
         Color        => White,
         Turns_Around => Earth),
      Satellite =>
        (Distance     => 8.0,
         Speed        => 0.1,
         Radius       => 1.0,
         X            => 0.0,
         Y            => 0.0,
         Visible      => True,
         Angle        => 0.0,
         Color        => Red,
         Turns_Around => Earth),
      Comet =>
        (Distance     => 80.0,
         Angle        => 0.0,
         Speed        => 0.05,
         Radius       => 1.0,
         X            => 0.0,
         Y            => 0.0,
         Visible      => True,
         Color        => Yellow,
         Turns_Around => Sun),
      Black_Hole =>
        (Distance     => 75.0,
         Angle        => 0.0,
         Speed        => 0.02,
         Turns_Around => Sun,
         Visible      => False,
         others       => <>),
      Asteroid_1 =>
        (Distance     => 5.0,
         Angle        => 0.0,
         Speed        => 0.1,
         Radius       => 1.0,
         Color        => Green,
         X            => 0.0,
         Y            => 0.0,
         Visible      => True,
         Turns_Around => Black_Hole),
      Asteroid_2 =>
        (Distance     => 5.0,
         Angle        => 3.14,
         Speed        => 0.1,
         Radius       => 1.0,
         Color        => Cyan,
         X            => 0.0,
         Y            => 0.0,
         Visible      => True,
         Turns_Around => Black_Hole));

   --  initialize the Next step time at the current time (Clock) + period
   Next := Clock + Period;

   while not Is_Killed loop

      Move_All (Bodies);
      --  QUESTION 2
      --  Implement Draw_All in a *new* package Graphics of Solar_System
      Draw_All (Bodies, Canvas);

      Handle_Events (Window);

      delay until Next;
      Next := Next + Period;
   end loop;

end Packages_Main;
