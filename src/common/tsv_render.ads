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

with Mage;
with Mage.Model;

package TSV_Render is
   --  This package is a TSV front end for the labs
   --  that is it produces a text output.
   type RGBA_T is (Yellow, Blue, White, Red, Cyan, Green, Orange, Black);
   subtype Point_3d is Mage.Model.Point_3d;

   type Sphere_T is record
       Position : Point_3d;
       Radius : Float;
       Color : RGBA_T;
   end record;

   type Sphere_Arr is array (Positive range <>) of Sphere_T;

   type Canvas_T is record
       Spheres : Sphere_Arr (1 .. 20);
       Number_Of_Spheres : Natural range 0 .. 20 := 0;
       Frame_Count : Natural := 0;
   end record;

   type Canvas_ID is null record;

   type Window_ID is null record;

   function Create_Window (Width, Height : Positive; Name : String)
       return Window_ID;

   function Get_Canvas (W : Window_ID) return Canvas_ID;

   procedure Draw_Sphere (Canvas : Canvas_ID;
                          Position : Point_3d;
                          Radius : Float;
                          Color : RGBA_T);

   procedure Handle_Events (W : in out Window_ID);

   Is_Killed : Boolean := False;
end TSV_Render;
