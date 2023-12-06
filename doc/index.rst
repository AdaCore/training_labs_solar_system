.. Labs Solar System documentation master file, created by
   sphinx-quickstart on Thu May 25 15:13:48 2023.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

Welcome to Labs Solar System's documentation!
=============================================

This is a collection of labs based around drawing moving orbital bodies using the Mage
library which is itself based on the SDL.

Run the "getting started" example
---------------------------------

With Alire simply run

``make run``

After a time downloading the libraries, and compiling the example, you should
see a window appearing with a red ball bouncing off the corners.

Solve the exercises
-------------------

In order to work on the labs you must first start gnat studio.

``make edit``

On the scenario tab on the left (if it's not there click the View menu > Scenario), choose
the lab you want to work by setting the "Lab" scenario variable. Make sure that "Mode" is set
to "Question".

On the Project tab, you should then have access to the main file of the lab in question, which
contains the questions.

You can compile and run using the dedicated GNAT Studio build / run menus and buttons.

Run the solved exercises
------------------------

If you want to see or run the solutions, on the scenario tab select "Mode" = "Answer". This
will select a new main file, which contains a solution for each lab.
Warning: After having changed the "Mode" variable, you may need to recompile the project by force,
by cleaning it.

All solutions should run out of the box, if they don't it is a bug, feel free to open a ticket.

.. toctree::
   :maxdepth: 2
   :caption: Contents:

   000_getting_started
   050_array_types
   060_record_types
   070_subprograms
   100_packages
   110_private_types
   140_access_types
   160_genericity
   190_exceptions
   230_interfacing_with_c
   adv_170_multiple_inheritance
   adv_240_tasking_embedded
   adv_240_tasking_protected_objects
   adv_270_subprogram_contracts
   navigating_code_and_git
   advanced_code_edition


Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`
