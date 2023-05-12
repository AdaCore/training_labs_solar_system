-----------------------------------------------------------------------
--                              Ada Labs                             --
--                                                                   --
--                 Copyright (C) 2008-2023, AdaCore                  --
--                                                                   --
-- Labs is free  software; you can redistribute it and/or modify  it --
-- under the terms of the GNU General Public License as published by --
-- the Free Software Foundation; either version 2 of the License, or --
-- (at your option) any later version.                               --
--                                                                   --
-- This program is  distributed in the hope that it will be  useful, --
-- but  WITHOUT ANY WARRANTY;  without even the  implied warranty of --
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU --
-- General Public License for more details. You should have received --
-- a copy of the GNU General Public License along with this program; --
-- if not,  write to the  Free Software Foundation, Inc.,  59 Temple --
-- Place - Suite 330, Boston, MA 02111-1307, USA.                    --
-----------------------------------------------------------------------

with Float_Maths; use Float_Maths;

package body Solar_System is

   --  implement a function to compute the X coordinate
   --  x of the reference + distance * cos(angle)
   function Compute_X
     (Body_To_Move : Body_T; Turns_Around : Body_T) return Float;

   --  implement a function to compute the Y coordinate
   --  y of the reference + distance * sin(angle)
   function Compute_Y
     (Body_To_Move : Body_T; Turns_Around : Body_T) return Float;

   function Compute_X
     (Body_To_Move : Body_T; Turns_Around : Body_T) return Float
   is
   begin
      return Turns_Around.X + Body_To_Move.Distance * Cos (Body_To_Move.Angle);
   end Compute_X;

   function Compute_Y
     (Body_To_Move : Body_T; Turns_Around : Body_T) return Float
   is
   begin
      return Turns_Around.Y + Body_To_Move.Distance * Sin (Body_To_Move.Angle);
   end Compute_Y;

   procedure Move
     (Bodies : in out Bodies_Array_T; Body_To_Move_Index : Bodies_Enum_T);

   procedure Move
     (Bodies : in out Bodies_Array_T; Body_To_Move_Index : Bodies_Enum_T) is
      Body_To_Move : Body_T renames Bodies (Body_To_Move_Index);
      Turns_Around : constant Body_T := Bodies (Body_To_Move.Turns_Around);
   begin

      Body_To_Move.X :=
        Compute_X (Body_To_Move, Turns_Around);

      Body_To_Move.Y :=
        Compute_Y (Body_To_Move, Turns_Around);

      Body_To_Move.Angle := Body_To_Move.Angle + Body_To_Move.Speed;

   end Move;

   procedure Move_All (Bodies : in out Bodies_Array_T) is
   begin

      --  loop over all bodies and call Move procedure
      for B in Bodies'Range loop

         --  call the move procedure for each body
         Move (Bodies, B);
      end loop;

   end Move_All;

end Solar_System;
