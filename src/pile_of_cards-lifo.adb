package body Pile_Of_Cards.LIFO is

   --------------------------------------------------------------------
   --
   function Construct return Pile_Type_LIFO is
      pile : Pile_Type_LIFO;
   begin
      return pile;
   end Construct;

   --------------------------------------------------------------------
   --
   function Pop (Pile : in out Pile_Type_LIFO) return Card.Card_Type is
   begin
      --  re-use base class implementation
      return Pile_Of_Cards.Pile_Type (Pile).Pop;
   end Pop;

   --------------------------------------------------------------------
   --
   procedure Push (Pile : in out Pile_Type_LIFO; C : Card.Card_Type) is
   begin
      --  re-use base class implementation
      Pile_Of_Cards.Pile_Type (Pile).Push (C);
   end Push;

   --------------------------------------------------------------------
   --
   procedure Collect (Pile : Pile_Type_LIFO;
                      SIF  : in out Short_Image_FIFO.Short_Image_FIFO_Type) is
      Crsr : Card_Type_DLL.Cursor := Pile.Cards.Last;
      C    : Card.Card_Type;
      CSI  : Card.Short_Image_Type;
      use Card_Type_DLL;
   begin
      loop
         exit when Crsr = Card_Type_DLL.No_Element;
         C := Element (Crsr);
         CSI := C.Short_Image;
         SIF.Put (CSI);
         Crsr := Previous (Crsr);
      end loop;
   end Collect;

end Pile_Of_Cards.LIFO;
