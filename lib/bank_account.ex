defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  defstruct balance: 0, open: true

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    {:ok, account} = Agent.start_link(fn -> %__MODULE__{} end)
    account
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account) do
    Agent.update(account, &Map.update(&1, :open, false, fn(_) -> false end))
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    bank_account = Agent.get(account, &(&1))
    if bank_account.open, do: bank_account.balance, else: account_closed()
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
    bank_account = Agent.get(account, &(&1))

    if bank_account.open do
      Agent.update(account, &Map.update(&1, :balance, bank_account.balance, fn(balance) -> balance + amount end))
    else
      account_closed()
    end
  end

  defp account_closed(), do: {:error, :account_closed}
end
