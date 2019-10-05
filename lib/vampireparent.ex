defmodule VampireParent do
  use Supervisor

  def start_link(limits) do
    Supervisor.start_link(__MODULE__, limits)
  end

  def init(limits) do
    low = Enum.at(limits, 0)
    high = Enum.at(limits, 1)
    split= (high-low)/8 |> trunc()
    children = [
    worker(Server, [low, low+split], [id: 1]),
    worker(Server, [low+split,low+split*2], [id: 2]),
    worker(Server, [(low+split*2), (low+split*3)], [id: 3]),
    worker(Server, [(low+split*3), (low+split*4)], [id: 4]),
    worker(Server, [(low+split*4), (low+split*5)], [id: 5]),
    worker(Server, [(low+split*5), (low+split*6)], [id: 6]),
    worker(Server, [(low+split*6), (low+split*7)], [id: 7]),
    worker(Server, [(low+split*7), high], [id: 8])
    ]

    supervise(children, strategy: :one_for_one)


  end
end

