defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(markdown) do
    markdown
    |> String.split("\n")
    |> Enum.map_join(&process/1)
    |> enclose_with_tags()
    |> wrap_list()
  end

  defp process("#" <> _ = text), do: enclose_with_header_tag(text)
  defp process("* " <> rest), do: "<li>#{rest}</li>"
  defp process(text), do: "<p>#{text}</p>"

  defp enclose_with_header_tag(text) do
    [hash, text] = String.split(text, ~r/#+/, include_captures: true, trim: true)
    hl = String.length(hash)
    content = String.trim(text)

    "<h#{hl}>#{content}</h#{hl}>"
  end

  defp enclose_with_tags(text) do
    text
    |> String.replace(~r/__(.*)__/, "<strong>\\1</strong>")
    |> String.replace(~r/_(.*)_/, "<em>\\1</em>")
  end

  defp wrap_list(l) do
    l
    |> String.replace("<li>", "<ul><li>", global: false)
    |> String.replace_suffix("</li>", "</li></ul>")
  end
end
