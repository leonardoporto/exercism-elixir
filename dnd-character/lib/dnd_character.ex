defmodule DndCharacter do
  @type t :: %__MODULE__{
          strength: pos_integer(),
          dexterity: pos_integer(),
          constitution: pos_integer(),
          intelligence: pos_integer(),
          wisdom: pos_integer(),
          charisma: pos_integer(),
          hitpoints: pos_integer()
        }

  defstruct ~w[strength dexterity constitution intelligence wisdom charisma hitpoints]a

  @spec modifier(pos_integer()) :: integer()
  def modifier(score) do
    value = score - 10

    value
    |> get_modifier()
    |> trunc()
  end

  @spec ability :: pos_integer()
  def ability do
    1..4
    |> Enum.map(fn _ -> roll_d6() end)
    |> Enum.sort()
    |> Enum.slice(1..4)
    |> Enum.sum()
  end

  @attributes ~w(strength dexterity constitution intelligence wisdom charisma)a
  @spec character :: t()
  def character do
    @attributes
    |> Enum.reduce(%DndCharacter{}, fn attribute, char -> roll_attribute(attribute, char) end)
    |> hitpoints()
  end

  defp get_modifier(value) when is_integer(value) and rem(value, 2) != 0, do: (value - 1) / 2
  defp get_modifier(value), do: value / 2

  defp roll_d6(), do: Enum.random(1..6)

  defp roll_attribute(attribute, %DndCharacter{} = char), do: Map.put(char, attribute, ability())

  defp hitpoints(%DndCharacter{} = char),
    do: Map.put(char, :hitpoints, 10 + modifier(char.constitution))
end
