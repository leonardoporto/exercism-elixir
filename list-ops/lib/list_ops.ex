defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(l) do
    length(l)
  end

  @spec reverse(list) :: list
  def reverse(l) do
    reverse(l, [])
  end

  defp reverse([], response), do: response

  defp reverse([head | tail], response) do
    response = [head | response]
    reverse(tail, response)
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    map(l, f, [])
  end

  defp map([], _, response), do: reverse(response)

  defp map([head | tail], func, response) do
    response = [func.(head) | response]
    map(tail, func, response)
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    filter(l, f, [])
  end

  defp filter([], _, response), do: reverse(response)

  defp filter([head | tail], func, response) do
    response =
      if func.(head) do
        [head | response]
      else
        response
      end

    filter(tail, func, response)
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([], acc, _), do: acc

  def reduce([head | tail], acc, f) do
    acc = f.(head, acc)
    reduce(tail, acc, f)
  end

  @spec append(list, list) :: list
  def append(a, b) do
    reduce(reverse(a), b, fn item, acc -> [item | acc] end)
  end

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    reverse(concat(ll, []))
  end

  defp concat([], response), do: response
  defp concat(value, response) when not is_list(value), do: [value | response]

  defp concat([head | tail], response) do
    concat(tail, concat(head, response))
  end
end
