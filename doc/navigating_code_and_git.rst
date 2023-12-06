.. role:: ada(code)
    :language: ada

========================================
Navigating Code and Git with GNAT Studio
========================================

The purpose of this exercise is to discover and use GNAT Studio to navigate the code.

This lab uses the Getting Started lab (default).

----------
Question 1
----------

We want to get familiar with the Mage package, and we're going to use GNAT Studio to help with that.
From ``getting_started_main.adb``, navigate to the definition of :ada:`Window_ID`, then to the private
completion of this type.

----------
Question 2
----------

Notice that :ada:`Window_ID` is created through a call to :ada:`Create_Window`. Navigate to the completion
of that :ada:`function`.

----------
Question 3
----------

The :ada:`Renderer_Flag` constant depends on :ada:`Mage_Config.Hardware.Enabled`. Navigate to the definition
of this constant.

----------
Question 4
----------

Notice that the :ada:`package Mage_Config.Hardware` doesn't bare the same name as its file. This
is due to a custom compiler setup, which happens in ``mage.gpr``. Open that GPR file.

----------
Question 5
----------

The package in question in the GPR file is the :ada:`package Naming`. Find it, and reading
what it does, try to get to the related call to ``external``. This declares a scenario variable.
Go to the Scenario view and find the variable and its current value. Change the value, 
see that the compiled value of :ada:`Mage_Config.Hardware.Enabled` changed, and recompile and re-run
the app to see what happens.

----------
Question 6
----------

Open ``mage.adb`` and locate the use of :ada:`Unbounded_String`, jump to its declaration.
Using the outline view, notice all that the :ada:`package Ada.Strings.Unbounded` exports.

----------
Question 7
----------

Locate :ada:`Ada.Strings.Unbounded.To_Unbounded_String (Source : String)`, and list all of its callers.

----------
Question 8
----------

Open the git history of ``getting_started_main.adb``, then the git history of ``labs_solar_system.gpr`` (hint: this second one may require opening another view than the Project view).

