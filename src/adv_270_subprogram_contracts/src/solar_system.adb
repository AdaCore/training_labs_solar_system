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

--  TODO: Remove once lab is done
pragma Warnings (Off,
    "with clause might be moved to body");
private with Solar_System.Spec_Conversion; use Solar_System.Spec_Conversion;

package body Solar_System is

   --  TODO: Remove once lab is done
   pragma Warnings (Off, "not referenced");
   pragma Warnings (Off,
       "no entities of ""Solar_System"" are referenced in spec");

   function Find (A : Bodies_Array_T; B : Body_T) return Bodies_Enum_T is
   begin
      for E in A'Range loop
         if A (E) = B then
            return E;
         end if;
      end loop;
      raise Program_Error with "provided body is not in the bodies array";
   end Find;

   function Does_Orbit (B : Bodies_Enum_T; Turns_Around : Bodies_Enum_T)
      return Boolean
   is (Does_Orbit (To_Body_Id (B), To_Body_Id (Turns_Around)));

   function Does_Orbit (B : Body_T; A : Bodies_Array_T)
      return Boolean
   is (Does_Orbit (Find (A, B), B.Turns_Around));

   procedure Init_Body
     (B            :        Bodies_Enum_T;
      Bodies       : in out Bodies_Array_T;
      Radius       :        Float;
      Color        :        RGBA_T;
      Distance     :        Float;
      Angle        :        Float;
      Speed        :        Float;
      Turns_Around :        Bodies_Enum_T;
      Visible      :        Boolean := True)
   is
   begin

      Bodies (B) :=
        (Distance     => Distance,
         Speed        => Speed,
         Angle        => Angle,
         Turns_Around => Turns_Around,
         Visible      => Visible,
         Color        => Color,
         Radius       => Radius,
         others       => <>);

   end Init_Body;

   function Init_With_No_Cycle (Bodies : Bodies_Array_T) return Boolean is
   begin
      --  Question 7.b
      --  Check that there are no cycles in the orbits by calling the
      --  proper spec function.
      return Solar_System_Spec.Not_Implemented;
   end Init_With_No_Cycle;

   --  X coordinate = x of the reference + distance * cos(angle)
   function Compute_X
     (Body_To_Move : Body_T;
      Turns_Around : Body_T) return Float
   is
   begin
      return Turns_Around.X + Body_To_Move.Distance * Cos (Body_To_Move.Angle);
   end Compute_X;

   --  Y coordinate = y of the reference + distance * sin(angle)
   function Compute_Y
     (Body_To_Move : Body_T;
      Turns_Around : Body_T) return Float
   is
   begin
      return Turns_Around.Y + Body_To_Move.Distance * Sin (Body_To_Move.Angle);
   end Compute_Y;

   procedure Move (Body_To_Move : in out Body_T; Bodies : Bodies_Array_T) is
   begin

      --  Question 3.b: Fix the runtime error by handling issues with
      --  overflows and underflows.

      Body_To_Move.X :=
        Compute_X (Body_To_Move, Bodies (Body_To_Move.Turns_Around));

      Body_To_Move.Y :=
        Compute_Y (Body_To_Move, Bodies (Body_To_Move.Turns_Around));

      Body_To_Move.Angle := Body_To_Move.Angle + Body_To_Move.Speed;

   end Move;

   procedure Move_All (Bodies : in out Bodies_Array_T) is
   begin

      --  loop over all bodies and call Move procedure
      for B of Bodies loop
         --  call the move procedure for each body
         Move (B, Bodies);
      end loop;

   end Move_All;

end Solar_System;
