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

--$ begin question
--  QUESTION - Bonus: Remove once lab is done
pragma Warnings (Off,
   "no entities of ""Float_Maths"" are referenced");
pragma Warnings (Off,
   "use clause for package ""Float_Maths"" has no effect");
pragma Warnings (Off, "not referenced");
--$ end question
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

   --$ begin question
   --  Placeholder for questions
   Not_Implemented : constant Boolean := True;

   --$ end question
   ---------------------
   -- General Helpers --
   ---------------------

   Pi : constant Float := Ada.Numerics.Pi;
   Pi_2 : constant Float := Pi * 2.0;

   --  QUESTION 1 - Part 1
   --  Implement the Epsilon constant.
   --$ line answer
   Epsilon : constant Float := 1.0e-5;

   --  QUESTION 1 - Part 2
   --  Implement the following function, which checks that two
   --  floats are equal, to an epsilon.
   --  Error (= X - Y) must be inferior to X * Epsilon
   function Almost_Equal (X, Y : Float) return Boolean
   --$ line question
      is (Not_Implemented);
   --$ begin answer
      is (abs (X - Y) <= abs (X) * Epsilon);
      --  NB: Could also use `<`, this is an implementation detail not covered
      --  by the spec
   --$ end answer

   ----------------
   -- Attributes --
   ----------------

   --  QUESTION 2 - Part 1
   --  Add three subtypes to handle Floats:
   --  - one for those that are > 0.0
   --  - one for those that are >= 0.0
   --  - one for those that are >= 0.0 and <= 2 * PI
   --$ begin answer
   subtype Positive_Float is Float range Float'Succ (0.0) .. Float'Last;
   subtype Natural_Float is Float range 0.0 .. Float'Last;
   subtype Mod2Pi_Float is Float range 0.0 .. Float'Pred (Pi_2);
   --$ end answer

   --  Rounds the angle so that it stays in (0.0, 2.0 * Pi(
   --  Deduced from a = b * floor (a / b) + mod (a, b)
   --  <=> mod (a, b) = a - b * floor (a / b)
   --$ line question
   function Round_Angle (Raw_Angle : Float) return Float
   --$ line answer
   function Round_Angle (Raw_Angle : Float) return Mod2Pi_Float
      is (Raw_Angle - (Pi_2 * Float'Floor (Raw_Angle / Pi_2)));

   --  QUESTION 2 - Part 2
   --  Implement the function for the visibility contract
   --  - Visible bodies have a radius which is stricly positive
   --  - Invisible bodies have the Black color, and a null radius, by
   --    convention
   function Body_Is_Visible_Or_Has_Default_Appearance
   --$ line question
      (Visible : Boolean; Black : Boolean; Radius : Float)
   --$ line answer
      (Visible : Boolean; Black : Boolean; Radius : Natural_Float)
     return Boolean
   --$ line question
      is (Not_Implemented);
   --$ begin answer
      is (if Visible
         then Radius in Positive_Float
         else Black and then Radius = 0.0);
   --$ end answer

   -----------------------
   -- Orbital Movements --
   -----------------------

   --  Requirement: Matching coordinates
   --  The X and Y coordinates of orbiting bodies must match their distance
   --  and angle at any point in the program execution.

   --  QUESTION 5 - Part 1
   --  Implement the function to check distances:
   --    Distance = Sqrt ((X - Xcenter) ** 2 + (Y - Ycenter) ** 2)
   function Distance_Matches
     (X_Coordinate, Y_Coordinate : Float;
      X_Center_Coordinate, Y_Center_Coordinate : Float;
   --$ begin question
      Distance : Float)
     return Boolean
      is (Not_Implemented);
   --$ end question
   --$ begin answer
      Distance : Positive_Float)
     return Boolean
      is (Almost_Equal
            (Distance,
            Sqrt
               ((X_Coordinate - X_Center_Coordinate) ** 2 +
                (Y_Coordinate - Y_Center_Coordinate) ** 2)));
   --$ end answer

   --  QUESTION 5 - Part 2
   --  Nothing to do for angle, the function is already
   --  implemented.

   --  Function to check angles
   function Angle_Matches
     (X_Coordinate, Y_Coordinate : Float;
      X_Center_Coordinate, Y_Center_Coordinate : Float;
      --$ line question
      Angle : Float)
      --$ line answer
      Angle : Mod2Pi_Float)
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
   --$ line question
      is (Not_Implemented);
   --$ begin answer
      is (New_Object.Angle = Round_Angle (Old_Object.Angle + Old_Object.Speed)
          and then New_Object.Speed = Old_Object.Speed
          and then New_Object.Distance = Old_Object.Distance);
   --$ end answer

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

   --  QUESTION 5 - Part 3
   --  Implement the function which detects if a body is in rotation around
   --  another one, or instead does not orbit at all.
   --  By convention, an object does not orbit around another one if it is
   --  described as rotating around itself.
   function Does_Orbit (X : Body_Id; Turns_Around : Body_Id) return Boolean
   --$ line question
      is (Not_Implemented);
   --$ line answer
      is (X /= Turns_Around);

   --  QUESTION 5 - Part 4
   --  Implement the function, which verifies that the attributes of the
   --  body are correct, depending on whether it orbits or not.
   function Body_Orbits_Or_Has_Zero_Orbit
      (Orbits : Boolean;
   --$ begin question
       Distance, Angle, Speed : Float) return Boolean
      is (Not_Implemented);
   --$ end question
   --$ begin answer
       Distance : Natural_Float;
       Angle : Mod2Pi_Float;
       Speed : Float) return Boolean
      is (if Orbits
          then Distance in Positive_Float and then Speed /= 0.0
          else Distance = 0.0 and then Angle = 0.0 and then Speed = 0.0);

   --  For question 10
   function Body_Orbits
      (X : Body_Id;
       Turns_Around : Body_Id;
       Speed : Float) return Boolean
      is (Does_Orbit (X, Turns_Around) and then Speed /= 0.0);
   --$ end answer

   --  QUESTION 6
   --  Implement the function, which detects recursively if an object Orbits
   --  around another one that is given.
   --  That is if Orbits (A, B) and Orbits (B, C) then Orbits (A, C)
   --
   --  Tip: Using recursivity can simplify the algorithm, and it's mostly OK
   --  for contracts...
   function Orbits (All_Turns_Around : Orbit_Centers; X, Y : Body_Id)
      return Boolean
   --$ line question
      is (Not_Implemented);
   --$ begin answer
      is (Does_Orbit (X, All_Turns_Around (X))
          and then
             (All_Turns_Around (X) = Y
              or else Orbits
                (All_Turns_Around, All_Turns_Around (X), Y)));
   --$ end answer

   --  QUESTION 7 - Part 1
   --  Implement the function, which detects a cycle in the rotation order
   --  Since we don't want cycles, we return True when there are none, which
   --  mean our solar system is correct.
   --  e.g. for any A and B, there is not both Orbits (A, B) and Orbits (B, A)
   function No_Cycle (All_Turns_Around : Orbit_Centers) return Boolean
   --$ line question
      is (Not_Implemented);
   --$ begin answer
      is (for all X in All_Turns_Around'Range
          => not Orbits (All_Turns_Around, All_Turns_Around (X), X));
   --$ end answer
end Solar_System_Spec;
