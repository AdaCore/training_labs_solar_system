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

package body Solar_System is

   --  TODO: Remove once subprograms are implemented
   pragma Warnings (Off, "not referenced");

   function Get_Body
     (B      : Bodies_Enum_T;
      Bodies : access Bodies_Array_T) return Body_Access_T
   is

   begin
      return Bodies (B)'Access;
   end Get_Body;

   procedure Init_Body
     (B            : Body_Access_T;
      Radius       : Float;
      Color        : RGBA_T;
      Distance     : Float;
      Angle        : Float;
      Speed        : Float;
      Turns_Around : Body_Access_T;
      Visible      : Boolean := True)
   is
   begin

      B.all :=
        (Distance     => Distance,
         Speed        => Speed,
         Angle        => Angle,
         Turns_Around => Turns_Around,
         Visible      => Visible,
         Radius       => Radius,
         Color        => Color,
         others       => <>);

   end Init_Body;

   --  QUESTION 3 - Part 1: import the 'compute_x' function from the C compute library
   function Compute_X (Body_To_Move : Body_T) return Float
      is (0.0);

   --  QUESTION 3 - Part 2: import the 'compute_y' function from the C compute library
   function Compute_Y (Body_To_Move : Body_T) return Float
      is (0.0);

   procedure Move (Body_To_Move : in out Body_T) is
   begin
      Body_To_Move.X := Compute_X (Body_To_Move);

      Body_To_Move.Y := Compute_Y (Body_To_Move);

      Body_To_Move.Angle := Body_To_Move.Angle + Body_To_Move.Speed;
   end Move;

   procedure Move_All (Bodies : access Bodies_Array_T) is
   begin
      --  loop over all bodies and call Move procedure
      for B in Bodies_Enum_T loop
         --  call the move procedure for each body
         Move (Get_Body (B, Bodies).all);
      end loop;

   end Move_All;

end Solar_System;
