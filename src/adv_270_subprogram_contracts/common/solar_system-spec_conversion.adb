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

package body Solar_System.Spec_Conversion is

   function To_Body_Id (E : Bodies_Enum_T) return Solar_System_Spec.Body_Id is
     (Body_Id'First + Bodies_Enum_T'Pos (E));

   function To_Orbiting_Object (B : Body_T) return Orbiting_Object is
     (B.Angle, B.Speed, B.Distance);

   function To_Orbit_Centers
     (A : Bodies_Array_T) return Solar_System_Spec.Orbit_Centers
   is
      Turns_Around :
        Orbit_Centers (To_Body_Id (A'First) .. To_Body_Id (A'Last));
   begin
      for E in A'Range loop
         declare
            Id : constant Body_Id := To_Body_Id (E);
         begin
            Turns_Around (Id) := To_Body_Id (A (E).Turns_Around);
         end;
      end loop;

      return Turns_Around;
   end To_Orbit_Centers;

end Solar_System.Spec_Conversion;
