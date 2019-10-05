defmodule PrintServer do
  use GenServer

  def start_link(list) do
    GenServer.start_link(__MODULE__, list, name: :printop)
  end

  def init(list) do
    {:ok, list}
  end

  def add_item(item) do
    GenServer.cast(:printop, {:add_item, item})
  end

  def get_items() do
    GenServer.call(:printop, :get_items)
  end

  def handle_cast({:add_item, item}, list) do
    {:noreply, [item | list]}
  end

  def handle_call(:get_items, _from, list) do
    {:reply, list, list}
  end
end


defmodule Server do
  use GenServer

  def start_link(low, high) do 
      GenServer.start_link(__MODULE__, [low, high])
  end

  def init(msgs) do
      Vampire.main_module([Enum.at(msgs, 0), Enum.at(msgs,1)])
      {:ok, msgs}
  end

  def handle_call(:get_msgs, _from, msgs) do
      {:reply, msgs, msgs}
  end

  def handle_cast({:add_msg, _msg}, msgs) do
      {:noreply, {msgs}}
  end

  def add_msg(pid, msg) do
      GenServer.cast(pid,{:add_msg, msg})
  end

end

defmodule Vampire do
  
  def main_module(limit) do
    low = Enum.at(limit,0)
    high = Enum.at(limit,1)
    low..high
      |>Task.async_stream(&vamp/1, max_concurrency: System.schedulers_online)
      |> Enum.to_list()
  
  end
    
  def vamp(num) do
    numofdig = getdigits(num)
    halfdig = numofdig/2 |> trunc()
    if (num>0 && rem(numofdig, 2)==0) do
      all_factors = factorpairs(num)
      factor_pairs = lengthchecker(all_factors, halfdig)
      valid_factor_pairs = Enum.filter(factor_pairs, & !is_nil(&1))
      a = digitchecker(valid_factor_pairs)
      digsofnum = Integer.digits(num) |> Enum.sort()
      dig_array = fangfinder(a)
  
      
      if(digsofnum in dig_array) do
        lastop= indexfinder(dig_array, digsofnum, 0 , [])
        final = fang_printer(lastop, valid_factor_pairs, [])
        final = List.flatten(final)
        PrintServer.add_item([num | final])
      end
    end
  end


  def printer(ls) do
    Enum.each(ls, fn x ->
      IO.write(x)
      IO.write(" ") end)
    IO.write("\n")
  end

  def factorpairs(num), do: factorpairs(num, 1, [])
  def factorpairs(num, i, factor_list) when num < i*i, do: factor_list
  def factorpairs(num, i, factor_list) when num == i*i, do: factor_list
  def factorpairs(num, i, factor_list) when rem(num,i)==0 do
    if(rem(i, 10)== 0 && rem(div(num, i), 10) == 0) do
      factorpairs(num, i+1, factor_list)
    else
      factorpairs(num, i+1, [i, div(num,i) | factor_list])
    end
  end
  def factorpairs(num, i, factor_list), do: factorpairs(num, i+1, factor_list)
  

  def getdigits(n) do 
    :math.log10(n) + 1 |> trunc()
  end

  def lengthchecker([], _halfdig), do: []
  def lengthchecker([ a, b | tail ], halfdig), do: [  if (getdigits(a)== halfdig && getdigits(b)==halfdig ) do [a,b|[]] end | lengthchecker(tail, halfdig)]

  
  def digitchecker([]), do: []
  def digitchecker([ [a, b] | tail ]), do: [ Enum.join([a,b]) | digitchecker(tail) ]

  def fangfinder([]), do: []
  def fangfinder([ a | tail ]), do: [ a |> to_charlist() |> List.to_integer() |> Integer.digits() |> Enum.sort() | fangfinder(tail) ]
  

  def indexfinder(dig_array, _digsofnum, n, lst) when n == length(dig_array), do: lst
  def indexfinder(dig_array, digsofnum, n, lst) do
    {:ok, list_at_index} = Enum.fetch(dig_array, n)
    if(list_at_index == digsofnum) do
      indexfinder(dig_array, digsofnum, n + 1, [n |lst])
    else
      indexfinder(dig_array, digsofnum, n + 1, lst)
    end
  end

  def fang_printer([], _valid_factor_pairs, empty), do: empty
  def fang_printer([ a | tail ], valid_factor_pairs, empty) do
        fang_printer(tail, valid_factor_pairs, [Enum.at(valid_factor_pairs,a) | empty]) 
    end
  end


