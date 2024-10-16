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

package body Vector_Maths_Trig is

   function Angle_With_X (Right : Real_Vector) return Real_Angle_Radians
      --  FIXME implement and use atan2-variant
   is
      V_Is_0_0 : constant Boolean := Right = (0.0, 0.0);
      Pure_X : constant Boolean
        := V_Is_0_0
        or else abs
          (abs (Right (Right'First) / abs (Right)) - 1.0) <= 1.0e-4;

      Cos_Value : constant Float
        := (if V_Is_0_0 then 1.0 else Right (Right'First) / abs (Right));
      Half_Angle  : constant Float
        := (if Pure_X then 0.0 else Arccos (Cos_Value));
      Bottom_Half : constant Boolean := Right (Right'First + 1) < 0.0;
   begin
      return
        (if Bottom_Half then
           (if Pure_X
            then Ada.Numerics.Pi
            else 2.0 * Ada.Numerics.Pi - Half_Angle)
         else Half_Angle);
   end Angle_With_X;

end Vector_Maths_Trig;
