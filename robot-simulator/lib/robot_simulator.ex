defmodule RobotSimulator do
  @directions [:north, :east, :south, :west]

  defguard is_north(direction) when direction == :north
  defguard is_east(direction) when direction == :east
  defguard is_south(direction) when direction == :south
  defguard is_west(direction) when direction == :west
  defguard is_valid_direction(direction) when direction in @directions
  defguard is_valid_position(position) when is_tuple(position) and tuple_size(position) == 2

  defstruct position: {0, 0}, direction: :north

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(), do: %RobotSimulator{}

  def create(direction, _) when not is_valid_direction(direction),
    do: {:error, "invalid direction"}

  def create(_, position) when not is_valid_position(position), do: {:error, "invalid position"}

  def create(_, {x, y}) when not is_integer(x) or not is_integer(y),
    do: {:error, "invalid position"}

  def create(direction, position) do
    %__MODULE__{position: position, direction: direction}
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    move(robot, String.split(instructions, "", trim: true))
  end

  defp move(%RobotSimulator{} = robot, []), do: robot

  defp move(robot, ["L" | tail]) do
    {_, index} = get_current_index(robot)

    %{robot | direction: new_direction(:left, index)}
    |> move(tail)
  end

  defp move(robot, ["R" | tail]) do
    {_, index} = get_current_index(robot)

    %{robot | direction: new_direction(:right, index)}
    |> move(tail)
  end

  defp move(%RobotSimulator{direction: :north, position: {x, y}} = robot, ["A" | tail]),
    do:
      %{robot | position: {x, y + 1}}
      |> move(tail)

  defp move(%RobotSimulator{direction: :east, position: {x, y}} = robot, ["A" | tail]),
    do:
      %{robot | position: {x + 1, y}}
      |> move(tail)

  defp move(%RobotSimulator{direction: :south, position: {x, y}} = robot, ["A" | tail]),
    do:
      %{robot | position: {x, y - 1}}
      |> move(tail)

  defp move(%RobotSimulator{direction: :west, position: {x, y}} = robot, ["A" | tail]),
    do:
      %{robot | position: {x - 1, y}}
      |> move(tail)

  defp move(_, _), do: {:error, "invalid instruction"}

  defp get_current_index(%RobotSimulator{direction: direction}) do
    @directions
    |> Enum.with_index()
    |> Enum.find(fn {value, _} -> value == direction end)
  end

  defp new_direction(:right, current_direction) do
    direction =
      if current_direction + 1 >= Enum.count(@directions) do
        0
      else
        current_direction + 1
      end

    Enum.at(@directions, direction)
  end

  defp new_direction(:left, current_direction) do
    direction =
      if current_direction - 1 < 0 do
        Enum.count(@directions) - 1
      else
        current_direction - 1
      end

    Enum.at(@directions, direction)
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    robot.direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
    robot.position
  end
end
