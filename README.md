# powershellscripts

Exercise 1:
• Write a script that takes a command parameter as an argument:
○ > .\myscript.ps1 <command>
• Based on the argument, write the following output to the console:
○ command1 => output1
○ command2 => output2
○ command3 => output3

Exercise 2:
• Write a script that does the following:
1. Downloads one of the demo plan packages from promdev
2. Runs the plan locally using 5 years of input

Exercise 3:
• Write a script that can replace text in a file:
○ > .\myscript.ps1 <filepath> <text-to-search-for> <text-to-replace-with>
• Example:
○ myfile.txt contents:
§ Author: $FLAG
○ .\myscript.ps1 myfile.txt $FLAG Anish
○ myfile.txt should now be:
Author: Anish
