package body Solar_System.Graphics is

   procedure Draw_Body (Object : Body_T; Canvas : Canvas_ID) is
   begin
      if Object.Visible then
         Draw_Sphere
           (Canvas   => Canvas,
            Position => (Object.X, Object.Y, 0.0),
            Radius   => Object.Radius,
            Color    => Object.Color);
      end if;
   end Draw_Body;
   procedure Draw_All (Bodies : Bodies_Array_T; Canvas : Canvas_ID) is
   begin
      for Obj of Bodies loop
         if Obj.Visible then
            Draw_Body (Obj, Canvas);
         end if;
      end loop;
   end Draw_All;

end Solar_System.Graphics;
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
