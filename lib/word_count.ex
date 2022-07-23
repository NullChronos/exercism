defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @valid_pattern ~r/[0-9\w'-]+/u

  @spec count(String.t()) :: map
  def count(sentence) do
    sentence = Regex.replace(~r/_/, sentence, " ")
    sentence = String.downcase(sentence)

    @valid_pattern
    |> Regex.scan(sentence)
    |> List.flatten()
    |> Enum.reduce(Map.new(), fn(word, acc) ->
      Map.update(acc, word, 1, &(&1 + 1))
    end)
  end
end
