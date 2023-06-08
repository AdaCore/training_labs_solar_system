.. role:: ada(code)
    :language: ada

====================
Subprogram Contracts
====================

The following document is a set of requirements to implement for the lab, as
well as detailed questions to guide you in implementing them.

Starting from an implementation which contains some bugs and is incompletely
specified, and using subprogram contracts, you will implement contracts which
will prove useful in fixing the program.

----------------------
Mathematical Precision
----------------------

In the following document, the equality between two floating-point values is understood
as having a relative margin of error of :ada:`Epsilon = 1e-5`, unless the value is defined
as being *exactly* as specified, in which case no margin of error is tolerated: the value is
representable unambiguously and this representation should be used.

Formula: For an expected `X` (`|X| > 1`), actual `A`, relative epsilon `E` (`/= 0`), the absolute
margin of error is `X - X/E <= A <= X + X/E`, for `|X| <= 1`.

**Question 1** Following the questions in the first part of `solar_system_spec.ads`,
implement this comparison operation.

------------------------
`Body` object attributes
------------------------

Every `Body` must have a self-coherent state, that is no instance should contain a
value which is ambiguous, or unspecified.

More specifically:

* Attributes should have a correct range according to their specification
* The different *versions* of the object should have a definite value for
  attribute that they have but don't use.

From this we can extract requirements for all the attributes
of the objects of type `Body`.

First we must distinguish between objects that are Visible, and those that are not.
We must also distinguish between objects that orbit over another body, and those
that do not.

If the object is orbiting, it must obey the orbital position requirement, see `Orbit`.

The following requirements must be followed for every object:

* `X` : Body center horizontal position, in Pixels. No constraint
* `Y` : Body center vertical position, in Pixels. No constraint
* `Distance` : If orbiting, it must be `> 0`, else it must be exactly `0`
* `Speed` : If not orbiting, it must be exactly `0`, else it must be `/= 0`
* `Angle` : Angle in radians, if orbiting should be in the range `[0, 2 * PI[`,
  else it must be exactly `0`
* `Radius` : If visible, it must be `> 0`, else it must be exactly `0`
* `Color` : If not visible, it must be `black`
* `Visible` : No direct constraint
* `Turns_Around`: If orbiting, it must be `/= <the object itself>` else it must be `= <the object itself>`

* **Question 2** Following the questions in `solar_system_spec.ads`, define the new types,
  and the visibility contract
* **Question 3** Using the new types defined, modify the declaration of `Body_T` to follow
  the specification. This will cause an error at execution, fix that error by handling
  overflows and underflows.
* **Question 4** Add pre-conditions to `Init_Body` so that it uses the new types and
  visibility contracts.

------------------
Orbit requirements
------------------

There are several requirements applicable only to objects that do orbit.

An object that orbits is an object that turns around a different object from itself.
Conversely, an object that turns around itself is considered "not orbiting" and does not
need to follow those requirements.

For an object A that orbits B, we use the following definitions:

* *Center of Rotation* (CoR): B is the CoR of A
* `Orbits (A, B)` is the representation of this orbiting relationship
  - This relation is transitive, `Orbits (A, B) and Orbits (B, C) implies Orbits (A, C)`

The following requirements apply to objects that orbit:

* At any point in the execution of the program, for a `Body`, its `Distance` must be equal to
  the euclidian distance, in pixels, to the center of rotation.
* Similarly, the `Angle` should be correct in relation to the `X` and `Y` attributes.
* No object should indirectly orbit itself. The relationship `Orbits (A, A)` is always `False`.

* **Question 5** In `solar_system_spec.ads`, implement the functions necessary to check the
  distance and angle requirements for rotating bodies. Use those as post-condition of the
  `Move` subprogram.
  Tip: use the functions from `Solar_System.To_Body_Id` to convert
  a `Body_T` or a `Bodies_Enum_T` into `Body_Id`.
* **Question 6** Implement the functions necessary to perform cycle detection in `solar_system_spec.ads`.
  Tip: Using recursivity simplifies the implementation of `Has_No_Cycles`
* **Question 7** Assert `Has_No_Cycles` in the `Main` after Bodies have been initialized,
  use `Solar_System.Conversion.To_Orbit_Centers` to convert to the model format.
* **Question 8** What would be necessary to turn `Has_No_Cycle` into a post-condition? Discuss various
  approaches and their benefits.
* **Question 9** One quick way to guarantee that no cycle happens is to initialize the bodies in their
  order of rotation: that is that the `Turns_Around` parameter must be initialized, or equal to the
  body itself, as a precondition of `Init_Body`
* **Question 10** One way to clarify the API and related contracts is to split it into `Init_Still_Body`,
  `Init_Orbiting_Body`, `Init_Invisible_Orbiting_Body`. Implement this.

--------------------
Drawing Requirements
--------------------

NB: These requirements can become complex to implement, this has been left as an exercise for
the reader :)

Objects for which drawing operations would not change a single pixel on the screen must not be drawn.
They should continue orbiting, without being drawn until they enter the canvas again.

* **Question 11** Add the necessary elements to check an "overflow" of the canvas to `Solar_System_Spec`,
  then implement them as subprogram contracts into `Solar_System.Draw`.
* **Question 12** Ideally we would want our contract to make sure that this requirement is never broken,
  from the call to `Body_Init` itself, that means calculating all the orbits to guarantee that no such
  overflow is possible. Write these contracts.
