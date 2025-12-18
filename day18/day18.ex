defmodule Day19 do
  def day19(file_path) do
    values = File.read!(file_path) 
      |> String.split("\n", trim: true) 
      |> Enum.map(&convert_line/1)
    Enum.reduce(values, 0, fn item, acc -> acc + item end) / length(values) 
  end

  def convert_line(text) do
    text 
      |> String.graphemes 
      |> Enum.filter(fn char -> is_valid_char(char) end) 
      |> Enum.map(&convert_char/1) 
      |> Enum.reduce(0, fn item, acc -> acc * 5 + item end)
  end

  def is_valid_char(char) do
    case char do 
      "☃" -> true
      "❄" -> true
      "0" -> true
      "*" -> true
      "✦" -> true
      _ -> false
    end
  end

  def convert_char(char) do
    case char do
      "☃" -> -2
      "❄" -> -1
      "0" -> 0
      "*" -> 1
      "✦" -> 2
      _ -> raise("Unknwon char '#{char}'")
    end
  end
end
