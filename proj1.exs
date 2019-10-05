defmodule Caller do
	def start do
		PrintServer.start_link([])
		VampireParent.start_link([String.to_integer(Enum.at(System.argv(), 0)), String.to_integer(Enum.at(System.argv(), 1))])

		temp = PrintServer.get_items
      	temp = Enum.sort(temp)
      	Enum.each(temp, fn x -> Vampire.printer(x) end)
	end
end
Caller.start

# The start function in the caller module accepts the arguments from the user and sends it to the VampireParent module
