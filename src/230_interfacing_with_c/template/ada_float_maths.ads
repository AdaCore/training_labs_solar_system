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

package Ada_Float_Maths is

   --  QUESTION 1 - Part 1
   --  export the Ada_Cos function so that the C compute library can use it
   function Ada_Cos (X : Float) return Float
   is
   --$ line question
     (Cos (X));
   --$ line answer
     (Cos (X)) with Export, Convention => C;

   --  QUESTION 1 - Part 2
   --  export the Ada_Sin function so that the C compute library can use it
   function Ada_Sin (X : Float) return Float
   is
   --$ line question
     (Sin (X));
   --$ line answer
     (Sin (X)) with Export, Convention => C;

end Ada_Float_Maths;
