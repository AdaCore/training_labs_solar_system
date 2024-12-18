# Solar System Labs

This repo contains a collection of labs based around drawing moving orbital
bodies using the Mage library which is itself based on the SDL.

# Prerequisites

Alire installed. The GNAT compiler, if you don't have one, Alire can install the FSF
version. GNAT Studio. If you don't have it you can download it from a github release.

To rebuild the source, you will need the python package `adacut`

```
$ pip install adacut
```

# Install and run the code

## Build the doc and setup the SDL

Run

`make`

So that the instructions get built in `doc/` and Alire performs the necessary
preliminary setup.

## Run the "getting started" example

With Alire simply run

`make run`

After a time downloading the libraries, and compiling the example, you should
see a window appearing with a red ball bouncing of the corners.

## Solve the exercises

On order to work on the labs you must first start GNAT Studio.

`make edit`

On the scenario tab on the left (if it's not there click the View menu > Scenario), chose
the lab you want to work by setting the "Lab" scenario variable (possible options are in
`labs_solar_system.gpr.Lab.options`).
Make sure that "Mode" is set to "Question"

On the Project tab, you should then have access to the main file of the lab in question, which
contains the questions.

You can compile and run using the dedicated GNAT Studio build / run menus and buttons.

## Run the solved exercises

If you want to see or run the solutions, on the scenario tab select "Mode" = "Answer". This
will select a new main file, which contains a solution for each lab.
Warning: After having changed the "Mode" variable, you may need to recompile the project by force,
by cleaning it.

All solutions and problems should run out of the box, if they don't it is a bug, feel free to open
a ticket.

## Use TSV Render

If you want to use the TSV renderer, which gives a result in console instead of on a screen, remove
Mage import and add
`with TSV_Render; use TSV_Render;`

It should display each frame in console, and you can then exit by typing `Q<enter>` in this same
console.

## Known issues

1. On Windows `make run` may fail silently. In that case start `make edit` and run the "getting_starting" lab
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

Then run `alr publish https://github.com/adacore/training_labs_solar_system <HASH>`
