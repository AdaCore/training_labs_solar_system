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
with Float_Maths;   use Float_Maths;

procedure Subprograms_Main is
   --  QUESTION - Bonus: Remove once subprograms are implemented
   pragma Warnings (Off, "not referenced");

   --  define type Bodies_Enum_T and Rotating_Bodies_T
   type Bodies_Enum_T is (Sun, Earth, Moon, Satellite, Comet);
   subtype Rotating_Bodies_T is Bodies_Enum_T
      range Earth .. Bodies_Enum_T'Last;

   --  define a type Body_T to store every information about a body
   --   X, Y, Distance, Speed, Angle, Color, Radius
   type Body_T is record
      X            : Float := 0.0;
      Y            : Float := 0.0;
      Distance     : Float;
      Speed        : Float;
      Angle        : Float;
      Color        : Color_T;
      Radius       : Float;
      Turns_Around : Bodies_Enum_T;
   end record;

   type Bodies_Array_T is array (Bodies_Enum_T) of Body_T;

   Bodies : Bodies_Array_T;

   Next : Time;

   Period : constant Time_Span := Milliseconds (40);

   --  QUESTION - Bonus: Remove once function is referenced
   pragma Warnings (Off, "function ""Compute_X"" is not referenced");
   --  QUESTION 1 - Part 1
   --  implement a function to compute the X coordinate
   --  x of the reference + distance * cos(angle)

   function Compute_X
     (Body_To_Move : Body_T;
      Turns_Around : Body_T) return Float
   is
   begin
      return 0.0;
   end Compute_X;

   --  QUESTION 1 - Part 2
   --  implement a function to compute the Y coordinate
   --  y of the reference + distance * sin(angle)

   --  QUESTION 2 - Part 1
   --  move a given body over one time step

   procedure Move
     (Bodies : in out Bodies_Array_T; Body_To_Move_Index : Bodies_Enum_T) is
   begin
      null;
   end Move;

   --  QUESTION 3
   --  procedure Draw_Body takes 2 parameters of your choice:
   --    it needs something to draw, and something to draw it on

begin

   Create_Window (Width => 240, Height => 320, Name => "Solar System");

   --  QUESTION 4: Add a comet
   --    Tip: Make it a body that is drawn as several circles that
   --    follow each other.
   Bodies :=
     (Sun =>
        (Distance     => 0.0,
         Speed        => 0.0,
         Radius       => 20.0,
         X            => 0.0,
         Y            => 0.0,
         Angle        => 0.0,
         Color        => Yellow,
         Turns_Around => Sun),
      Earth =>
        (Distance     => 50.0,
         Speed        => 0.02,
         Radius       => 5.0,
         X            => 0.0,
         Y            => 0.0,
         Angle        => 0.0,
         Color        => Blue,
         Turns_Around => Sun),
      Moon =>
        (Distance     => 15.0,
         Speed        => 0.04,
         Radius       => 2.0,
         X            => 0.0,
         Y            => 0.0,
         Angle        => 0.0,
         Color        => White,
         Turns_Around => Earth),
      Satellite =>
        (Distance     => 8.0,
         Speed        => 0.1,
         Radius       => 1.0,
         X            => 0.0,
         Y            => 0.0,
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
         Color        => Yellow,
         Turns_Around => Sun));

   Next := Clock + Period;

   while Running loop
      --  update each body position and angles
      --    the position of an object around (0,0) at distance d with an
      --    angle a is (d*cos(a), d*sin(a))
      --  update angle parameter of each body adding speed to the previous
      --  angle
      for B in Rotating_Bodies_T loop
         --  QUESTION 1 - Part 3: call Compute_X
         Bodies (B).X := Bodies (Bodies (B).Turns_Around).X
           + Bodies (B).Distance
           * Cos (Bodies (B).Angle);

         --  QUESTION 1 - Part 4: call Compute_Y
         Bodies (B).Y := Bodies (Bodies (B).Turns_Around).Y
           + Bodies (B).Distance
           * Sin (Bodies (B).Angle);

         Bodies (B).Angle := Bodies (B).Angle +
           Bodies (B).Speed;
         --  QUESTION 2 - Part 2: call Move
      end loop;

      --  create a loop to draw every objects
      --  use the Draw_Sphere procedure to do it
      for B in Bodies_Enum_T loop
         Draw_Sphere (Position => (Bodies (B).X, Bodies (B).Y),
                      Radius   => Bodies (B).Radius,
                      Color    => Bodies (B).Color);
      end loop;

      New_Frame;

      delay until Next;
      Next := Next + Period;
   end loop;

end Subprograms_Main;
