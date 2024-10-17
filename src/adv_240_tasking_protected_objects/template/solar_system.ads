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

   --  define type Bodies_Enum as an enumeration of Sun, Earth, Moon,
   --  Satellite
   type Bodies_Enum_T is
     (Sun, Earth, Moon, Satellite, Comet, Black_Hole, Asteroid_1, Asteroid_2);
   --$ line question
   type Bodies_Array_T is private;

   procedure Init_Body
     (B            :        Bodies_Enum_T;
      --$ line question
      Bodies       : in out Bodies_Array_T;
      Radius       :        Float;
      Color        :        Color_T;
      Distance     :        Float;
      Angle        :        Float;
      Speed        :        Float;
      Turns_Around :        Bodies_Enum_T;
      --$ line answer
      Tail         :        Boolean := False;
      Visible      :        Boolean := True);

   --$ begin question
   procedure Move_All (Bodies : in out Bodies_Array_T);

   --$ end question
   --  QUESTION: implement a procedure Terminate_Tasks to terminate
   --  all running tasks, so that the app can exit
   --$ line answer
   procedure Terminate_Tasks;

private
   --$ begin answer
   --  replacing separate coordinates by a composite
   type Position_T is record
      X : Float := 0.0;
      Y : Float := 0.0;
   end record;
   Default_Position : constant Position_T := (others => <>);

   --  tail support
   type Tail_Length_T is new Integer range 1 .. 10;
   type Tail_T is array (Tail_Length_T) of Position_T;

   --$ end answer
   --  define a type Body_T to store every information about a body
   --   X, Y, Distance, Speed, Angle, Radius, Color
   type Body_T is record
      --$ begin question
      X            : Float   := 0.0;
      Y            : Float   := 0.0;
      --$ end question
      --$ line answer
      Pos          : Position_T := Default_Position;
      Distance     : Float;
      Speed        : Float;
      Angle        : Float;
      Radius       : Float;
      Color        : Color_T;
      Visible      : Boolean := True;
      Turns_Around : Bodies_Enum_T;
      --$ begin answer
      With_Tail    : Boolean := False;
      Tail         : Tail_T  := (others => Default_Position);
      --$ end answer
   end record;

   --$ begin answer
   protected Dispatch_Tasks is
      procedure Get_Next_Body (B : out Bodies_Enum_T);
   private
      Current : Bodies_Enum_T := Bodies_Enum_T'First;
   end Dispatch_Tasks;

   task type T_Move_Body;

   type Task_Array_T is array (Bodies_Enum_T) of T_Move_Body;
   Tasks : Task_Array_T;

   protected type Body_P is
      function Get_Data return Body_T;
      procedure Set_Data (B : Body_T);
   private
      Data : Body_T;
   end Body_P;

   --$ end answer
   --$ line question
   type Bodies_Array_T is array (Bodies_Enum_T) of Body_T;
   --$ begin answer
   type Bodies_Array_T is array (Bodies_Enum_T) of Body_P;

   Bodies : Bodies_Array_T;
   --$ end answer

   procedure Move (Body_To_Move : in out Body_T; Turns_Around : Body_T);

end Solar_System;
