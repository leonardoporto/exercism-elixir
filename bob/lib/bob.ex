defmodule Bob do
  def hey(input) do
    input = String.trim(input)

    cond do
      silence?(input) -> "Fine. Be that way!"
      forceful?(input) -> "Calm down, I know what I'm doing!"
      shouting?(input) -> "Whoa, chill out!"
      asking?(input) -> "Sure."
      true -> "Whatever."
    end
  end

  defp shouting?(input), do: input == String.upcase(input) and String.match?(input, ~r/\p{L}/)
  defp asking?(input), do: String.last(input) == "?"
  defp forceful?(input), do: shouting?(input) and asking?(input)
  defp silence?(input), do: input == ""
end
