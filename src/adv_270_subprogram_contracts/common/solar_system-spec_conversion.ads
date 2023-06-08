with Solar_System_Spec;

private package Solar_System.Spec_Conversion is
   --  This package is in charge of providing "glue" between
   --  the spec's model, and the applicative code.

   function To_Body_Id (E : Bodies_Enum_T) return Solar_System_Spec.Body_Id;

   function To_Orbiting_Object (B : Body_T) return Orbiting_Object;

   function To_Orbit_Centers
     (A : Bodies_Array_T) return Solar_System_Spec.Orbit_Centers;

end Solar_System.Spec_Conversion;
