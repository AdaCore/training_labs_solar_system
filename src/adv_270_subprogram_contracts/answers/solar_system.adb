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

with Float_Maths; use Float_Maths;
private with Solar_System.Spec_Conversion; use Solar_System.Spec_Conversion;

package body Solar_System is

   function Find (A : Bodies_Array_T; B : Body_T) return Bodies_Enum_T is
   begin
      pragma Warnings (Off, """return"" statement missing");
      for E in A'Range loop
         if A (E) = B then
            return E;
         end if;
      end loop;
      pragma Warnings (On, """return"" statement missing");
   end Find;

   function Does_Orbit (B : Bodies_Enum_T; Turns_Around : Bodies_Enum_T)
      return Boolean
   is (Does_Orbit (To_Body_Id (B), To_Body_Id (Turns_Around)));

   function Does_Orbit (B : Body_T; A : Bodies_Array_T)
      return Boolean
   is (Does_Orbit (Find (A, B), B.Turns_Around));

   function Body_Orbits
      (B : Bodies_Enum_T; Turns_Around : Bodies_Enum_T; Speed : Float)
      return Boolean
   is (Body_Orbits (To_Body_Id (B), To_Body_Id (Turns_Around), Speed));

   procedure Init_Body
     (B            :        Bodies_Enum_T;
      Bodies       : in out Bodies_Array_T;
      Radius       :        Natural_Float;
      Color        :        Color_T;
      Distance     :        Natural_Float;
      Angle        :        Mod2Pi_Float;
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

   procedure Init_Still_Body
     (B            :        Bodies_Enum_T;
      Bodies       : in out Bodies_Array_T;
      Radius       :        Positive_Float;
      Color        :        Color_T)
   is
   begin
      Init_Body
         (B => B,
         Bodies => Bodies,
         Radius => Radius,
         Color => Color,
         Visible => True,
         --  Still
         Distance => 0.0,
         Angle => 0.0,
         Speed => 0.0,
         Turns_Around => B);
   end Init_Still_Body;

   procedure Init_Invisible_Body
     (B            :        Bodies_Enum_T;
      Bodies       : in out Bodies_Array_T;
      Distance     :        Positive_Float;
      Angle        :        Mod2Pi_Float;
      Speed        :        Float;
      Turns_Around :        Bodies_Enum_T)
   is
   begin
      Init_Body
         (B => B,
         Bodies => Bodies,
         Distance => Distance,
         Angle => Angle,
         Speed => Speed,
         Turns_Around => Turns_Around,
         --  Invisible
         Radius => 0.0,
         Color => Black,
         Visible => False);
   end Init_Invisible_Body;

   procedure Init_Orbiting_Body
     (B            :        Bodies_Enum_T;
      Bodies       : in out Bodies_Array_T;
      Radius       :        Positive_Float;
      Color        :        Color_T;
      Distance     :        Positive_Float;
      Angle        :        Mod2Pi_Float;
      Speed        :        Float;
      Turns_Around :        Bodies_Enum_T)
   is
   begin
      Init_Body
         (B => B,
         Bodies => Bodies,
         Radius => Radius,
         Color => Color,
         Distance => Distance,
         Angle => Angle,
         Speed => Speed,
         Turns_Around => Turns_Around,
         Visible => True);
   end Init_Orbiting_Body;

   function Init_With_No_Cycle (Bodies : Bodies_Array_T) return Boolean is
   begin
      --  QUESTION 7 - Part 2
      --  Check that there are no cycles in the orbits by calling the
      --  proper spec function.
      return Solar_System_Spec.No_Cycle (To_Orbit_Centers (Bodies));
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

   procedure Move (Body_To_Move : in out Body_T; Bodies : Bodies_Array_T)
      with
         Pre => Does_Orbit (Body_To_Move, Bodies),
         Post =>
            Has_Moved_One_Step
               (To_Orbiting_Object (Body_To_Move'Old),
                To_Orbiting_Object (Body_To_Move))
            and then Distance_Matches
               (Body_To_Move.X,
                Body_To_Move.Y,
                Bodies (Body_To_Move.Turns_Around).X,
                Bodies (Body_To_Move.Turns_Around).Y,
                Body_To_Move.Distance)
            and then Angle_Matches
               (Body_To_Move.X,
                Body_To_Move.Y,
                Bodies (Body_To_Move.Turns_Around).X,
                Bodies (Body_To_Move.Turns_Around).Y,
                Body_To_Move.Angle)
   is
   begin

      --  QUESTION 3 - Part 2
      --  Fix the runtime error by handling issues with
      --  overflows and underflows.

      if Body_To_Move.Speed > 0.0
         and then
            Body_To_Move.Angle > Mod2Pi_Float'Last - Body_To_Move.Speed
      then
         --  overflow
         Body_To_Move.Angle
            := Body_To_Move.Angle + Body_To_Move.Speed - 2.0 * Pi;
      elsif Body_To_Move.Speed < 0.0 and then
         Body_To_Move.Angle < Mod2Pi_Float'First - Body_To_Move.Speed
      then
         --  underflow
         Body_To_Move.Angle
            := Body_To_Move.Angle + Body_To_Move.Speed + 2.0 * Pi;
      else
         Body_To_Move.Angle := Body_To_Move.Angle + Body_To_Move.Speed;
      end if;

      Body_To_Move.X :=
        Compute_X (Body_To_Move, Bodies (Body_To_Move.Turns_Around));

      Body_To_Move.Y :=
        Compute_Y (Body_To_Move, Bodies (Body_To_Move.Turns_Around));

   end Move;

   procedure Move_All (Bodies : in out Bodies_Array_T) is
   begin

      --  loop over all bodies and call Move procedure
      for B of Bodies loop

         if Does_Orbit (B, Bodies) then
            Move (B, Bodies);
         end if;
      end loop;

   end Move_All;

end Solar_System;
