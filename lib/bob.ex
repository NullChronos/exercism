defmodule Bob do

  @spec hey(input :: binary) :: String.t()
  def hey(input) do
    input = String.trim(input)

    cond do
      is_question?(input) and !is_uppercase?(input)-> "Sure."
      is_question?(input) and is_uppercase?(input) -> "Calm down, I know what I'm doing!"
      is_uppercase?(input) and has_letters?(input) -> "Whoa, chill out!"
      is_nothing_said?(input) -> "Fine. Be that way!"
      true -> "Whatever."
    end
  end


  defp is_question?(input), do: String.match?(input, ~r/[?]$/)
  defp is_uppercase?(input), do: String.match?(input, ~r/^[^a-z]*$/) and has_letters?(input)
  defp has_letters?(input), do: String.downcase(input) != String.upcase(input)
  defp is_nothing_said?(input), do: String.match?(input, ~r/\A\s*\z/)

end