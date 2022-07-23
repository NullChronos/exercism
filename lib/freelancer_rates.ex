defmodule FreelancerRates do
  @billable_days 22

  def daily_rate(hourly_rate) do
    hourly_rate * 8.0
  end

  def apply_discount(before_discount, discount) do
    before_discount * (1 - discount / 100)
  end

  def monthly_rate(hourly_rate, discount) do
    monthly_rate = daily_rate(hourly_rate) * @billable_days
    monthly_rate_discounted = apply_discount(monthly_rate, discount)

    monthly_rate_discounted
    |> Float.ceil(0)
    |> trunc()
  end

  # calculates how many days of work that covers.
  def days_in_budget(budget, hourly_rate, discount) do
    days = monthly_rate(hourly_rate, discount) / @billable_days

    Float.floor(budget / days, 1)
  end
end
