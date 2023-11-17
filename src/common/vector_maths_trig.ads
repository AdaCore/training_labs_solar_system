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

with Ada.Numerics;
with Vector_Maths; use Vector_Maths;

package Vector_Maths_Trig is

   pragma Pure (Vector_Maths_Trig);

   subtype Real is Float;

   subtype Real_Angle_Radians is
     Real range 0.0 .. Real'Pred (2.0 * Ada.Numerics.Pi);

   --  Non-oriented angle of a non-null 2D vector to (1, 0), in degrees
   --  e.g. (1, 0) => 0.0, (0, 1) => Pi / 2, (0, -1) => 3 * Pi / 2
   function Angle_With_X (Right : Real_Vector) return Real_Angle_Radians
     --  poles of arccos at 1 and -1
     with
     Pre => abs (abs (Right (Right'First) / abs (Right)) - 1.0) > 1.0e-4;

end Vector_Maths_Trig;
