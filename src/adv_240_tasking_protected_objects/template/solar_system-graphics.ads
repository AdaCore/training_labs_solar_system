with Mage.Draw; use Mage.Draw;

package Solar_System.Graphics is

   --$ line question
   procedure Draw_All (Bodies : Bodies_Array_T; Canvas : Canvas_ID);
   --$ line answer
   procedure Draw_All (Canvas : Canvas_ID);

private

   procedure Draw_Body (Object : Body_T; Canvas : Canvas_ID);

end Solar_System.Graphics;
