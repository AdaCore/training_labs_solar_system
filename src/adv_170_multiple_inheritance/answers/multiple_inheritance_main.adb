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

with Ada.Real_Time;         use Ada.Real_Time;
with Mage;                  use Mage;
with Mage.Draw;             use Mage.Draw;
with Mage.Event;            use Mage.Event;
with Solar_System;          use Solar_System;
with Solar_System.Graphics; use Solar_System.Graphics;

procedure Multiple_Inheritance_Main is

   S : constant access Visible_Solar_System_T :=
     Create_Visible (Create_Solar_System);

   Next : Time;

   Period : constant Time_Span := Milliseconds (40);

   Window : Window_ID;
   Canvas : Canvas_ID;

   Sun        : access Still_Body_I'Class;
   Black_Hole : access Orbiting_Body_I'Class;

begin

   --  create the main window
   Window :=
     Create_Window (Width => 240, Height => 320, Name => "Solar System");
   --  retrieve the graphical canvas associated with the main window
   Canvas := Get_Canvas (Window);

   Sun := Create_Visible (Create_Still (0.0, 0.0), 20.0, Yellow);

   S.Add_Still_Body (Sun);

   S.Add_Moving_Body
     (Create_Visible
        (B =>
           Create_Orbiting
             (Distance     => 50.0, Speed => 0.02, Angle => 0.0,
              Turns_Around => Sun),

         Radius => 5.0, Color => Blue));

   Black_Hole :=
     Create_Orbiting
       (Distance => 70.0, Speed => 0.01, Angle => 0.0, Turns_Around => Sun);
   S.Add_Moving_Body (Black_Hole);

   S.Add_Moving_Body
     (Create_Visible
        (B      =>
           Create_Orbiting
             (Distance     => 8.0, Speed => 0.1, Angle => 0.0,
              Turns_Around => Black_Hole),
         Radius => 1.0, Color => Red));

   S.Add_Moving_Body
     (Create_Visible
        (B      =>
           Create_Orbiting
             (Distance     => 12.0, Speed => -0.1, Angle => 0.0,
              Turns_Around => Black_Hole),
         Radius => 1.0, Color => Red));

   Next := Clock + Period;

   while not Is_Killed loop

      S.Move;
      S.Draw (Canvas);

      Handle_Events (Window);

      delay until Next;
      Next := Next + Period;
   end loop;

end Multiple_Inheritance_Main;
