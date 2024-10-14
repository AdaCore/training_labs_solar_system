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
with Draw;             use Draw;
with Solar_System;          use Solar_System;
with Solar_System.Graphics; use Solar_System.Graphics;

procedure Tasking_Protected_Objects_Main is
   --  declare a variable Now of type Time to record current time
   Now : Time;

   --  declare a constant Period of 40 milliseconds of type Time_Span defining
   --  the loop period
   Period : constant Time_Span := Milliseconds (40);

begin

   Create_Window (Width => 240, Height => 320, Name => "Solar System");

   --  initialize Bodies using Init_Body procedure
   Init_Body
     (B            => Sun,
      Radius       => 20.0,
      Color        => Yellow,
      Distance     => 0.0,
      Angle        => 0.0,
      Speed        => 0.0,
      Turns_Around => Sun);

   Init_Body
     (B            => Earth,
      Radius       => 5.0,
      Color        => Blue,
      Distance     => 50.0,
      Angle        => 0.0,
      Speed        => 0.02,
      Turns_Around => Sun);

   Init_Body
     (B            => Moon,
      Radius       => 2.0,
      Color        => Blue,
      Distance     => 15.0,
      Angle        => 0.0,
      Speed        => 0.04,
      Turns_Around => Earth);

   Init_Body
     (B            => Satellite,
      Radius       => 1.0,
      Color        => Red,
      Distance     => 8.0,
      Angle        => 0.0,
      Speed        => 0.1,
      Turns_Around => Earth);

   Init_Body
     (B            => Comet,
      Radius       => 1.0,
      Color        => Yellow,
      Distance     => 80.0,
      Angle        => 0.0,
      Speed        => 0.05,
      Turns_Around => Sun);

   Init_Body
     (B            => Black_Hole,
      Radius       => 0.0,
      Color        => Blue,
      Distance     => 75.0,
      Angle        => 0.0,
      Speed        => -0.02,
      Turns_Around => Sun,
      Visible      => False);

   Init_Body
     (B            => Asteroid_1,
      Radius       => 1.0,
      Color        => Green,
      Distance     => 5.0,
      Angle        => 0.0,
      Speed        => 0.1,
      Tail         => True,
      Turns_Around => Black_Hole);

   Init_Body
     (B            => Asteroid_2,
      Radius       => 1.0,
      Color        => Blue,
      Distance     => 5.0,
      Angle        => 3.14,
      Speed        => 0.1,
      Tail         => True,
      Turns_Around => Black_Hole);

   --  create an infinite loop
   --  update the Now time with current clock
   --  call Move_All procedure
   --  wait until Now + Period time elapsed before the next
   Now := Clock;
   while Running loop

      Draw_All;

      New_Frame;

      delay until Now + Period;
      Now := Now + Period;
   end loop;

   Terminate_Tasks;

end Tasking_Protected_Objects_Main;
