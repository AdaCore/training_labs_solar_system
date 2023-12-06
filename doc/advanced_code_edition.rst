.. role:: ada(code)
    :language: ada

========================================
Advanced Code Edition with GNAT Studio
========================================

The purpose of this exercise is to use GNAT Studio's integrated code edition features.

This lab uses the Getting Started lab (default).

----------
Question 1
----------

We want to wrap the call to :ada:`Draw_Sphere` into its own subprogram, and its own package.

Create a :ada:`package Red_Ball` **without its body** from the GNAT Studio project view.

----------
Question 2
----------

In ``red_ball.ads``, declare a new :ada:`procedure Draw_Red_Ball (Canvas : Canvas_ID; X, Y, Radius : Float)`

Try checking the semantics of the file, using the "Check Semantic" button (or option from
the Build menu).

This should fail: GNAT Studio will propose an automatic fix to "qualify" with a package;
run it.

----------
Question 3
----------

Using the GNAT Studio Generate right-click menu, generate a body for the :ada:`package Red_Ball`.

Jump to the body, and copy-paste there the call to :ada:`Draw_Sphere` from
``getting_started_main.adb``.
Rename :ada:`Ball_Radius` to :ada:`Radius`.

Try compiling ``red_ball.adb`` by using Shift+F4. This will fail: use the automatic tip from GNAT
Studio about qualifying :ada:`Draw_Sphere`.

Try recompiling the file; it should work.

Go back to ``getting_started_main.adb``, and replace the call to :ada:`Draw_Sphere` by the
equivalent call to :ada:`Draw_Red_Ball`. Fix any qualification issue using GNAT Studio's autofix.

----------
Question 4
----------

:ada:`Red_Ball.Draw_Red_Ball` is a bit repetitive. Rename it to :ada:`Red_Ball.Draw` using GNAT
Studio's Refactor menu.

----------
Question 5
----------

We want to add a pink circle inside the red ball.
Go to the body of :ada:`Red_Ball.Draw`.

There is no :ada:`Pink` color already defined, declare :ada:`Pink : Mage.RGBA_T`.
Try to compile, use the tip from GNAT Studio so that it inserts :ada:`with Mage` by itself.
Add a value for ``Pink``, type ``:= (`` and in the menu that opens, choose "Aggregate for
RGBA_T". Then complete the template with the values R = 255, G = 100, B = 100, A = 100.

Once this is done, add a call to :ada:`Draw_Circle` after the call to :ada:`Draw_Sphere`.
Use the autocompletion "Params of Mage.Draw.Draw_Circle". The circle radius should be half
that of the sphere.

Finally, compile and use autofix to fix the warning emited by GNAT Studio, and run the
"Code > Format File" command, to reformat the file automatically using ``gnatpp``.
