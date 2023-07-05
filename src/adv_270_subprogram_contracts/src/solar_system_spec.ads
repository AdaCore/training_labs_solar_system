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

with Float_Maths;       use Float_Maths;
with Vector_Maths;      use Vector_Maths;
with Vector_Maths.Trig; use Vector_Maths.Trig;
with Ada.Numerics;

package Solar_System_Spec is
   --  Requirements of the Solar System are formalized into a specification,
   --  which is defined in this package.

   --  This package contains Pure functions that have no side effect or
   --  globals.
   pragma Pure (Solar_System_Spec);

   --  As additional constraint, all functions defined here return Boolean
   --  and don't raise exceptions (so they can't have contracts)

   --  Placeholder for questions
   Not_Implemented : constant Boolean := True;

   ---------------------
   -- General Helpers --
   ---------------------

   Pi : constant Float := Ada.Numerics.Pi;
   Pi_2 : constant Float := Pi * 2.0;

   --  Question 1.a: Implement the Epsilon constant.

   --  Question 1.b: Implement the following function, which checks that two
   --  floats are equal, to an epsilon.
   --  That is Equal_To_An_Epsilon (2.0, 2.0 + 2.0 * Epsilon) = True
   function Almost_Equal (X, Y : Float) return Boolean
      is (Not_Implemented);

   ----------------
   -- Attributes --
   ----------------

   --  Question 2.a
   --  Add three subtypes to handle Floats:
   --  - one for those that are > 0.0
   --  - one for those that are >= 0.0
   --  - one for those that are >= 0.0 and <= 2 * PI

   --  Rounds the angle so that it stay in [0.0, 2.0 * Pi [
   --  Deduced from a = b * floor (a / b) + mod (a, b)
   --  <=> mod (a, b) = a - b * floor (a / b)
   function Round_Angle (Raw_Angle : Float) return Float
      is (Raw_Angle - (Pi_2 * Float'Floor (Raw_Angle / Pi_2)));

   --  Question 2.b
   --  Implement the function for the visibility contract
   --  - Visible bodies have a radius which is stricly positive
   --  - Invisible bodies have the Black color, and a null radius, by
   --    convention
   function Body_Is_Visible_Or_Has_Default_Appearance
      (Visible : Boolean; Black : Boolean; Radius : Float)
     return Boolean
      is (Not_Implemented);

   -----------------------
   -- Orbital Movements --
   -----------------------

   --  Requirement: Matching coordinates
   --  The X and Y coordinates of orbiting bodies must match their distance
   --  and angle at any point in the program execution.

   --  Question 5.a: Implement the function to check distances:
   --    Distance = Sqrt ((X - Xcenter) ** 2 + (Y - Ycenter) ** 2)
   function Distance_Matches
     (X_Coordinate, Y_Coordinate : Float;
      X_Center_Coordinate, Y_Center_Coordinate : Float;
      Distance : Float)
     return Boolean
      is (Not_Implemented);

   --  Question 5.b: Nothing to do for angle, the function is already
   --  implemented.

   --  Function to check angles
   function Angle_Matches
     (X_Coordinate, Y_Coordinate : Float;
      X_Center_Coordinate, Y_Center_Coordinate : Float;
      Angle : Float)
     return Boolean
      is (
         --  FIXME multiples of Pi are degenerate case,
         --  due to Angle_With_X implementation
         abs (Angle) <= 1.0e-1
         or else abs (abs (Angle) - Ada.Numerics.Pi) <= 1.0e-1
         or else abs (abs (Angle) - 2.0 * Ada.Numerics.Pi) <= 1.0e-1
         or else Almost_Equal
            (Angle, Angle_With_X
               (Real_Vector'
                  (1 => X_Coordinate - X_Center_Coordinate,
                   2 => Y_Coordinate - Y_Center_Coordinate))));

   type Orbiting_Object is record
      Angle : Float;
      Speed : Float;
      Distance : Float;
   end record;

   --  Requirement: Moving only changes the angle
   --  Implement the check
   function Has_Moved_One_Step (Old_Object, New_Object : Orbiting_Object)
      return Boolean
      is (Not_Implemented);

   --  Requirement: Absence of cycles in the orbits

   --  The solar system should not have any cycle in the way bodies turn
   --  around one another.
   --  That is, if A Orbits around B, then B should not orbit around A or
   --  orbit around a body which itself Orbits around A, even indirectly.

   --  Declaration of the simplified model of our solar system
   subtype Body_Id is Positive;

   --  Each entry is simply the body that the index uses as center of rotation.
   --  e.g. We would describe our own as
   --  Orbit_Centers'(Earth => Sun, Moon => Earth, ...)
   type Orbit_Centers is array (Body_Id range <>) of Body_Id;

   --  Question
   --  Implement the function which detects if a body is rotating around
   --  another one, or instead does not orbit.
   --  By convention, an object does not orbit around another one if it is
   --  described as rotating around itself.
   function Does_Orbit (X : Body_Id; Turns_Around : Body_Id) return Boolean
      is (Not_Implemented);

   --  Question
   --  Implement the function, which verifies that the attributes of the
   --  body are correct, depending on whether it orbits or not.
   function Body_Orbits_Or_Has_Zero_Orbit
      (Orbits : Boolean;
       Distance, Angle, Speed : Float) return Boolean
      is (Not_Implemented);

   --  Question
   --  Implement the function, which detects recursively if an object Orbits
   --  around another one.
   --  That is if Orbits (A, B) and Orbits (B, C) then Orbits (A, C)
   --
   --  Tip: Using recursivity can simplify the algorithm, and it's mostly OK
   --  for contracts...
   function Orbits (All_Turns_Around : Orbit_Centers; X, Y : Body_Id)
      return Boolean
      is (Not_Implemented);

   --  Question 7.a
   --  Implement the function, which detects a cycle in the rotation order
   --  Since we don't want cycles, we return True when there are none, which
   --  mean our solar system is correct.
   --  e.g. for any A and B, there is not both Orbits (A, B) and Orbits (B, A)
   function No_Cycle (All_Turns_Around : Orbit_Centers) return Boolean
      is (Not_Implemented);
end Solar_System_Spec;
