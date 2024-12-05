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

with Float_Maths; use Float_Maths;

package body Solar_System is

   --  TODO : Implement Get_Body returning an access of type Body_Access_T
   --  function Get_Body (B : Bodies_Enum_T; Bodies : access Bodies_Array_T)
   --  return Body_Access_T;

   procedure Init_Body
      (B            : Bodies_Enum_T;
       Bodies       : in out Bodies_Array_T;
       Radius       : Float;
       Color        : Color_T;
       Distance     : Float;
       Angle        : Float;
       Speed        : Float;
       Turns_Around : Bodies_Enum_T;
       Visible      : Boolean := True) is
   begin

      Bodies (B) :=
         (Distance     => Distance,
          Speed        => Speed,
          Angle        => Angle,
          Radius       => Radius,
          Color        => Color,
          Turns_Around => Turns_Around,
          Visible      => Visible,
          others       => <>);

   end Init_Body;

   --  implement a function to compute the X coordinate
   --  x of the reference + distance * cos(angle)
   function Compute_X (Body_To_Move : Body_T; Turns_Around : Body_T)
      return Float;

   --  implement a function to compute the Y coordinate
   --  y of the reference + distance * sin(angle)
   function Compute_Y (Body_To_Move : Body_T; Turns_Around : Body_T)
      return Float;

   function Compute_X (Body_To_Move : Body_T; Turns_Around : Body_T)
      return Float is
   begin
      return Turns_Around.X + Body_To_Move.Distance * Cos (Body_To_Move.Angle);
   end Compute_X;

   function Compute_Y (Body_To_Move : Body_T; Turns_Around : Body_T)
      return Float is
   begin
      return Turns_Around.Y + Body_To_Move.Distance * Sin (Body_To_Move.Angle);
   end Compute_Y;

   procedure Move (Bodies : in out Bodies_Array_T; B : Bodies_Enum_T) is
      Body_To_Move : Body_T renames Bodies (B);
   begin

      Body_To_Move.X := Compute_X
         (Body_To_Move, Bodies (Body_To_Move.Turns_Around));

      Body_To_Move.Y := Compute_Y
         (Body_To_Move, Bodies (Body_To_Move.Turns_Around));

      Body_To_Move.Angle := Body_To_Move.Angle + Body_To_Move.Speed;

   end Move;

   procedure Move_All (Bodies : in out Bodies_Array_T) is
   begin

      --  loop over all bodies and call Move procedure
      for B in Bodies_Enum_T loop

         Move (Bodies, B);
      end loop;
   end Move_All;

end Solar_System;
