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

with Ada.Real_Time; use Ada.Real_Time;
with Draw;          use Draw;

--  TODO: Remove once Cos and Sin are used
pragma Warnings (Off,
    "no entities of ""Float_Maths"" are referenced");
pragma Warnings (Off,
    "use clause for package ""Float_Maths"" has no effect");
with Float_Maths;   use Float_Maths;

procedure Record_Types_Main is

   --  TODO: Remove once lab is done
   pragma Warnings (Off,
      "not referenced");
   pragma Warnings (Off,
      "never read and never assigned");
   pragma Warnings (Off, "assigned but never read");

   --  define type Bodies_Enum_T as an enumeration of Sun, Earth, Moon,
   --  and Satellite
   type Bodies_Enum_T is (Sun, Earth, Moon, Satellite);

   --  define subtype Rotating_Bodies_T which only contains bodies
   --  that rotate
   subtype Rotating_Bodies_T is Bodies_Enum_T
     range Earth .. Bodies_Enum_T'Last;

   --  QUESTION 1: replace the definition of Body_T by a type that stores
   --  body attributes
   --   X, Y, Distance, Speed, Angle, Color type is Color_T, Radius
   subtype Body_T is Integer; -- TODO: Replace by record type

   --  define type Bodies_Array_T as an array of Body_T indexed by bodies
   type Bodies_Array_T is array (Bodies_Enum_T) of Body_T;

   --  declare variable Bodies which is an array of Body_T
   Bodies : Bodies_Array_T;

   --  declare a variable Next of type Time to store the Next step time
   Next : Time;

   --  declare a constant Period of 40 milliseconds of type Time_Span defining
   --  the loop period
   Period  : constant Time_Span := Milliseconds (40);

begin

   Create_Window (Width  => 240,
                            Height => 320,
                            Name   => "Solar System");

   --  QUESTION 2
   --  initialize Bodies variable with parameters for each body using an
   --  aggregate
   --    Sun Distance = 0.0, Angle = 0.0, Speed = 0.0, Radius = 20.0,
   --       Color = Yellow
   --    Earth Distance = 50.0, Angle = 0.0, Speed = 0.02, Radius = 5.0,
   --       Color = Blue
   --    Moon Distance = 15.0, Angle = 0.0, Speed = 0.04, Radius = 2.0,
   --       Color = White
   --    Satellite Distance = 8.0, Angle = 0.0, Speed = 0.1, Radius = 1.0,
   --       Color = Red

   --  initialize the Next step time at current time (Clock) + the period
   Next := Clock + Period;

   while Running loop

      --  create a loop to update each body position and angles
      --    the position of an object around (0,0) at distance d with an angle
      --    a is (d*cos(a), d*sin(a))
      --  update angle parameter of each body adding speed to the previous
      --  angle

      --  create a loop to draw every objects
      --  use the Draw_Sphere procedure to do it
      --  QUESTION 4: Once finished -> implement black holes
      --  as discriminated records without radius or color.

      --  update the screen
      New_Frame;

      --  wait until Next
      delay until Next;

      --  update the Next time adding the period for the next step
      Next := Next + Period;

   end loop;
end Record_Types_Main;
