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

--  QUESTION 2 - Part 3: Remove these two lines once Cos and Sin are used
pragma Warnings (Off,
   "no entities of ""Float_Maths"" are referenced");
pragma Warnings (Off,
   "use clause for package ""Float_Maths"" has no effect");
with Float_Maths;   use Float_Maths;

procedure Array_Types_Main is
   --  QUESTION 1 - Part 1

   --  define type Bodies_Enum_T as an enumeration of Sun, Earth, Moon,
   --  and Satellite

   --  define type Parameters_Enum_T as an enumeration of parameter X, Y,
   --  Radius, Speed, Distance, Angle

   --  define type Bodies_Array_T as an array of float indexed by bodies and
   --  parameters

   --  define type Colors_Array_T as an array of color (Color_T) indexed by
   --  bodies

   --  declare variable Bodies which is an instance of Bodies_Array_T

   --  declare variable Colors which is an instance of Colors_Array_T

   --  refresh period
   Period  : constant Time_Span := Milliseconds (40);

   Next : Time;

begin
   Create_Window (Width  => 240,
                  Height => 320,
                  Name   => "Solar System");

   --  QUESTION 1 - Part 2
   --  initialize Bodies variable with parameters for each body using an
   --  aggregate:
   --    Sun Distance = 0.0, Angle = 0.0, Speed = 0.0, Radius = 20.0;
   --    Earth Distance = 50.0, Angle = 0.0, Speed = 0.02, Radius = 5.0;
   --    Moon Distance = 15.0, Angle = 0.0, Speed = 0.04, Radius = 2.0;
   --    Satellite Distance = 8.0, Angle = 0.0, Speed = 0.1, Radius = 1.0;

   --  QUESTION 1 - Part 3
   --  initialize Colors variable:
   --  Sun is Yellow, Earth is Blue, Moon is White, Satellite is Red

   --  next render time
   Next := Clock + Period;

   while Running loop

      --  QUESTION 2 - Part 1
      --  create a loop to update each body position and angles
      --  Note: the Sun does not orbit against any body, you may declare
      --  and use a subtype to reference the orbiting bodies
      --    - the position of an object around (0,0) at distance d with an
      --    angle a is (d*cos(a), d*sin(a))
      --    - update angle parameter of each body adding speed to the previous
      --    angle.

      --  loop to draw every objects

      --  QUESTION 2 - Part 2
      --  create a loop to draw every objects
      --    use the Draw_Sphere procedure with the Point_T argument

      --  update the screen
      New_Frame;

      delay until Next;

      --  update the Next time adding the period for the next step
      Next := Next + Period;
   end loop;

end Array_Types_Main;
