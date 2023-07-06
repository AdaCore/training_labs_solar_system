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
