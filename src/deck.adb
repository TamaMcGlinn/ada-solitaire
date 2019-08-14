
package body Deck is
   Short_Ranks : constant array (Rank_Type_Valid_Range)
     of Short_Image_Rank_Type
       := (Ace => "A",
           Two  => "2",
           Three => "3",
           Four => "4",
           Five => "5",
           Six => "6",
           Seven => "7",
           Eight => "8",
           Nine => "9",
           Ten => "T",
           Jack => "J",
           Queen => "Q",
           King => "K");

   Short_Suits : constant array (Suit_Type_Valid_Range)
     of Short_Image_Suit_Type
       := (Diamond => "D",
           Heart => "H",
           Club => "C",
           Spade => "S");

   function Is_Red (a_suit : Suit_Type) return Boolean is
   begin
      return a_suit = Diamond or else a_suit = Heart;
   end Is_Red;

   function Is_Black (a_suit : Suit_Type) return Boolean is
   begin
      return not Is_Red (a_suit);
   end Is_Black;

   function Short_Image (R : Rank_Type_Valid_Range)
                         return Short_Image_Rank_Type is
   begin
      return Short_Ranks (R);
   end Short_Image;

   function Short_Image (S : Suit_Type_Valid_Range)
                         return Short_Image_Suit_Type is
   begin
      return Short_Suits (S);
   end Short_Image;

end Deck;
