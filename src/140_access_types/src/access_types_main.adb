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

with Mage;                  use Mage;
with Mage.Draw;             use Mage.Draw;
with Mage.Event;            use Mage.Event;
with Solar_System;          use Solar_System;
with Solar_System.Graphics; use Solar_System.Graphics;

procedure Access_Types_Main is

   --  declare variable Bodies which is an array of Body_T
   Bodies : Bodies_Array_T;

   --  declare a variable Next of type Time to store the Next step time
   Next : Time;

   --  declare a constant Period of 40 milliseconds of type Time_Span defining
   --  the loop period
   Period  : constant Time_Span := Milliseconds (40);

   --  reference to the application window
   Window : Window_ID;

   --  reference to the graphical canvas associated with the application window
   Canvas : Canvas_ID;

begin

   --  Create the main window
   Window := Create_Window (Width  => 240,
                            Height => 320,
                            Name   => "Solar System");
   --  retrieve the graphical canvas associated with the main window
   Canvas := Get_Canvas (Window);

   --  initialize Bodies using Init_Body procedure
   Init_Body
             (B            => Sun,
              Bodies       => Bodies,
              Radius       => 20.0,
              Color        => Yellow,
              Distance     => 0.0,
              Angle        => 0.0,
              Speed        => 0.0,
              Turns_Around => Sun);

   Init_Body
             (B            => Earth,
              Bodies       => Bodies,
              Radius       => 5.0,
              Color        => Blue,
              Distance     => 50.0,
              Angle        => 0.0,
              Speed        => 0.02,
              Turns_Around => Sun);

   Init_Body
             (B            => Moon,
              Bodies       => Bodies,
              Radius       => 2.0,
              Color        => White,
              Distance     => 15.0,
              Angle        => 0.0,
              Speed        => 0.04,
              Turns_Around => Earth);

   Init_Body
             (B            => Satellite,
              Bodies       => Bodies,
              Radius       => 1.0,
              Color        => Red,
              Distance     => 8.0,
              Angle        => 0.0,
              Speed        => 0.1,
              Turns_Around => Earth);

   Init_Body
             (B            => Comet,
              Bodies       => Bodies,
              Radius       => 1.0,
              Color        => Yellow,
              Distance     => 80.0,
              Angle        => 0.0,
              Speed        => 0.05,
              Turns_Around => Sun);

   Init_Body
             (B            => Black_Hole,
              Bodies       => Bodies,
              Radius       => 0.0,
              Color        => Blue,
              Distance     => 75.0,
              Angle        => 0.0,
              Speed        => -0.02,
              Turns_Around => Sun,
              Visible      => False);

   Init_Body
             (B            => Asteroid_1,
              Bodies       => Bodies,
              Radius       => 1.0,
              Color        => Green,
              Distance     => 5.0,
              Angle        => 0.0,
              Speed        => 0.1,
              Turns_Around => Black_Hole);

   Init_Body
             (B            => Asteroid_2,
              Bodies       => Bodies,
              Radius       => 1.0,
              Color        => Yellow,
              Distance     => 5.0,
              Angle        => 3.14,
              Speed        => 0.1,
              Turns_Around => Black_Hole);

   --  initialize the Next step time at the current time (Clock) + period
   Next := Clock + Period;

   --  create an infinite loop
   --  call Move_All procedure
   --  call Draw_All procedure
   --  call Swap_Buffers to update the screen
   --  wait until Next time
   --  update the Next time
   while not Is_Killed loop

      Move_All (Bodies);
      Draw_All (Bodies, Canvas);
      Handle_Events (Window);

      delay until Next;
      Next := Next + Period;
   end loop;

end Access_Types_Main;
