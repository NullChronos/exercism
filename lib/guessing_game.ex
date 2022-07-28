defmodule GuessingGame do
  def compare(_) do
    "Make a guess"
  end

  def compare(_, :no_guess) do
    "Make a guess"
  end

  def compare(secret_number, guess) when guess < secret_number do
    if guess + 1 == secret_number do
      "So close"
    else
      "Too low"
    end
  end

  def compare(secret_number, guess) when guess > secret_number do
    if guess - 1 == secret_number do
      "So close"
    else
      "Too high"
    end
  end

  def compare(secret_number, guess) do
    if secret_number == guess, do: "Correct"
  end
end
