defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  @doc """
    Creates and returns a full deck

    ## Example

          iex> deck = Cards.create_deck()
          iex> length(deck)
          52
  """

  def create_deck do
    # suits = ["hearts", "clubs", "spades", "diamonds"]
    suits= ["\u2764", "\u2663", "\u2660", "\u2666"]
    values = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]

    for suit <- suits, value <- values do
      "#{value}#{suit}"
    end
  end

  @doc """

    Returns { dealt_hand, remaining_deck }
    - Creates a list of strings representing a deck of playing cards
    - Shuffles the newly created deck
    - Deals hand according to given hand size

  ## Example

        iex> deck = Cards.create_deck()
        iex> hand_length = 5
        iex> { dealt_hand, remaining_deck } = Cards.create_hand(hand_length)
        iex> for hand <- dealt_hand do
        ...> Cards.contains?(deck, hand)
        ...> end
        [true, true, true, true, true]
        iex> length(dealt_hand)
        5
        iex> length(remaining_deck)
        47
  """

  def create_hand(hand_size) do
    Cards.create_deck()
    |> Cards.shuffle()
    |> Cards.deal(hand_size)
  end

  @doc """
    Saves deck into file

  ## Example

        iex> deck = Cards.create_deck()
        iex> Cards.save(deck, "my_deck")
        iex> File.exists?("my_deck")
        true
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
    Loads deck from file

  ## Example

        iex> deck = Cards.create_deck()
        iex> Cards.save(deck, "my_deck")
        iex> loaded_deck = Cards.load("my_deck")
        iex> deck == loaded_deck
        true

  """
  def load(filename) do
    case File.read(filename) do
      { :ok, binary } -> :erlang.binary_to_term(binary)
      { :error, _reason } -> "Error: No such file name"
    end
  end

  @doc """
    Shuffles a created deck

  ## Example

        iex> deck = Cards.create_deck()
        iex> shuffled_deck = Cards.shuffle(deck)
        iex> deck == shuffled_deck
        false
  """

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Deals a hand and based on the given hand size.
    Returns { dealt_hand, remaining_deck }

  ## Example

        iex> deck = Cards.create_deck()
        iex> { dealt_hand, remaining_deck } = Cards.deal(deck, 2)
        iex> dealt_hand
        ["A\u2764", "2\u2764"]

  """

  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """

    Returns a boolean if a card exists inside the deck

  ## Example

        iex> deck = Cards.create_deck()
        iex> Cards.contains?(deck, "A\u2764")
        true
  """

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end
end
