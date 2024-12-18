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

with Ada.Real_Time;         use Ada.Real_Time;
with Draw;             use Draw;
with Solar_System;          use Solar_System;
with Solar_System.Graphics; use Solar_System.Graphics;
with My_Solar_System;       use My_Solar_System;
--$ begin answer

--  We need an explicit dependency to this exported package
--  so that it is compiled in, even if we don't use it
with Ada_Float_Maths;
pragma Elaborate (Ada_Float_Maths);
pragma Unreferenced (Ada_Float_Maths);
--$ end answer

procedure Interfacing_With_C_Main is

   Next : Time;
   Period : constant Time_Span := Milliseconds (40);

begin

   Create_Window (Width => 240, Height => 320, Name => "Solar System");

   Init_Body
     (B            => Get_Body (Sun, Bodies'Access),
      Radius       => 20.0,
      Color        => Yellow,
      Distance     => 0.0,
      Angle        => 0.0,
      Speed        => 0.0,
      Turns_Around => Get_Body (Sun, Bodies'Access));

   Init_Body
     (B            => Get_Body (Earth, Bodies'Access),
      Radius       => 5.0,
      Color        => Blue,
      Distance     => 50.0,
      Angle        => 0.0,
      Speed        => 0.02,
      Turns_Around => Get_Body (Sun, Bodies'Access));

   Init_Body
     (B            => Get_Body (Moon, Bodies'Access),
      Radius       => 2.0,
      Color        => Blue,
      Distance     => 15.0,
      Angle        => 0.0,
      Speed        => 0.04,
      Turns_Around => Get_Body (Earth, Bodies'Access));

   Init_Body
     (B            => Get_Body (Satellite, Bodies'Access),
      Radius       => 1.0,
      Color        => Red,
      Distance     => 8.0,
      Angle        => 0.0,
      Speed        => 0.1,
      Turns_Around => Get_Body (Earth, Bodies'Access));

   Init_Body
     (B            => Get_Body (Comet, Bodies'Access),
      Radius       => 1.0,
      Color        => Yellow,
      Distance     => 80.0,
      Angle        => 0.0,
      Speed        => 0.05,
      Turns_Around => Get_Body (Sun, Bodies'Access));

   Init_Body
     (B            => Get_Body (Black_Hole, Bodies'Access),
      Radius       => 0.0,
      Color        => Blue,
      Distance     => 75.0,
      Angle        => 0.0,
      Speed        => -0.02,
      Turns_Around => Get_Body (Sun, Bodies'Access),
      Visible      => False);

   Init_Body
     (B            => Get_Body (Asteroid_1, Bodies'Access),
      Radius       => 1.0,
      Color        => Green,
      Distance     => 5.0,
      Angle        => 0.0,
      Speed        => 0.1,
      Turns_Around => Get_Body (Black_Hole, Bodies'Access));

   Init_Body
     (B            => Get_Body (Asteroid_2, Bodies'Access),
      Radius       => 1.0,
      Color        => Yellow,
      Distance     => 5.0,
      Angle        => 3.14,
      Speed        => 0.1,
      Turns_Around => Get_Body (Black_Hole, Bodies'Access));

   Next := Clock + Period;

   while Running loop
      Move_All (Bodies'Access);
      Draw_All (Bodies);
      New_Frame;

      delay until Next;
      Next := Next + Period;
   end loop;

end Interfacing_With_C_Main;
