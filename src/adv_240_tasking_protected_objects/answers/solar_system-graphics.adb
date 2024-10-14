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

package body Solar_System.Graphics is

   procedure Draw_Body (Object : Body_T) is
      Tail_Color : constant Color_T := Object.Color;
   begin
      if Object.Visible then
         Draw_Sphere
           (Position => (Object.Pos.X, Object.Pos.Y),
            Radius   => Object.Radius,
            Color    => Object.Color);
         if Object.With_Tail then
            for I in reverse Tail_T'First .. Tail_T'Last loop
               Draw_Sphere
                 (Position => (Object.Tail (I).X, Object.Tail (I).Y),
                  Radius   => Object.Radius,
                  Color    => Tail_Color);
            end loop;
         end if;
      end if;
   end Draw_Body;

   procedure Draw_All is
   begin
      for Obj of Bodies loop
         declare
            B : constant Body_T := Obj.Get_Data;
         begin
            if B.Visible then
               Draw_Body (B);
            end if;
         end;
      end loop;
   end Draw_All;

end Solar_System.Graphics;
