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

with Ada.Real_Time; use Ada.Real_Time;
with Float_Maths;   use Float_Maths;

package body Solar_System is

   procedure Init_Body
     (B            :        Bodies_Enum_T;
      Radius       :        Float;
      Color        :        RGBA_T;
      Distance     :        Float;
      Angle        :        Float;
      Speed        :        Float;
      Turns_Around :        Bodies_Enum_T;
      Tail         :        Boolean := False;
      Visible      :        Boolean := True)
   is
   begin

      Bodies (B).Set_Data (
         (Distance     => Distance,
         Speed        => Speed,
         Angle        => Angle,
         Turns_Around => Turns_Around,
         Visible      => Visible,
         Color        => Color,
         Radius       => Radius,
         With_Tail    => Tail,
         others       => <>));

   end Init_Body;

   --  compute the X coordinate:
   --  x of the reference + distance * cos(angle)
   function Compute_X
     (Body_To_Move : Body_T;
      Turns_Around : Body_T) return Float;

   --  compute the Y coordinate:
   --  y of the reference + distance * sin(angle)
   function Compute_Y
     (Body_To_Move : Body_T;
      Turns_Around : Body_T) return Float;

   function Compute_X
     (Body_To_Move : Body_T;
      Turns_Around : Body_T) return Float is
   begin
      return Turns_Around.Pos.X
         + Body_To_Move.Distance * Cos (Body_To_Move.Angle);
   end Compute_X;

   function Compute_Y
     (Body_To_Move : Body_T;
      Turns_Around : Body_T) return Float is
   begin
      return Turns_Around.Pos.Y
         + Body_To_Move.Distance * Sin (Body_To_Move.Angle);
   end Compute_Y;

   procedure Move (Body_To_Move : in out Body_T; Turns_Around : Body_T) is
   begin
      Body_To_Move.Pos.X :=
        Compute_X (Body_To_Move, Turns_Around);

      Body_To_Move.Pos.Y :=
        Compute_Y (Body_To_Move, Turns_Around);

      Body_To_Move.Angle := Body_To_Move.Angle + Body_To_Move.Speed;

      if Body_To_Move.With_Tail then
         for I in Body_To_Move.Tail'First .. Body_To_Move.Tail'Last - 1 loop
            Body_To_Move.Tail (I) := Body_To_Move.Tail (I + 1);
         end loop;
         Body_To_Move.Tail (Tail_T'Last) := Body_To_Move.Pos;
      end if;
   end Move;

   -------------------------
   -- Protected and Tasks --
   -------------------------

   protected body Body_P is
      function Get_Data return Body_T is
      begin
         return Data;
      end Get_Data;

      procedure Set_Data (B : Body_T) is
      begin
         Data := B;
      end Set_Data;
   end Body_P;

   protected body Dispatch_Tasks is
      procedure Get_Next_Body (B : out Bodies_Enum_T) is
      begin
         B := Current;
         if Current /= Bodies_Enum_T'Last then
            Current := Bodies_Enum_T'Succ (Current);
         end if;
      end Get_Next_Body;
   end Dispatch_Tasks;

   --  single writer, multiple reader, using an atomic
   Run : Boolean := True
      with Atomic;

   task body T_Move_Body is
      --  declare a variable Now of type Time to record current time
      Now : Time;
      --  declare a constant Period of 40 milliseconds of type Time_Span
      --  defining the loop period
      Period       : constant Time_Span := Milliseconds (20);
      Current      : Body_T;
      Turns_Around : Body_T;
      B            : Bodies_Enum_T;
   begin
      Dispatch_Tasks.Get_Next_Body (B);
      while Run loop
         Now          := Clock;
         Current      := Bodies (B).Get_Data;
         Turns_Around := Bodies (Current.Turns_Around).Get_Data;
         Move (Current, Turns_Around);
         Bodies (B).Set_Data (Current);
         delay until Now + Period;
      end loop;

   end T_Move_Body;

   procedure Terminate_Tasks is
   begin
      Run := False;

      --  Wait for tasks to terminate
      for T of Tasks loop
         while not T'Terminated loop
            delay 0.1;
         end loop;
      end loop;
   end Terminate_Tasks;
end Solar_System;
