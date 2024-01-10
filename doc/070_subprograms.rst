.. role:: ada(code)
    :language: ada

===========
Subprograms
===========

*A Simple Comet*

The purpose of this exercise is to animate the planets using subprograms.

.. figure:: img/05_1.png
    :height: 300px
    :name:

    Expected result

----------
Question 1
----------

Implement :code:`Compute_X` and :code:`Compute_Y` functions and use them in the main loop to
update :code:`X` and :code:`Y` coordinates of every object.

----------
Question 2
----------

Implement the :code:`Move` subprogram and use it to move the objects instead of doing all
computations in the main loop.

:code:`Move` should also update the angle.

----------
Question 3
----------

Implement a procedure :code:`Draw_Body` which is a wrapper to call :code:`Draw_Sphere`.

From the main loop call :code:`Draw_Body` instead of directly drawing :code:`Draw_Sphere`.
:code:`Draw_Body` should only take 2 parameters.

----------
Question 4
----------

Add a tail to the  comet that rotates around the :code:`Sun`.

Hint: Try adding a :code:`Has_Tail` component to :code:`Body_T`, then modifying :code:`Draw` to display the tail properly.

Hint #2: An object that has a tail can be seen as being "followed" by small circles that are
**moved** in the opposite direction from the body being drawn.
