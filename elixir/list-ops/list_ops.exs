defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(l) do
    if l == [] do
      0
    else
      1 + (l |> tl |> count)
    end
  end

  @spec reverse(list) :: list
  def reverse(l) do
    reverse_helper(l, [])
  end

  defp reverse_helper(l, acc) do
    if l == [] do
      acc
    else
      [h | t] = l
      reverse_helper(t, [h | acc])
    end
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    if l == [] do
      l
    else
      [h | t] = l
      [f.(h) | map(t, f)]
    end
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    cond do
      l == [] ->
        l
      l |> hd |> f.() ->
        [hd(l) | l |> tl |> filter(f)]
      true ->
        l |> tl |> filter(f)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce(l, acc, f) do
    if l == [] do
      acc
    else
      [h | t] = l
      reduce(t, f.(h, acc), f)
    end
  end

  @spec append(list, list) :: list
  def append(a, b) do
    if a == [] do
      b
    else
      [h | t] = a
      [h | append(t, b)]
    end
  end

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    if ll == [] do
      []
    else
      [h | t] = ll
      append(h, concat(t))
    end
  end
end
