defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    number
    |> int_to_roman(0, "")
  end

  @numbers ~w(1000 900 500 400 100 90 50 40 10 9 5 4 1)
  @roman_numbers ~w(M CM D CD C XC L XL X IX V IV I)
  defp int_to_roman(0, _, response), do: response
  defp int_to_roman(value, index, response) when is_integer(value) do
    number = Enum.at(@numbers, index)
    {value, quantity} = get_quantity(value, String.to_integer(number), 0)
    response = response <> String.duplicate(Enum.at(@roman_numbers, index), quantity)
    int_to_roman(value, index + 1, response)
  end

  defp get_quantity(0, _, quantity), do: {0, quantity}
  defp get_quantity(value, divisor, quantity) do
    if rem(value, divisor) < value do
      value = value - divisor
      get_quantity((if value> 0, do: value, else: 0), divisor, quantity + 1)
    else
      {value, quantity}
    end 
  end
end
