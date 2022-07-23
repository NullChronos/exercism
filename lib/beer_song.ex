defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  def verse(num) do
    case num do
      0 ->
        """
        No more bottles of beer on the wall, no more bottles of beer.
        Go to the store and buy some more, 99 bottles of beer on the wall.
        """
      1 ->
        """
        1 bottle of beer on the wall, 1 bottle of beer.
        Take it down and pass it around, no more bottles of beer on the wall.
        """
      2 ->
        """
        2 bottles of beer on the wall, 2 bottles of beer.
        Take one down and pass it around, 1 bottle of beer on the wall.
        """
      _ ->
        """
        #{num} bottles of beer on the wall, #{num} bottles of beer.
        Take one down and pass it around, #{num-1} bottles of beer on the wall.
        """
    end
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(range \\ 99..0) do
    Enum.map_join(range, "\n", &verse(&1))
  end

end
