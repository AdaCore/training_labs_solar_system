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

with Ada.Real_Time; use Ada.Real_Time;
with Mage;          use Mage;
with Mage.Draw;     use Mage.Draw;
with Mage.Event;    use Mage.Event;
with Float_Maths;   use Float_Maths;

procedure Subprograms_Main is

   --  define type Bodies_Enum_T and Rotating_Bodies_T
   type Bodies_Enum_T is (Sun, Earth, Moon, Satellite, Comet);
   subtype Rotating_Bodies_T is Bodies_Enum_T
      range Earth .. Bodies_Enum_T'Last;

   --  define a type Body_T to store every information about a body
   --   X, Y, Distance, Speed, Angle, Color, Radius
   type Body_T is record
      X            : Float := 0.0;
      Y            : Float := 0.0;
      Distance     : Float;
      Speed        : Float;
      Angle        : Float;
      Color        : RGBA_T;
      Radius       : Float;
      Turns_Around : Bodies_Enum_T;
   end record;

   --  define type Bodies_Array as an array of Body_Type indexed by
   --  bodies enumeration
   type Bodies_Array_T is array (Bodies_Enum_T) of Body_T;

   --  declare variable Bodies which is an array of Body_Type
   Bodies : Bodies_Array_T;

   --  declare a variable Next of type Time to store the Next step time
   Next : Time;

   --  declare a constant Period of 40 milliseconds of type Time_Span defining
   --  the loop period
   Period : constant Time_Span := Milliseconds (40);

   --  reference to the application window
   Window : Window_ID;

   --  reference to the graphical canvas associated with the application window
   Canvas : Canvas_ID;

   --  QUESTION 1 - Part 1
   --  implement a function to compute the X coordinate
   --  x of the reference + distance * cos(angle)

   function Compute_X
     (Body_To_Move : Body_T;
      Turns_Around : Body_T) return Float
   is
   begin
      return Turns_Around.X + Body_To_Move.Distance * Cos (Body_To_Move.Angle);
   end Compute_X;

   --  QUESTION 1 - Part 2
   --  implement a function to compute the Y coordinate
   --  y of the reference + distance * sin(angle)

   function Compute_Y
     (Body_To_Move : Body_T;
      Turns_Around : Body_T) return Float
   is
   begin
      return Turns_Around.Y + Body_To_Move.Distance * Sin (Body_To_Move.Angle);
   end Compute_Y;

   --  QUESTION 2 - Part 1
   --  move a given body over one time step

   procedure Move
     (Bodies : in out Bodies_Array_T; Body_To_Move_Index : Bodies_Enum_T) is
      Body_To_Move : Body_T renames Bodies (Body_To_Move_Index);
      Turns_Around : constant Body_T := Bodies (Body_To_Move.Turns_Around);
   begin
      Body_To_Move.X :=
        Compute_X (Body_To_Move, Turns_Around);

      Body_To_Move.Y :=
        Compute_Y (Body_To_Move, Turns_Around);

      Body_To_Move.Angle := Body_To_Move.Angle + Body_To_Move.Speed;
   end Move;

   --  QUESTION 3
   procedure Draw_Body (Object : Body_T; Canvas : Canvas_ID) is
   begin
      Draw_Sphere
        (Canvas   => Canvas,
         Position => (Object.X, Object.Y, 0.0),
         Radius   => Object.Radius,
         Color    => Object.Color);
   end Draw_Body;

begin

   --  create the main window
   Window :=
     Create_Window (Width => 240, Height => 320, Name => "Solar System");
   --  retrieve the graphical canvas associated with the main window
   Canvas := Get_Canvas (Window);

   --  QUESTION 4 - Add a comet
   --    Tip: Make it a body that is drawn as several circles that
   --    follow each others.
   Bodies :=
     (Sun =>
        (Distance     => 0.0,
         Speed        => 0.0,
         Radius       => 20.0,
         X            => 0.0,
         Y            => 0.0,
         Angle        => 0.0,
         Color        => Yellow,
         Turns_Around => Sun),
      Earth =>
        (Distance     => 50.0,
         Speed        => 0.02,
         Radius       => 5.0,
         X            => 0.0,
         Y            => 0.0,
         Angle        => 0.0,
         Color        => Blue,
         Turns_Around => Sun),
      Moon =>
        (Distance     => 15.0,
         Speed        => 0.04,
         Radius       => 2.0,
         X            => 0.0,
         Y            => 0.0,
         Angle        => 0.0,
         Color        => White,
         Turns_Around => Earth),
      Satellite =>
        (Distance     => 8.0,
         Speed        => 0.1,
         Radius       => 1.0,
         X            => 0.0,
         Y            => 0.0,
         Angle        => 0.0,
         Color        => Red,
         Turns_Around => Earth),
      Comet =>
        (Distance     => 80.0,
         Angle        => 0.0,
         Speed        => 0.05,
         Radius       => 1.0,
         X            => 0.0,
         Y            => 0.0,
         Color        => Yellow,
         Turns_Around => Sun));

   --  initialize the Next step time as the current time (Clock) + the period
   Next := Clock + Period;

   while not Is_Killed loop

      for B in Rotating_Bodies_T loop
         --  call the move procedure for each body
         Move (Bodies, B);
      end loop;

      for B in Bodies_Enum_T loop
         --  draw each body
         Draw_Body (Bodies (B), Canvas);
      end loop;

      Handle_Events (Window);

      --  wait until Now + Period time elapsed before the next
      delay until Next;
      Next := Next + Period;
   end loop;

end Subprograms_Main;
