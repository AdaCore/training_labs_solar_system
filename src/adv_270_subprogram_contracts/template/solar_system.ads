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
--$ begin question

--  TODO: Remove once lab is done
pragma Warnings (Off,
    "no entities of ""Solar_System_Spec"" are referenced in spec");
--$ end question
with Solar_System_Spec; use Solar_System_Spec;

package Solar_System is

   type Bodies_Enum_T is
     (Sun, Earth, Moon, Satellite, Comet, Black_Hole, Asteroid_1, Asteroid_2);
   type Bodies_Array_T is private;

   function Does_Orbit (B : Bodies_Enum_T; Turns_Around : Bodies_Enum_T)
      return Boolean;
   --  Checks if the body B is orbiting, from its Enum and Turns_Around
   --  attributes

   --$ begin answer
   function Body_Orbits
      (B : Bodies_Enum_T; Turns_Around : Bodies_Enum_T; Speed : Float)
      return Boolean;

   --$ end answer
   --  QUESTION 4: Use the new types, and the visibility contract
   procedure Init_Body
     (B            :        Bodies_Enum_T;
      Bodies       : in out Bodies_Array_T;
      --$ line question
      Radius       :        Float;
      --$ line answer
      Radius       :        Natural_Float;
      Color        :        RGBA_T;
      --$ begin question
      Distance     :        Float;
      Angle        :        Float;
      --$ end question
      --$ begin answer
      Distance     :        Natural_Float;
      Angle        :        Mod2Pi_Float;
      --$ end answer
      Speed        :        Float;
      Turns_Around :        Bodies_Enum_T;
      --$ line question
      Visible      :        Boolean := True);
   --$ begin answer
      Visible      :        Boolean := True)
   with Pre =>
      (Body_Orbits_Or_Has_Zero_Orbit
         (Does_Orbit (B, Turns_Around),
          Distance, Angle, Speed)
       and then Body_Is_Visible_Or_Has_Default_Appearance
         (Visible, Color = Black, Radius));

   --  QUESTION 10
   --  Notice the simplified contracts due to the API
   --  being more specialized.

   procedure Init_Still_Body
     (B            :        Bodies_Enum_T;
      Bodies       : in out Bodies_Array_T;
      Radius       :        Positive_Float;
      Color        :        RGBA_T);

   procedure Init_Invisible_Body
     (B            :        Bodies_Enum_T;
      Bodies       : in out Bodies_Array_T;
      Distance     :        Positive_Float;
      Angle        :        Mod2Pi_Float;
      Speed        :        Float;
      Turns_Around :        Bodies_Enum_T)
   with Pre => Body_Orbits (B, Turns_Around, Speed);

   procedure Init_Orbiting_Body
     (B            :        Bodies_Enum_T;
      Bodies       : in out Bodies_Array_T;
      Radius       :        Positive_Float;
      Color        :        RGBA_T;
      Distance     :        Positive_Float;
      Angle        :        Mod2Pi_Float;
      Speed        :        Float;
      Turns_Around :        Bodies_Enum_T)
   with Pre => Body_Orbits (B, Turns_Around, Speed);
   --$ end answer

   procedure Move_All (Bodies : in out Bodies_Array_T);

   function Init_With_No_Cycle (Bodies : Bodies_Array_T) return Boolean;

private

   --  type Body_T stores every information about a body

   --  QUESTION 3.a: Use the new types to update the definition of Body_T
   type Body_T is record
      X            : Float   := 0.0;
      Y            : Float   := 0.0;
      --$ begin question
      Distance     : Float;
      Angle        : Float;
      Speed        : Float;
      Radius       : Float;
      --$ end question
      --$ begin answer
      Distance     : Natural_Float;
      Angle        : Mod2Pi_Float;
      Speed        : Float;
      Radius       : Natural_Float;
      --$ end answer
      Color        : RGBA_T;
      Visible      : Boolean := True;
      Turns_Around : Bodies_Enum_T;
   end record;

   --  define type Bodies_Array as an array of Body_Type indexed by
   --  bodies enumeration
   type Bodies_Array_T is array (Bodies_Enum_T) of Body_T;

   --$ line question
   function Find (A : Bodies_Array_T; B : Body_T) return Bodies_Enum_T;
   --$ begin answer
   --  not part of the original questions, but adding contracts removes a
   --  raise statement for the body not being found.
   function Find (A : Bodies_Array_T; B : Body_T) return Bodies_Enum_T
      with Pre => (for some Existing_Body of A => Existing_Body = B),
           Post => (A (Find'Result) = B);
   --$ end answer

end Solar_System;
