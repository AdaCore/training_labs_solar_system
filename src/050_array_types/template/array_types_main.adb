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
--$ begin question

--  QUESTION 2 - Part 3: Remove these two lines once Cos and Sin are used
pragma Warnings (Off,
   "no entities of ""Float_Maths"" are referenced");
pragma Warnings (Off,
   "use clause for package ""Float_Maths"" has no effect");
--$ end question
with Float_Maths;   use Float_Maths;

procedure Array_Types_Main is
   --  QUESTION 1 - Part 1

   --  define type Bodies_Enum_T as an enumeration of Sun, Earth, Moon,
   --  and Satellite
   --$ begin answer
   type Bodies_Enum_T is (Sun, Earth, Moon, Satellite);
   subtype Rotating_Bodies_T is Bodies_Enum_T
      range Earth .. Bodies_Enum_T'Last;
   --$ end answer

   --  define type Parameters_Enum_T as an enumeration of parameter X, Y,
   --  Radius, Speed, Distance, Angle
   --$ line answer
   type Parameters_Enum_T is (X, Y, Radius, Speed, Distance, Angle);

   --  define type Bodies_Array_T as an array of float indexed by bodies and
   --  parameters
   --$ line answer
   type Bodies_Array_T is array (Bodies_Enum_T, Parameters_Enum_T) of Float;

   --  define type Colors_Array_T as an array of color (Color_T) indexed by
   --  bodies
   --$ line answer
   type Colors_Array_T is array (Bodies_Enum_T) of Color_T;

   --  declare variable Bodies which is an instance of Bodies_Array_T
   --$ line answer
   Bodies : Bodies_Array_T;

   --  declare variable Colors which is an instance of Colors_Array_T
   --$ line answer
   Colors : Colors_Array_T;

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
   --$ begin answer
   Bodies := (Sun => (Distance => 0.0,
                      Speed => 0.0,
                      Radius => 20.0,
                      X => 0.0,
                      Y => 0.0,
                      Angle => 0.0),
              Earth => (Distance => 50.0,
                        Speed => 0.02,
                        Radius => 5.0,
                        X => 0.0,
                        Y => 0.0,
                        Angle => 0.0),
              Moon => (Distance => 15.0,
                       Speed => 0.04,
                       Radius => 2.0,
                       X => 0.0,
                       Y => 0.0,
                       Angle => 0.0),
              Satellite => (Distance => 8.0,
                            Speed => 0.1,
                            Radius => 1.0,
                            X => 0.0,
                            Y => 0.0,
                            Angle => 0.0));
   --$ end answer

   --  QUESTION 1 - Part 3
   --  initialize Colors variable:
   --  Sun is Yellow, Earth is Blue, Moon is White, Satellite is Red
   --$ begin answer
   Colors := (Sun => Yellow,
              Earth => Blue,
              Moon => White,
              Satellite => Red);
   --$ end answer

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
      --$ begin answer
      for B in Rotating_Bodies_T loop
         --  This solution illustrates the use of a block statement with
         --  local constants to reduce repetition and improve readability
         --  in the loop body.
         declare
            This_Pred : constant Bodies_Enum_T := Bodies_Enum_T'Pred (B);
            D         : constant Float := Bodies (B, Distance);
            A         : constant Float := Bodies (B, Angle);
         begin
            Bodies (B, X) := Bodies (This_Pred, X) + D * Cos (A);
            Bodies (B, Y) := Bodies (This_Pred, Y) + D * Sin (A);
            Bodies (B, Angle) := A + Bodies (B, Speed);
         end;
      end loop;
      --$ end answer

      --  loop to draw every objects

      --  QUESTION 2 - Part 2
      --  create a loop to draw every objects
      --    use the Draw_Sphere procedure with the Point_T argument
      --$ begin answer
      for B in Bodies_Enum_T loop
         Draw_Sphere (Position => (Bodies (B, X), Bodies (B, Y)),
                      Radius   => Bodies (B, Radius),
                      Color    => Colors (B));
      end loop;
      --$ end answer

      --  update the screen
      New_Frame;

      delay until Next;

      --  update the Next time adding the period for the next step
      Next := Next + Period;
   end loop;

end Array_Types_Main;
