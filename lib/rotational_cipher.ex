defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    chars = String.codepoints(text)
    convert(chars, shift)
  end

  def convert([<<codepoint>> | tail], shift_key, acc \\ "") do
    new_acc = acc <> List.to_string([shift(codepoint, shift_key)])
    convert(tail, shift_key, new_acc)
  end

  def convert([], _shift_key, acc) do
    acc
  end

  def shift(char, shift_key) when char in ?a..?z do
    rem(char - ?a + shift_key, 26) + ?a
  end

  def shift(char, shift_key) when char in ?A..?Z do
    rem(char - ?A + shift_key, 26) + ?A
  end

  def shift(char, _shift_key), do: char

end
