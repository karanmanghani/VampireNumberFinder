defmodule Caller do
	def start do
		PrintServer.start_link([]) #Genserver Module for printing result
		VampireParent.start_link([String.to_integer(Enum.at(System.argv(), 0)), String.to_integer(Enum.at(System.argv(), 1))])
		# VampireParent is the supervisor module that generates the vampire numbers.
		# After execution control returns back here, where we print the accumulated results
		temp = PrintServer.get_items
      	temp = Enum.sort(temp)
      	Enum.each(temp, fn x -> Vampire.printer(x) end)
	end
end
Caller.start #Invoke the start function

# The start function in the caller module accepts the arguments from the user and sends it to the VampireParent module
