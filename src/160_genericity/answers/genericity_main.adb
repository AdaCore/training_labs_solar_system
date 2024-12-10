-----------------------------------------------------------------------
--                              Ada Labs                             --
--                                                                   --
--                 Copyright (C) 2008-2024, AdaCore                  --
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

with Ada.Real_Time;         use Ada.Real_Time;

with Solar_System;
with Draw;                  use Draw;
with Solar_System.Graphics;

procedure Genericity_Main is
   type Bodies_Enum_1_T is (Sun1, Earth);
   type Bodies_Enum_2_T is (Sun2, Jupiter);

   package My_Solar_System1 is new Solar_System (Bodies_Enum_1_T);
   package My_Sol_Sys_Graphics1 is new My_Solar_System1.Graphics;
   use My_Solar_System1;
   use My_Sol_Sys_Graphics1;

   package My_Solar_System2 is new Solar_System (Bodies_Enum_2_T);
   package My_Sol_Sys_Graphics2 is new My_Solar_System2.Graphics;
   use My_Solar_System2;
   use My_Sol_Sys_Graphics2;

   --  declare variable Bodies which is an array of Body_T
   Bodies1 : My_Solar_System1.Bodies_Array_T;
   Bodies2 : My_Solar_System2.Bodies_Array_T;

   Next : Time;

   Period : constant Time_Span := Milliseconds (40);

begin

   Create_Window (Width => 240, Height => 320, Name => "Solar System");

   --  initialize Bodies using Init_Body procedure
   Init_Body
     (B            => Sun1,
      Bodies       => Bodies1,
      Radius       => 20.0,
      Color        => Yellow,
      Distance     => 0.0,
      Angle        => 0.0,
      Speed        => 0.0,
      Turns_Around => Sun1);

   Init_Body
     (B            => Earth,
      Bodies       => Bodies1,
      Radius       => 5.0,
      Color        => Blue,
      Distance     => 50.0,
      Angle        => 0.0,
      Speed        => 0.02,
      Turns_Around => Sun1);

   Init_Body
     (B            => Sun2,
      Bodies       => Bodies2,
      Radius       => 20.0,
      Color        => Yellow,
      Distance     => 0.0,
      Angle        => 0.0,
      Speed        => 0.0,
      Turns_Around => Sun2);

   Init_Body
     (B            => Jupiter,
      Bodies       => Bodies2,
      Radius       => 10.0,
      Color        => Orange,
      Distance     => 80.0,
      Angle        => 180.0,
      Speed        => 0.01,
      Turns_Around => Sun2);

   Set_Center (Bodies1, -30.0, -30.0);
   Set_Center (Bodies2, 50.0, 50.0);

   Init_Body
     (B            => Jupiter,
      Bodies       => Bodies2,
      Radius       => 10.0,
      Color        => Orange,
      Distance     => 80.0,
      Angle        => 180.0,
      Speed        => 0.01,
      Turns_Around => Sun2);

   Set_Center (Bodies1, -30.0, -30.0);
   Set_Center (Bodies2, 50.0, 50.0);

   Next := Clock + Period;

   while Running loop
      Move_All (Bodies1);
      Move_All (Bodies2);

      Draw_All (Bodies1);
      Draw_All (Bodies2);

      New_Frame;

      delay until Next;
      Next := Next + Period;
   end loop;

end Genericity_Main;
