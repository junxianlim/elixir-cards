defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "creates a full deck of 52 cards" do
    deck = Cards.create_deck()
    assert length(deck) == 52
  end

  test "shuffles deck randomizes it" do
    deck = Cards.create_deck()
    shuffled_deck = Cards.shuffle(deck)
    refute shuffled_deck == deck
  end
end
