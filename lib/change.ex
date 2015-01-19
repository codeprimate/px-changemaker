defmodule Change do

  defmodule Coin do
    defstruct name: "none", value: 0.0, count: 0

    @doc """
    Ordered list of currency types
    """
    def coinage do
      [
        %Coin{ name: "hundred dollar bill", value: 10000 }, 
        %Coin{ name: "fifty dollar bill"  , value: 5000 } , 
        %Coin{ name: "twenty dollar bill" , value: 2000 } , 
        %Coin{ name: "ten dollar bill"    , value: 1000 } , 
        %Coin{ name: "five dollar bill"   , value: 500 }  , 
        %Coin{ name: "dollar bill"        , value: 100 }  , 
        %Coin{ name: "quarter"            , value: 25 }   , 
        %Coin{ name: "dime"               , value: 10 }   , 
        %Coin{ name: "nickel"             , value: 5 }    , 
        %Coin{ name: "penny"              , value: 1 }
      ]
     end
  end
  alias Change.Coin, as: Coin


  @doc """
  Accepts a Float in dollars or an Integer in cents.

  Returns a List of Tuples containing Coin structs and quantities.
  """
  def from(val) do
    { _ , coins, _ } = coins_from(val |> process_val, [ ], Coin.coinage)
    coins |> sorter
  end

  def format(coins) do
    coins
      |> Enum.map &formatter/1
  end

  defp sorter(coins) do
    Enum.sort_by(coins, &(&1.value), &>=/2)
  end

  defp coins_from(val, coins, [ ]) do
    {val, coins, [] }
  end

  defp coins_from(0, coins, coinage) do
    {0, coins , coinage }
  end

  defp coins_from(val, coins, coinage) when is_number(val) do
    [coin | rem_coinage ] = coinage
    count = div(val, coin.value)
    r = rem(val, coin.value)
    cond do
      count <= 0 ->
        coins_from(val, coins, rem_coinage)
      true ->
        coins_from(r, [ %Coin{coin | count: count} | coins ], rem_coinage)
    end
  end

  defp process_val(val) do
    cond do
      is_binary(val) ->
        re = ~r/\d+\.\d+$/
        isdecimal = Regex.match?(re, val) 
        case isdecimal do
          true-> val |> String.to_float |> process_val
          false -> val |> String.to_integer |> process_val
        end
      is_float(val) ->
        val * 100 |> round
      is_integer(val) ->
        val
    end
  end


  defp formatter (c) do
    {coin , number} = c
    cond do
      number > 1 ->
        "#{number} #{coin.name}s"
      true ->
        "#{number} #{coin.name}"
    end
  end
end

defimpl Poison.Encoder, for: Change.Coin do
  def encode(coin, _options) do
    coin |> Map.from_struct
         |> Poison.Encoder.Map.encode _options
  end
end
