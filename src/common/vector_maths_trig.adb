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

with Float_Maths; use Float_Maths;

package body Vector_Maths_Trig is

   function Angle_With_X (Right : Real_Vector) return Real_Angle_Radians
   --  FIXME implement and use atan2-variant
   is
      Cos_Value : constant Float
         := Right (Right'First) / abs (Right);
      pragma Assert (abs (abs (Cos_Value) - 1.0) > 1.0e-4);
      Half_Angle : constant Float
         := Arccos (Cos_Value);
      Bottom_Half : constant Boolean := Right (Right'First + 1) < 0.0;
   begin
      return
         (if Bottom_Half
          then 2.0 * Ada.Numerics.Pi - Half_Angle
          else Half_Angle);
   end Angle_With_X;

end Vector_Maths_Trig;
