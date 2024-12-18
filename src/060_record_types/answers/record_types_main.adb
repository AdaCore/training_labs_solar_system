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

procedure Record_Types_Main is

   type Bodies_Enum_T is (Sun, Earth, Moon, Satellite);

   subtype Rotating_Bodies_T is Bodies_Enum_T
     range Earth .. Bodies_Enum_T'Last;

   --  QUESTION 1: replace the definition of Body_T by a type that stores
   --  body attributes
   --   X, Y, Distance, Speed, Angle, Color type is Color_T, Radius
   type Body_T (Visible : Boolean := True) is record
      X            : Float;
      Y            : Float;
      Distance     : Float;
      Speed        : Float;
      Angle        : Float;
      Turns_Around : Bodies_Enum_T;
      case Visible is
         when True =>
            Color        : Color_T;
            Radius       : Float;
         when others =>
            null;
      end case;
   end record;

   type Bodies_Array_T is array (Bodies_Enum_T) of Body_T;

   Bodies : Bodies_Array_T;

   Period  : constant Time_Span := Milliseconds (40);

   Next : Time;

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
   Bodies := (Sun => (Visible => True,
                      Distance => 0.0,
                      Speed => 0.0,
                      Radius => 20.0,
                      X => 0.0,
                      Y => 0.0,
                      Angle => 0.0,
                      Color => Yellow,
                      Turns_Around => Sun),
              Earth => (Visible => False,
                        Distance => 50.0,
                        Speed => 0.02,
                        --  Radius => 5.0,
                        X => 0.0,
                        Y => 0.0,
                        Angle => 0.0,
                        --  Color => Blue,
                        Turns_Around => Sun),
              Moon => (Visible => True,
                      Distance => 15.0,
                       Speed => -0.04,
                       Radius => 2.0,
                       X => 0.0,
                       Y => 0.0,
                       Angle => 0.0,
                       Color => White,
                       Turns_Around => Earth),
              Satellite => (Visible => True,
                      Distance => 8.0,
                            Speed => 0.1,
                            Radius => 1.0,
                            X => 0.0,
                            Y => 0.0,
                            Angle => 0.0,
                            Color => Red,
                            Turns_Around => Earth));

   Next := Clock + Period;

   while Running loop

      --  create a loop to update each body position and angles
      --    the position of an object around (0,0) at distance d with an angle
      --    a is (d*cos(a), d*sin(a))
      --  update angle parameter of each body adding speed to the previous
      --  angle
      for B in Rotating_Bodies_T loop
         declare
            --  rename to clarify indexing
            Moving_Body : Body_T renames Bodies (B);
            --  constants being used
            TA : constant Bodies_Enum_T := Moving_Body.Turns_Around;
            Center_Of_Rotation : constant Body_T := Bodies (TA);
            A  : constant Float         := Moving_Body.Angle;
            D  : constant Float         := Moving_Body.Distance;
         begin
            Moving_Body.X := Center_Of_Rotation.X + D * Cos (A);
            Moving_Body.Y := Center_Of_Rotation.Y + D * Sin (A);
            Moving_Body.Angle := A + Moving_Body.Speed;
         end;
      end loop;

      --  create a loop to draw every objects
      --  use the Draw_Sphere procedure to do it
      --  QUESTION 4: Once finished -> implement black holes
      --  as discriminated records without radius or color.
      for B in Bodies_Enum_T loop
         declare
            --  constant to clarify code
            Drawn_Body : constant Body_T := Bodies (B);
         begin
            if Drawn_Body.Visible then
               Draw_Sphere (Position => (Drawn_Body.X, Drawn_Body.Y),
                            Radius   => Drawn_Body.Radius,
                            Color    => Drawn_Body.Color);
            end if;
         end;
      end loop;

      --  update the screen
      New_Frame;

      delay until Next;
      Next := Next + Period;

   end loop;
end Record_Types_Main;
