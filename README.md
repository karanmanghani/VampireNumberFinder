# PROJECT 1:  VAMPIRE NUMBER FINDER

### COP5615 - Distributed Operating Systems Principles

The goal of the project was to create an Elixir application that can find Vampire numbers between a given range provided by the user and print the vampire number along with its fangs.

##Team Members:

1. Karan Manghani (UFID: 7986-9199)
2. Yaswanth Bellam (UFID: 2461-6390)

##Steps to run the code: 
1.	Clone/Download the file
2.	Using CMD/ terminal, go the directory where you have downloaded the zip file
3.	Type  ‘cd VampireNumberFinder’ (to enter the project directory)
4.	Run the command “mix run proj1.exs 100000 200000” 

##Actors: 
There are 9 actors in the project. The supervisor and 8 workers.

##Supervisors and Workers:
The supervisor creates and handles 8 child workers who work on finding the vampire number within the range given. Using trial and error we found optimum results and improvements using 8 workers rather than 4 or 16. Therefore, we split the user given range into 8 parts and find vampire number and the fangs within that range. Once all the vampire numbers have been found and returned to Printer Genserver module, the Genserver displays the output to the user.

##Test Cases and Output:
 Our program generates the following outputs for the following ranges:
1.	Lower limit: 1000
	Upper limit: 2000
	CPU time: 0.64
	Real time: 0.32
	Ratio: 2.00
![1000-2000](/screenshots/1000-2000.jpeg)

2.	Lower limit: 100000
	Upper limit: 200000
	CPU time: 4.512
	Real time: 2.233
	Ratio: 2.02
![100000-200000](/screenshots/100000-200000.jpeg)

3.	Lower limit: 100000
	Upper limit: 200000
	CPU time: 1171.982
	Real time: 577.644
	Ratio: 2.0289
![10000000-20000000](/screenshots/10000000-20000000.jpeg)

##Largest Vampire Number attempted:
![10000000-20000000](/screenshots/largest.PNG)

