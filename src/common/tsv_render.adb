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

with Ada.Text_IO; use Ada.Text_IO;
with GNAT.Traceback.Symbolic;
with Ada.Characters.Latin_1;
with Vector_Maths_Trig;
with Float_Maths;
with Ada.Numerics;
with Ada.Exceptions;
with Ada.IO_Exceptions;

package body TSV_Render is
   Inner_Canvas : Canvas_T;

   function Create_Window
     (Width, Height : Positive; Name : String) return Window_ID
   is
      pragma Unreferenced (Width, Height, Name);
   begin
      Inner_Canvas :=
        (Spheres     => (others => <>),
         Number_Of_Spheres => 0,
         Frame_Count => 0);
      return (null record);
   end Create_Window;

   function Get_Canvas (W : Window_ID) return Canvas_ID is
      pragma Unreferenced (W);
   begin
      return (null record);
   end Get_Canvas;

   procedure Append (Canvas : in out Canvas_T; S : Sphere_T) is
   begin
      Canvas.Number_Of_Spheres := Canvas.Number_Of_Spheres + 1;
      Canvas.Spheres (Canvas.Number_Of_Spheres) := S;
   end Append;

   procedure Empty (Canvas : in out Canvas_T) is
   begin
      Canvas.Number_Of_Spheres := 0;
   end Empty;

   Tab : constant Character := Ada.Characters.Latin_1.HT;

   procedure Put_Line_TSV
     (Color : RGBA_T; Radius : Float; Angle : Float; Distance : Float)
   is
   begin
      Put_Line
        (RGBA_T'Image (Color)
         & Tab & Integer'Image (Integer (Radius))
         & Tab & Integer'Image (Integer (Angle))
         & Tab & Integer'Image (Integer (Distance)));
   end Put_Line_TSV;

   type Polar_Coords_T is record
      Angle_Deg, Distance : Float;
   end record;

   function To_Degrees (R : Vector_Maths_Trig.Real_Angle_Radians) return Float
   is
   begin
      return 360.0 * R / (2.0 * Ada.Numerics.Pi);
   end To_Degrees;

   function As_Polar (C : Point_3d) return Polar_Coords_T is
      --  on X, Y plane
      Angle_To_X : constant Vector_Maths_Trig.Real_Angle_Radians
        := Vector_Maths_Trig.Angle_With_X ((C.X, C.Y));
   begin
      return
        (Angle_Deg => To_Degrees (Angle_To_X),
         Distance  => Float_Maths.Sqrt (C.X**2 + C.Y**2));
   end As_Polar;

   procedure Print_Out_TSV (S : Sphere_T) is
      Polar : constant Polar_Coords_T := As_Polar (S.Position);
   begin
      Put_Line_TSV (S.Color, S.Radius, Polar.Angle_Deg, Polar.Distance);
   end Print_Out_TSV;

   procedure Print_Out_TSV (Canvas : Canvas_T) is
   begin
      Put_Line ("Frame" & Tab & Natural'Image (Canvas.Frame_Count));

      Put_Line ("Color" & Tab & "Radius" & Tab & "Angle" & Tab & "Distance");
      for S of Canvas.Spheres (1 .. Canvas.Number_Of_Spheres) loop
         Print_Out_TSV (S);
      end loop;
   end Print_Out_TSV;

   procedure Draw_Sphere
     (Canvas : Canvas_ID; Position : Point_3d; Radius : Float;
      Color  : RGBA_T)
   is
      pragma Unreferenced (Canvas);
   begin
      Append (Inner_Canvas, Sphere_T'(Position, Radius, Color));
   end Draw_Sphere;

   procedure Handle_Events (W : in out Window_ID) is
      pragma Unreferenced (W);
   begin
      Inner_Canvas.Frame_Count := Inner_Canvas.Frame_Count + 1;
      Print_Out_TSV (Inner_Canvas);
      Empty (Inner_Canvas);
   end Handle_Events;

   task body Input_Capture is
   begin
      select
         accept Start;
      or
         accept Quit do
            Is_Killed := True;
         end Quit;
      end select;

      while not Is_Killed loop
         Put_Line ("Q<enter> to quit");
         declare
            I : constant String := Get_Line;
         begin
            if I'Length = 1 and then I = "Q" then
               Is_Killed := True;
            end if;
         end;
      end loop;
   exception
      when Ada.IO_Exceptions.End_Error =>
         Is_Killed := True;
      when E : others =>
         Is_Killed := True;
         Ada.Text_IO.Put_Line (Ada.Exceptions.Exception_Name (E));
         Ada.Text_IO.Put_Line (GNAT.Traceback.Symbolic.Symbolic_Traceback (E));
   end Input_Capture;
end TSV_Render;
