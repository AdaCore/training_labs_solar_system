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

with Mage; use Mage;

package Solar_System is

   --  define type Bodies_Enum as an enumeration of Sun, Earth, Moon, Satellite
   type Bodies_Enum_T is
     (Sun, Earth, Moon, Satellite, Comet, Black_Hole, Asteroid_1, Asteroid_2);

   type Body_T is private;

   type Body_Access_T is access all Body_T;

   type Bodies_Array_T is private;

   function Get_Body
     (B      : Bodies_Enum_T;
      Bodies : access Bodies_Array_T) return Body_Access_T;

   procedure Init_Body
     (B            : Body_Access_T;
      Radius       : Float;
      Color        : RGBA_T;
      Distance     : Float;
      Angle        : Float;
      Speed        : Float;
      Turns_Around : Body_Access_T;
      Visible      : Boolean := True);

   procedure Move_All (Bodies : access Bodies_Array_T);

private
   --  Question: this data structure must be exported, for that the
   --  convention must be set to C.
   type Body_T is record
      X            : Float   := 0.0;
      Y            : Float   := 0.0;
      Distance     : Float;
      Speed        : Float;
      Angle        : Float;
      Radius       : Float;
      Color        : RGBA_T;
      Visible      : Boolean := True;
      Turns_Around : Body_Access_T;
   --$ line question
   end record;
   --$ begin answer
   end record
      with Convention => C;
   --$ end answer

   --  define type Bodies_Array as an array of Body_Type indexed by bodies
   --  enumeration
   type Bodies_Array_T is array (Bodies_Enum_T) of aliased Body_T;

   procedure Move (Body_To_Move : in out Body_T);

end Solar_System;
