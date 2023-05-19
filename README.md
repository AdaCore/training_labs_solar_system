# Solar System Labs

This repo contains a collection of labs based around drawing moving orbital
bodies using the Mage library which is itself based on the SDL.

# Prerequisites

Alire installed. The GNAT compiler, if you don't have one, Alire can install the FSF
version. GNAT Studio. If you don't have it you can download it from a github release.

# Install and run the code

## Run the "getting started" example

With Alire simply run

`alr run`

After a time downloading the libraries, and compiling the example, you should
see a window appearing with a red ball bouncing of the corners.

## Solve the exercises

On order to work on the labs you must first start gnat studio.

`alr edit`

On the scenario tab on the left (if it's not there click the View menu > Scenario), chose
the lab you want to work by setting the "Lab" scenario variable. Make sure that "Mode" is set
to "Problem"

On the Project tab, you should then have access to the main file of the lab in question, which
contains the questions.

You can compile and run using the dedicated GNAT Studio build / run menus and buttons.

## Run the solved exercises

If you want to see or run the solutions, on the scenario tab select "Mode" = "Solution". This
will select a new main file, which contains a solution for each lab.
Warning: After having changed the "Mode" variable, you may need to recompile the project by force,
by cleaning it.

All solutions should run out of the box, if they don't it is a bug, feel free to open a ticket.

## Known issues

1. On Windows `alr run` may fail silently. In that case start `alr edit` and run the "getting_starting" lab
   to check that it works correctly.

2. If you are missing `gnat` or `gprbuild` from your PATH while running an Alire command, you may end up
   with a corrupted Alire state, at this point, any further `alr` may fail to run, complaining about
   missing config file. In that case, you must erase the `config/` and `alire/` directories, so that
   Alire can start back from scratch.

# Updating the content

The content is generated using "templated" files, which are situated in the various `template/` directories.
Those files are transformed into "final" ada files through the use of `adacut`.

Once you have updated a `template/xxx.adb` file, you can regenerate the associated files by calling

`make generate`

## Alire release

When releasing to Alire, please do not forget to update the `CHANGELOG` file, the version in the
`alire.toml` file, and to tag the new release so that it can be retrieved easily from within `git`. 
