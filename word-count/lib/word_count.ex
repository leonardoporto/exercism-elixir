defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.downcase()
    |> split_sentence()
    |> group_and_sum()
  end

  defp group_and_sum(words) when is_list(words) do
    Enum.reduce(words, %{}, fn word, response ->
      Map.update(response, word, 1, &(&1 + 1))
    end)
  end

  defp split_sentence(sentence), do: String.split(sentence, ~r/[^[:alnum:]\-]/u, trim: true)
end
