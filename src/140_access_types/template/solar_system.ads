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

with Draw; use Draw;

package Solar_System is

   --  define type Bodies_Enum_T as an enumeration of Sun, Earth, Moon,
   --  Satellite ...
   type Bodies_Enum_T is
     (Sun, Earth, Moon, Satellite, Comet, Black_Hole, Asteroid_1,
      Asteroid_2);

   --  TODO : declare type Body_Access_T as an access type to all Body_T
   --$ begin answer
   type Body_T is private;
   type Body_Access_T is access all Body_T;
   --$ end answer

   type Bodies_Array_T is private;

   --$ begin question
   --  TODO : Implement Get_Body returning an access of type Body_Access_T
   --  function Get_Body (B : Bodies_Enum_T; Bodies : access Bodies_Array_T)
   --  return Body_Access_T;
   --$ end question
   --$ begin answer
   function Get_Body
     (B      : Bodies_Enum_T;
      Bodies : access Bodies_Array_T) return Body_Access_T;
   --$ end answer

   --$ begin question
   --  TODO : Modify Init_Body with the following profile
   --    procedure Init_Body
   --      (B            : Body_Access_T;
   --       Radius       : Float;
   --       Color        : Color_T;
   --       Distance     : Float;
   --       Angle        : Float;
   --       Speed        : Float;
   --       Turns_Around : Body_Access_T;
   --       Visible      : Boolean := True);
   --$ end question
   procedure Init_Body
     --$ begin question
     (B            :        Bodies_Enum_T;
      Bodies       : in out Bodies_Array_T;
     --$ end question
     --$ line answer
     (B            : Body_Access_T;
      Radius       :        Float;
      Color        :        Color_T;
      Distance     :        Float;
      Angle        :        Float;
      Speed        :        Float;
     --$ line question
      Turns_Around :        Bodies_Enum_T;
     --$ line answer
      Turns_Around :        Body_Access_T;
      Visible      :        Boolean := True);

   --$ line question
   procedure Move_All (Bodies : in out Bodies_Array_T);
   --$ line answer
   procedure Move_All (Bodies : access Bodies_Array_T);

private
   --  define a type Body_T to store every information about a body
   --  X, Y, Distance, Speed, Angle, Radius, Color
   type Body_T is record
      X        : Float   := 0.0;
      Y        : Float   := 0.0;
      Distance : Float   := 0.0;
      Speed    : Float   := 0.0;
      Angle    : Float   := 0.0;
      Radius   : Float   := 0.0;
      Color    : Color_T;
      Visible  : Boolean := True;
      --  TODO : Modify Turns_Around as an access to Body_T using
      --  Body_Access_T type
      --$ line question
      Turns_Around : Bodies_Enum_T := Sun;
      --$ line answer
      Turns_Around : Body_Access_T;
   end record;

   --  define type Bodies_Array_T as an array of Body_T indexed by bodies
   --  enumeration
   --$ line question
   type Bodies_Array_T is array (Bodies_Enum_T) of Body_T;
   --$ line answer
   type Bodies_Array_T is array (Bodies_Enum_T) of aliased Body_T;

   --  TODO : Modify the Move procedure with the following profile
   --  procedure Move (Body_To_Move : Body_Access_T);
   --$ line question
   procedure Move (Bodies : in out Bodies_Array_T; B : Bodies_Enum_T);
   --$ line answer
   procedure Move (Body_To_Move : Body_Access_T);
end Solar_System;
