-----------------------------------------------------------------------
--                              Ada Labs                             --
--                                                                   --
--                 Copyright (C) 2008-2024, AdaCore                  --
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
with Draw;             use Draw;
with Solar_System;          use Solar_System;
with Solar_System.Graphics; use Solar_System.Graphics;

procedure Subprogram_Contracts_Main is

   Bodies : Bodies_Array_T;

   Next : Time;

   Period : constant Time_Span := Milliseconds (40);

begin

   Create_Window (Width => 240, Height => 320, Name => "Solar System");

   --  initialize Bodies using Init_Body procedure
   --$ begin question
   Init_Body
     (B        => Sun, Bodies => Bodies, Radius => 20.0, Color => Yellow,
      --$ line question
      Distance => 0.0, Angle => 0.0, Speed => 100.0, Turns_Around => Sun);
   --$ end question
   --$ begin answer
   Init_Still_Body
     (B => Sun, Bodies => Bodies, Radius => 20.0, Color => Yellow);
   --$ end answer

   --$ line question
   Init_Body
   --$ line answer
   Init_Orbiting_Body
     (B        => Earth, Bodies => Bodies, Radius => 5.0, Color => Blue,
      Distance => 50.0, Angle => 0.0, Speed => 0.02, Turns_Around => Sun);

   --$ line question
   Init_Body
   --$ line answer
   Init_Orbiting_Body
     (B        => Moon, Bodies => Bodies, Radius => 2.0, Color => White,
      Distance => 15.0, Angle => 0.0, Speed => 0.04, Turns_Around => Earth);

   --$ line question
   Init_Body
   --$ line answer
   Init_Orbiting_Body
     (B        => Satellite, Bodies => Bodies, Radius => 1.0, Color => Red,
   --$ line question
      Distance => 8.0, Angle => 0.0, Speed => 0.0, Turns_Around => Earth);
   --$ line answer
      Distance => 8.0, Angle => 0.0, Speed => 0.1, Turns_Around => Earth);

   --$ line question
   Init_Body
   --$ line answer
   Init_Orbiting_Body
     (B        => Comet, Bodies => Bodies, Radius => 1.0, Color => Yellow,
      Distance => 80.0, Angle => 0.0, Speed => 0.05, Turns_Around => Sun);

   --$ begin question
   Init_Body
     (B        => Black_Hole, Bodies => Bodies, Radius => 0.0,
      Color => Blue, Distance => 75.0,
      Angle => 0.0, Speed => -0.02, Turns_Around => Asteroid_2,
      Visible => False);
   --$ end question
   --$ begin answer
   Init_Invisible_Body
     (B => Black_Hole, Bodies => Bodies, Distance => 75.0,
      Angle => 0.0, Speed => -0.02, Turns_Around => Sun);
   --$ end answer

   --$ line question
   Init_Body
   --$ line answer
   Init_Orbiting_Body
     (B        => Asteroid_1, Bodies => Bodies, Radius => 1.0, Color => Green,
      Distance => 5.0, Angle => 0.0, Speed => 0.1, Turns_Around => Black_Hole);

   --$ line question
   Init_Body
   --$ line answer
   Init_Orbiting_Body
     (B => Asteroid_2, Bodies => Bodies, Radius => 1.0, Color => Yellow,
      Distance     => 5.0, Angle => 3.14, Speed => 0.1,
      Turns_Around => Asteroid_1);

   --  check that there is no cycle in the orbits
   pragma Assert (Solar_System.Init_With_No_Cycle (Bodies));

   Next := Clock + Period;

   while Running loop
      Move_All (Bodies);
      Draw_All (Bodies);
      New_Frame;

      delay until Next;
      Next := Next + Period;
   end loop;

end Subprogram_Contracts_Main;
