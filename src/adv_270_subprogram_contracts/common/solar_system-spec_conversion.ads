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

with Solar_System_Spec;

private package Solar_System.Spec_Conversion is
   --  This package is in charge of providing "glue" between
   --  the spec's model, and the applicative code.

   function To_Body_Id (E : Bodies_Enum_T) return Solar_System_Spec.Body_Id;

   function To_Orbiting_Object (B : Body_T) return Orbiting_Object;

   function To_Orbit_Centers
     (A : Bodies_Array_T) return Solar_System_Spec.Orbit_Centers;

end Solar_System.Spec_Conversion;
