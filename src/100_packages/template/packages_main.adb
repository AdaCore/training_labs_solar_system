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
with Draw;          use Draw;
--$ line question
with Float_Maths;   use Float_Maths;
--$ begin answer
with Solar_System;          use Solar_System;
with Solar_System.Graphics; use Solar_System.Graphics;
--$ end answer

procedure Packages_Main is

   --$ begin question
   type Bodies_Enum_T is (Sun, Earth, Moon, Satellite, Comet);

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

   --$ end question
   Bodies : Bodies_Array_T;

   Next : Time;

   Period : constant Time_Span := Milliseconds (40);

   --$ begin question
   function Compute_X
     (Body_To_Move : Body_T; Turns_Around : Body_T) return Float;

   function Compute_X
     (Body_To_Move : Body_T; Turns_Around : Body_T) return Float
   is
   begin
      return Turns_Around.X + Body_To_Move.Distance * Cos (Body_To_Move.Angle);
   end Compute_X;

   function Compute_Y
     (Body_To_Move : Body_T; Turns_Around : Body_T) return Float;

   function Compute_Y
     (Body_To_Move : Body_T; Turns_Around : Body_T) return Float
   is
   begin
      return Turns_Around.Y + Body_To_Move.Distance * Sin (Body_To_Move.Angle);
   end Compute_Y;

   procedure Move
     (Bodies : in out Bodies_Array_T; Body_To_Move_Index : Bodies_Enum_T);

   procedure Move
     (Bodies : in out Bodies_Array_T; Body_To_Move_Index : Bodies_Enum_T) is
      Body_To_Move : Body_T renames Bodies (Body_To_Move_Index);
      Turns_Around : constant Body_T := Bodies (Body_To_Move.Turns_Around);
   begin

      Body_To_Move.X :=
        Compute_X (Body_To_Move, Turns_Around);

      Body_To_Move.Y :=
        Compute_Y (Body_To_Move, Turns_Around);

      Body_To_Move.Angle := Body_To_Move.Angle + Body_To_Move.Speed;

   end Move;

   procedure Draw_Body (Object : Body_T) is
   begin
      Draw_Sphere
        (Position => (Object.X, Object.Y),
         Radius => Object.Radius, Color => Object.Color);
   end Draw_Body;

   --$ end question
begin

   Create_Window (Width => 240, Height => 320, Name => "Solar System");

   --  initialize Bodies variable with parameters for each body using an
   --  aggregate
   Bodies :=
     (Sun =>
        (Distance     => 0.0,
         Speed        => 0.0,
         Radius       => 20.0,
         X            => 0.0,
         Y            => 0.0,
         --$ line answer
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
         --$ line answer
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
         --$ line answer
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
         --$ line answer
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
         --$ line answer
         Visible      => True,
         Color        => Yellow,
         --$ line question
         Turns_Around => Sun));
      --$ begin answer
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
      --$ end answer

   --  initialize the Next step time at the current time (Clock) + period
   Next := Clock + Period;

   while Running loop

      --$ begin question
      for B in Bodies_Enum_T loop

         --  call the move procedure for each body
         Move (Bodies, B);
         Draw_Body (Bodies (B));

      end loop;
      --$ end question
      --$ line answer
      Move_All (Bodies);
      --  QUESTION 2
      --  Implement Draw_All in a *new* package Graphics of Solar_System
      --$ line answer
      Draw_All (Bodies);

      New_Frame;

      delay until Next;
      Next := Next + Period;
   end loop;

end Packages_Main;
