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

--  TODO: Remove once lab is done
pragma Warnings (Off,
    "no entities of ""Solar_System_Spec"" are referenced in spec");
with Solar_System_Spec; use Solar_System_Spec;

package Solar_System is

   type Bodies_Enum_T is
     (Sun, Earth, Moon, Satellite, Comet, Black_Hole, Asteroid_1, Asteroid_2);
   type Bodies_Array_T is private;

   function Does_Orbit (B : Bodies_Enum_T; Turns_Around : Bodies_Enum_T)
      return Boolean;
   --  Checks if the body B is orbiting, from its Enum and Turns_Around
   --  attributes

   --  Question 4: Use the new types, and the visibility contract
   procedure Init_Body
     (B            :        Bodies_Enum_T;
      Bodies       : in out Bodies_Array_T;
      Radius       :        Float;
      Color        :        RGBA_T;
      Distance     :        Float;
      Angle        :        Float;
      Speed        :        Float;
      Turns_Around :        Bodies_Enum_T;
      Visible      :        Boolean := True);

   procedure Move_All (Bodies : in out Bodies_Array_T);

   function Init_With_No_Cycle (Bodies : Bodies_Array_T) return Boolean;

private

   --  type Body_T stores every information about a body

   --  Question 3.a: Use the new types to update the definition of Body_T
   type Body_T is record
      X            : Float   := 0.0;
      Y            : Float   := 0.0;
      Distance     : Float;
      Angle        : Float;
      Speed        : Float;
      Radius       : Float;
      Color        : RGBA_T;
      Visible      : Boolean := True;
      Turns_Around : Bodies_Enum_T;
   end record;

   --  define type Bodies_Array as an array of Body_Type indexed by
   --  bodies enumeration
   type Bodies_Array_T is array (Bodies_Enum_T) of Body_T;

   function Find (A : Bodies_Array_T; B : Body_T) return Bodies_Enum_T;

end Solar_System;
