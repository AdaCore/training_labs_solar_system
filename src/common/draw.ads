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

package Draw is
   --  This package is a common front end for the labs.

   type Color_T is (Yellow, Blue, White, Red, Cyan, Green, Orange, Black);

   type Point_T is record
      X, Y : Float;
   end record;

   procedure Create_Window (Width, Height : Positive; Name : String);

   procedure Draw_Sphere (Position : Point_T;
                          Radius : Float;
                          Color : Color_T);

   function Running return Boolean;

   procedure New_Frame;

   --  Configuration
   type Backend_T is (TSV, Mage);

end Draw;
