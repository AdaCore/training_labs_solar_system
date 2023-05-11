# Solar System Labs

This repo contains a collection of labs based around drawing moving orbital
bodies using the Mage library which is itself based on the SDL.

# Prerequisites

Alire installed
A GNAT compiler installed, if you don't have one, Alire can install the FSF
version.
A 

# Run the "getting started" example

With Alire simply run

`alr run`

After a time downloading the libraries, and compiling the example, you should
see a window appearing with a red ball bouncing of the corners.

# Solve the exercises

On order to work on the labs you must first start gnat studio.

`alr edit`

On the scenario tab on the left (if it's not there click the View menu > Scenario), chose
the lab you want to work by setting the "Lab" scenario variable. Make sure that "Mode" is set
to "Problem"

On the Project tab, you should then have access to the main file of the lab in question, which
contains the questions.

You can compile and run using the dedicated GNAT Studio build / run menus and buttons.

# Run the solved exercises

If you want to see or run the solutions, on the scenario tab select "Mode" = "Solution". This
will select a new main file, which contains a solution for each lab.
Warning: After having changed the "Mode" variable, you may need to recompile the project by force,
by cleaning it.

All solutions should run out of the box, if they don't it is a bug, feel free to open a ticket.

# Updating the content

The content is generated using "templated" files, which are situated in the various `template/` directories.
Those files are transformed into "final" ada files through the use of `adacut`.
