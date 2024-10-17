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

package body Solar_System.Graphics is

   overriding function Get_X (Drawable : Visible_Body_Decorator_T)
      return Float is
   begin
      return Drawable.Object_Ptr.Get_X;
   end Get_X;

   overriding function Get_Y (Drawable : Visible_Body_Decorator_T)
      return Float is
   begin
      return Drawable.Object_Ptr.Get_Y;
   end Get_Y;

   overriding procedure Move (B : in out Visible_Orbiting_Body_T) is
   begin
      if B.Object_Ptr.all in Movable_I'Class then
         Movable_I'Class (B.Object_Ptr.all).Move;
      end if;
   end Move;

   function Create_Visible
     (B : access Orbiting_Body_T; Radius : Float; Color : Color_T)
      return access Visible_Orbiting_Body_T
   is
   begin
      return
        new Visible_Orbiting_Body_T'
          (Graphic => (Radius => Radius, Color => Color), Object_Ptr => B);
   end Create_Visible;

   function Create_Visible
     (B : access Still_Body_T; Radius : Float; Color : Color_T)
      return access Visible_Still_Body_T
   is
   begin
      return
        new Visible_Still_Body_T'
          (Graphic => (Radius => Radius, Color => Color), Object_Ptr => B);
   end Create_Visible;

   overriding procedure Draw
      (Drawable : Visible_Body_Decorator_T) is
   begin
      Draw_Sphere
        (Position => (Drawable.Object_Ptr.X, Drawable.Object_Ptr.Y),
         Radius   => Drawable.Graphic.Radius, Color => Drawable.Graphic.Color);
   end Draw;

   function Create_Visible
     (S : access Solar_System_T) return access Visible_Solar_System_T
   is
   begin
      return new Visible_Solar_System_T'(Object_Ptr => S);
   end Create_Visible;

   overriding procedure Draw
      (Drawable : Visible_Solar_System_T) is
   begin
      for B of Drawable.Object_Ptr.Still_Objects loop
         if Still_Body_I'Class (B.all) in Drawable_I'Class then
            Drawable_I'Class (Still_Body_I'Class (B.all)).Draw;
         end if;
      end loop;
      for B of Drawable.Object_Ptr.Moving_Objects loop
         if Movable_I'Class (B.all) in Drawable_I'Class then
            Drawable_I'Class (Movable_I'Class (B.all)).Draw;
         end if;
      end loop;
   end Draw;

   overriding procedure Move (B : in out Visible_Solar_System_T) is
   begin
      B.Object_Ptr.Move;
   end Move;

   overriding procedure Add_Still_Body
     (S : in out Visible_Solar_System_T; B : access Still_Body_I'Class)
   is
   begin
      S.Object_Ptr.Add_Still_Body (B);
   end Add_Still_Body;

   overriding procedure Add_Moving_Body
     (S : in out Visible_Solar_System_T; B : access Movable_I'Class)
   is
   begin
      S.Object_Ptr.Add_Moving_Body (B);
   end Add_Moving_Body;

end Solar_System.Graphics;
