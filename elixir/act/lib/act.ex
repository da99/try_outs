defmodule Act do
  use ExActor

  defcall square x do
    :timer.sleep(100)
    IO.puts "#{x} * #{x} =  #{x * x}"
  end

  def start_pool do
    {:ok, pool} = :poolboy.start(
      worker_module: My, size: 0, max_overflow: 5:w
    )
    pool
  end # === def start_pool

  def pooled_square pool, x do
    :poolboy.transaction(pool, fn(pid) ->
      Act.square(pid, x)
    end)
  end # === def pooled_square

  def paralel_squares pool, numbers do
    Enum.each numbers, fn(x) ->
      spawn(fn() -> pooled_square(pool, x) end)
    end
  end # === def paralel_squares pool, numbers
end
