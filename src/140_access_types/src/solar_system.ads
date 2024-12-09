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

   --  define type Bodies_Enum_T as an enumeration of Sun, Earth, Moon,
   --  Satellite ...
   type Bodies_Enum_T is
     (Sun, Earth, Moon, Satellite, Comet, Black_Hole, Asteroid_1,
      Asteroid_2);

   --  QUESTION 1: declare type Body_Access_T as an access type to all Body_T

   type Bodies_Array_T is private;

   --  QUESTION 2 - Part 1: Specify Get_Body returning an access of type Body_Access_T
   --  function Get_Body (B : Bodies_Enum_T; Bodies : access Bodies_Array_T)
   --  return Body_Access_T;

   --  QUESTION 3 - Part 1: Modify Init_Body with the following profile
   --    procedure Init_Body
   --      (B            : Body_Access_T;
   --       Radius       : Float;
   --       Color        : Color_T;
   --       Distance     : Float;
   --       Angle        : Float;
   --       Speed        : Float;
   --       Turns_Around : Body_Access_T;
   --       Visible      : Boolean := True);
   procedure Init_Body
     (B            :        Bodies_Enum_T;
      Bodies       : in out Bodies_Array_T;
      Radius       :        Float;
      Color        :        Color_T;
      Distance     :        Float;
      Angle        :        Float;
      Speed        :        Float;
      Turns_Around :        Bodies_Enum_T;
      Visible      :        Boolean := True);

   procedure Move_All (Bodies : in out Bodies_Array_T);

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
      --  QUESTION 4: Modify Turns_Around as an access to Body_T using
      --  Body_Access_T type
      Turns_Around : Bodies_Enum_T := Sun;
   end record;

   --  define type Bodies_Array_T as an array of Body_T indexed by bodies
   --  enumeration
   type Bodies_Array_T is array (Bodies_Enum_T) of Body_T;

   --  QUESTION 5: Modify the Move procedure with the following profile
   --  procedure Move (Body_To_Move : Body_Access_T);
   procedure Move (Bodies : in out Bodies_Array_T; B : Bodies_Enum_T);
end Solar_System;
