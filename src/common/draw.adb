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

with Draw.Config;
with SDL;
with Mage;
with Mage.Draw;
with Mage.Event;
with Mage.Model;
with TSV_Render;

package body Draw is
   package M renames Standard.Mage;

   subtype Color_No_Black_T is Color_T
      range Color_T'First .. Color_T'Pred (Black);

   function "+" (Color : Color_No_Black_T) return TSV_Render.RGBA_T is
      (case Color is
         when Yellow => TSV_Render.Yellow,
         when Blue   => TSV_Render.Blue,
         when White  => TSV_Render.White,
         when Red    => TSV_Render.Red,
         when Cyan   => TSV_Render.Cyan,
         when Green  => TSV_Render.Green,
         when Orange => TSV_Render.Orange);

   function "+" (Color : Color_T) return M.RGBA_T is
      (case Color is
         when Yellow => M.Yellow,
         when Blue   => M.Blue,
         when White  => M.White,
         when Red    => M.Red,
         when Cyan   => M.Cyan,
         when Green  => M.Green,
         when Orange  => (255, 150, 0, 255),
         when Black  => M.Black);

   function "+" (Color : Point_T) return M.Model.Point_3d is
      (Color.X, Color.Y, 0.0);

   Initialized : Boolean := False;

   type State_T (Backend : Backend_T) is record
      case Backend is
      when TSV =>
         TSV_Window : TSV_Render.Window_ID;
         TSV_Canvas : TSV_Render.Canvas_ID;
      when Mage =>
         Mage_Window : M.Draw.Window_ID;
         Mage_Canvas : M.Draw.Canvas_ID;
      end case;
   end record;

   State : State_T (Draw.Config.Backend);

   procedure Create_Window (Width, Height : Positive; Name : String) is
   begin
      pragma Assert (not Initialized, "Cannot create multiple windows");
      case State.Backend is
      when TSV =>
         SDL.Finalise;
         State.TSV_Window := TSV_Render.Create_Window (Width, Height, Name);
         State.TSV_Canvas := TSV_Render.Get_Canvas (State.TSV_Window);
      when Mage =>
         State.Mage_Window := M.Draw.Create_Window (Width, Height, Name);
         State.Mage_Canvas := M.Draw.Get_Canvas (State.Mage_Window);
      end case;
      Initialized := True;
   end Create_Window;

   procedure Draw_Sphere (Position : Point_T;
                          Radius : Float;
                          Color : Color_T) is
   begin
      case State.Backend is
      when TSV =>
         TSV_Render.Draw_Sphere (State.TSV_Canvas, +Position, Radius, +Color);
      when Mage =>
         M.Draw.Draw_Sphere (State.Mage_Canvas, +Position, Radius, +Color);
      end case;
   end Draw_Sphere;

   function Running return Boolean is
      (case State.Backend is
      when TSV =>
         not TSV_Render.Is_Killed,
      when Mage =>
         not M.Event.Is_Killed);

   procedure New_Frame is
   begin
      case State.Backend is
      when TSV =>
         TSV_Render.Handle_Events (State.TSV_Window);
      when Mage =>
         M.Event.Handle_Events (State.Mage_Window);
      end case;
   end New_Frame;

end Draw;
