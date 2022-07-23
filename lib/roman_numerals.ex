defmodule RomanNumerals do
  @translated %{
    1 => "I",
    4 => "IV",
    5 => "V",
    9 => "IX",
    10 => "X",
    40 => "XL",
    50 => "L",
    90 => "XC",
    100 => "C",
    400 => "CD",
    500 => "D",
    900 => "CM",
    1000 => "M"
  }
  @translated_keys @translated |> Map.keys() |> Enum.sort(&(&1 > &2))

  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    convert(number)
  end

  defp convert(number, translations \\ @translated_keys, result \\ "")
  defp convert(0, _, result), do: result
  defp convert(number, [max | tail] = translations, result) do
    if number >= max do
      convert(number - max, translations, result <> @translated[max])
    else
      convert(number, tail, result)
    end
  end
end
