package body Solar_System.Graphics is

   --$ begin question
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
   --$ end question
   --$ begin answer
   procedure Draw_Body (Object : Body_T; Canvas : Canvas_ID) is
      Tail_Color : RGBA_T;
      Dimmer : constant Color_Component_T := 30;
      use all type Color_Component_T;

      function Dim (C : Color_Component_T) return Color_Component_T is
      begin
         if C < Dimmer then
            return 0;
         else
            return C - Dimmer;
         end if;
      end Dim;
   begin
      if Object.Visible then
         Draw_Sphere
           (Canvas   => Canvas,
            Position => (Object.Pos.X, Object.Pos.Y, 0.0),
            Radius   => Object.Radius,
            Color    => Object.Color);
         if Object.With_Tail then
            Tail_Color := Object.Color;
            for I in reverse Tail_T'First .. Tail_T'Last loop
               Draw_Sphere
                 (Canvas   => Canvas,
                  Position => (Object.Tail (I).X, Object.Tail (I).Y, 0.0),
                  Radius   => Object.Radius,
                  Color    => Tail_Color);
               Tail_Color.R := Dim (Tail_Color.R);
               Tail_Color.G := Dim (Tail_Color.G);
               Tail_Color.B := Dim (Tail_Color.B);
            end loop;
         end if;
      end if;
   end Draw_Body;

   --$ end answer
   --$ line question
   procedure Draw_All (Bodies : Bodies_Array_T; Canvas : Canvas_ID) is
   --$ line answer
   procedure Draw_All (Canvas : Canvas_ID) is
   begin
      for Obj of Bodies loop
         --$ begin question
         if Obj.Visible then
            Draw_Body (Obj, Canvas);
         end if;
         --$ end question
         --$ begin answer
         declare
            B : constant Body_T := Obj.Get_Data;
         begin
            if B.Visible then
               Draw_Body (B, Canvas);
            end if;
         end;
         --$ end answer
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

