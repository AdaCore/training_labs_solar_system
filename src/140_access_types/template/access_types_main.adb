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
--$ line answer
with My_Solar_System;       use My_Solar_System;
with Solar_System;          use Solar_System;
with Solar_System.Graphics; use Solar_System.Graphics;

procedure Access_Types_Main is

   --$ begin question
   --  declare variable Bodies which is an array of Body_T
   Bodies : Bodies_Array_T;

   --$ end question
   --  declare a variable Next of type Time to store the Next step time
   Next : Time;

   --  declare a constant Period of 40 milliseconds of type Time_Span defining
   --  the loop period
   Period  : constant Time_Span := Milliseconds (40);

begin

   Create_Window (Width  => 240,
                  Height => 320,
                  Name   => "Solar System");

   --  initialize Bodies using Init_Body procedure
   Init_Body
   --$ begin question
             (B            => Sun,
              Bodies       => Bodies,
   --$ end question
   --$ begin answer
             (B            => Get_Body (Sun, Bodies'Access),
   --$ end answer
              Radius       => 20.0,
              Color        => Yellow,
              Distance     => 0.0,
              Angle        => 0.0,
              Speed        => 0.0,
   --$ line question
              Turns_Around => Sun);
   --$ line answer
              Turns_Around => Get_Body (Sun, Bodies'Access));

   Init_Body
   --$ begin question
             (B            => Earth,
              Bodies       => Bodies,
   --$ end question
   --$ begin answer
             (B            => Get_Body (Earth, Bodies'Access),
   --$ end answer
              Radius       => 5.0,
              Color        => Blue,
              Distance     => 50.0,
              Angle        => 0.0,
              Speed        => 0.02,
   --$ line question
              Turns_Around => Sun);
   --$ line answer
              Turns_Around => Get_Body (Sun, Bodies'Access));

   Init_Body
   --$ begin question
             (B            => Moon,
              Bodies       => Bodies,
   --$ end question
   --$ begin answer
             (B            => Get_Body (Moon, Bodies'Access),
   --$ end answer
              Radius       => 2.0,
              Color        => White,
              Distance     => 15.0,
              Angle        => 0.0,
              Speed        => 0.04,
   --$ line question
              Turns_Around => Earth);
   --$ line answer
              Turns_Around => Get_Body (Earth, Bodies'Access));

   Init_Body
   --$ begin question
             (B            => Satellite,
              Bodies       => Bodies,
   --$ end question
   --$ begin answer
             (B            => Get_Body (Satellite, Bodies'Access),
   --$ end answer
              Radius       => 1.0,
              Color        => Red,
              Distance     => 8.0,
              Angle        => 0.0,
              Speed        => 0.1,
   --$ line question
              Turns_Around => Earth);
   --$ line answer
              Turns_Around => Get_Body (Earth, Bodies'Access));

   Init_Body
   --$ begin question
             (B            => Comet,
              Bodies       => Bodies,
   --$ end question
   --$ begin answer
             (B            => Get_Body (Comet, Bodies'Access),
   --$ end answer
              Radius       => 1.0,
              Color        => Yellow,
              Distance     => 80.0,
              Angle        => 0.0,
              Speed        => 0.05,
   --$ line question
              Turns_Around => Sun);
   --$ line answer
              Turns_Around => Get_Body (Sun, Bodies'Access));

   Init_Body
   --$ begin question
             (B            => Black_Hole,
              Bodies       => Bodies,
   --$ end question
   --$ begin answer
             (B            => Get_Body (Black_Hole, Bodies'Access),
   --$ end answer
              Radius       => 0.0,
              Color        => Blue,
              Distance     => 75.0,
              Angle        => 0.0,
              Speed        => -0.02,
   --$ line question
              Turns_Around => Sun,
   --$ line answer
              Turns_Around => Get_Body (Sun, Bodies'Access),
              Visible      => False);

   Init_Body
   --$ begin question
             (B            => Asteroid_1,
              Bodies       => Bodies,
   --$ end question
   --$ begin answer
             (B            => Get_Body (Asteroid_1, Bodies'Access),
   --$ end answer
              Radius       => 1.0,
              Color        => Green,
              Distance     => 5.0,
              Angle        => 0.0,
              Speed        => 0.1,
   --$ line question
              Turns_Around => Black_Hole);
   --$ line answer
              Turns_Around => Get_Body (Black_Hole, Bodies'Access));

   Init_Body
   --$ begin question
             (B            => Asteroid_2,
              Bodies       => Bodies,
   --$ end question
   --$ begin answer
             (B            => Get_Body (Asteroid_2, Bodies'Access),
   --$ end answer
              Radius       => 1.0,
              Color        => Yellow,
              Distance     => 5.0,
              Angle        => 3.14,
              Speed        => 0.1,
   --$ line question
              Turns_Around => Black_Hole);
   --$ line answer
              Turns_Around => Get_Body (Black_Hole, Bodies'Access));

   --  initialize the Next step time at the current time (Clock) + period
   Next := Clock + Period;

   --  create an infinite loop

   --  update the Next time
   while Running loop

      --$ line question
      Move_All (Bodies);
      --$ line answer
      Move_All (Bodies'Access);
      Draw_All (Bodies);
      New_Frame;

      delay until Next;
      Next := Next + Period;
   end loop;

end Access_Types_Main;
