with Deck; use Deck;

package body Card is

   function Ctor (Rank : in Deck.Rank_Type;
                  Suit : in Deck.Suit_Type)
                  return Card_Type is
   begin
      return (Rank, Suit);
   end Ctor;
   
   function Get_Rank (A_Card : Card_Type) return Deck.Rank_Type is
   begin
      return A_Card.Rank;
   end Get_Rank;
   
   function Get_Suit (A_Card : Card_Type) return Deck.Suit_Type is
   begin
      return A_Card.Suit;
   end Get_Suit;
   
   function Rank_Is_Equal_To (c1 : Card_Type; c2 : Card_Type) return Boolean is
   begin
      return c1.Get_Rank = c2.Get_Rank;
   end Rank_Is_Equal_To;

   function Rank_Is_Higher_Than (c1 : Card_Type; c2 : Card_Type) return Boolean is
   begin
      return c1.Get_Rank > c2.Get_Rank;
   end Rank_Is_Higher_Than;
   
   function Rank_Is_Lower_Than (c1 : Card_Type; c2 : Card_Type) return Boolean is
   begin
      return c1.Rank < c2.Rank;
   end Rank_Is_Lower_Than;


   function Suit_Is_Equal_To (c1 : Card_Type; c2 : Card_Type) return Boolean is
   begin
      return c1.Get_Suit = c2.Get_Suit;
   end Suit_Is_Equal_To;
   

end Card;
