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

with Draw; use Draw;

package Solar_System is

   type Bodies_Enum_T is
     (Sun, Earth, Moon, Satellite, Comet, Black_Hole, Asteroid_1, Asteroid_2);

   --  define a type Body_T to store every information about a body
   --  X, Y, Distance, Speed, Angle, Radius, Color
   type Body_T is record
      X            : Float   := 0.0;
      Y            : Float   := 0.0;
      Distance     : Float;
      Speed        : Float;
      Angle        : Float;
      Radius       : Float;
      Color        : Color_T;
      Visible      : Boolean := True;
      Turns_Around : Bodies_Enum_T;
   end record;

   --  define type Bodies_Array as an array of Body_Type indexed by
   --  bodies enumeration
   type Bodies_Array_T is array (Bodies_Enum_T) of Body_T;

   procedure Move_All (Bodies : in out Bodies_Array_T);

end Solar_System;
