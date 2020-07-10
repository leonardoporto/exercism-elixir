defmodule IsbnVerifier do
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> ISBNVerifier.isbn?("3-598-21507-X")
      true

      iex> ISBNVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn) do
    sum =
      isbn
      |> String.replace("-", "")
      |> String.split("", trim: true)
      |> Enum.reverse()
      |> Enum.map(&validate_value/1)
      |> Enum.with_index()
      |> Enum.reduce(0, fn {digit, x}, b ->
        b + digit * (x + 1)
      end)

    rem(sum, 11) == 0
  end

  defp validate_value("X"), do: 10

  defp validate_value(value) do
    case Integer.parse(value) do
      {value, _} -> value
      :error -> 0
    end
  end
end
