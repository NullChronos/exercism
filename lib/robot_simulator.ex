defmodule Robot do
  defstruct [direction: :north, position: {0, 0}]
end

defmodule RobotSimulator do
  @directions [
    :north,
    :east,
    :south,
    :west
  ]

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ nil, position \\ nil)
  def create(direction, {x, y} = position)
  when direction in @directions and is_integer(x) and is_integer(y) do
    %Robot{direction: direction, position: position}
  end
  def create(direction, _) when direction in @directions do
    {:error, "invalid position"}
  end
  def create(_, {x, y}) when is_integer(x) and is_integer(y) do
    {:error, "invalid direction"}
  end
  def create(_, _), do: %Robot{}

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    instructions
    |> String.to_charlist()
    |> execute(robot)
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot), do: robot.direction

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot), do: robot.position

  def execute([?A | remaining], robot), do: execute(remaining, move(robot))
  def execute([?L | remaining], robot), do: execute(remaining, rotate(-1, robot))
  def execute([?R | remaining], robot), do: execute(remaining, rotate(+1, robot))
  def execute([], robot), do: robot
  def execute(_, _), do: {:error, "invalid instruction"}

  defp rotate(offset, robot) do
    current_direction_index = Enum.find_index(@directions, &(&1 == robot.direction))
    new_direction = Enum.at(@directions, current_direction_index + offset, :north)
    %{robot | direction: new_direction}
  end

  defp move(%Robot{direction: :north, position: {x, y}} = robot), do: %{robot | position: {x, y+1}}
  defp move(%Robot{direction: :east, position: {x, y}} = robot), do: %{robot | position: {x+1, y}}
  defp move(%Robot{direction: :south, position: {x, y}} = robot), do: %{robot | position: {x, y-1}}
  defp move(%Robot{direction: :west, position: {x, y}} = robot), do: %{robot | position: {x-1, y}}

end