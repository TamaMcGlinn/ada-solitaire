with Pile_Of_Cards.LIFO;

package body Tableau is

   function Construct return Tableau_Type is
      T : Tableau_Type;
      S : Tableau_Stack.Stack_Type_Access;
   begin
      for J in Valid_Stacks_Range loop
         S            := new Tableau_Stack.Stack_Type;
         S.all        := Tableau_Stack.Construct;
         T.Stacks (J) := S;
      end loop;
      return T;
   end Construct;

   function Size (T : Tableau_Type) return Natural is
      S : Natural := 0;
   begin
      for J in Valid_Stacks_Range loop
         S := S + T.Stacks (J).Size;
      end loop;
      return S;
   end Size;

   procedure Push
     (T : Tableau_Type; Pile : in out Pile_Of_Cards.FIFO.Pile_Type_FIFO)
   is
      J : Valid_Stacks_Range := Valid_Stacks_Range'First;
      C : Card.Card_Type;
   begin
      while not Pile.Is_Empty loop
         C := Pile.Get;
         T.Stacks (J).all.Push_Unchecked (C);
         if J = Valid_Stacks_Range'Last then
            J := Valid_Stacks_Range'First;
         else
            J := J + 1;
         end if;
      end loop;
   end Push;

   procedure Move_To
     (T         : Tableau_Type; Src_Index : Valid_Stacks_Range;
      Dst_Index : Valid_Stacks_Range; Card_To_Include : Card.Card_Type)
   is
      Src_Stack    : constant Tableau_Stack.Stack_Type_Access :=
        T.Stacks (Src_Index);
      Dst_Stack    : constant Tableau_Stack.Stack_Type_Access :=
        T.Stacks (Dst_Index);
      Acceptable   : constant Tableau_Stack.Acceptable_Type :=
        Dst_Stack.all.Accepts;
      Transfer     : Pile_Of_Cards.LIFO.Pile_Type_LIFO :=
        Pile_Of_Cards.LIFO.Construct;
      Card_To_Xfer : Card.Card_Type;
   begin
      if Dst_Index = Src_Index then
         raise Tableau_Target_Stack_Equals_Source_Stack_Exception;
      end if;
      if not Src_Stack.all.Has (Card_To_Include) then
         raise Tableau_Source_Card_Does_Not_Exist_Exception;
      end if;
      if not Acceptable.Has (Card_To_Include) then
         raise Tableau_Destination_Stack_Does_Not_Accept_Exception;
      end if;
      loop
         Card_To_Xfer := Src_Stack.all.Pop;
         Transfer.Push (Card_To_Xfer);
         exit when Card_To_Xfer.Is_Equal_To (Card_To_Include);
      end loop;
      while not Transfer.Is_Empty loop
         Card_To_Xfer := Transfer.Pop;
         Dst_Stack.Push_Unchecked (Card_To_Xfer);
      end loop;
   end Move_To;

   function Remove_Mandatory_Cards
     (T : Tableau_Type; Candidates : Pile_Of_Cards.FIFO.Pile_Type_FIFO)
      return Pile_Of_Cards.FIFO.Pile_Type_FIFO
   is
      Stack           : Tableau_Stack.Stack_Type_Access;
      Peek_Card       : Card.Card_Type;
      Move_Card       : Card.Card_Type;
      Mandatory_Cards : Pile_Of_Cards.FIFO.Pile_Type_FIFO :=
        Pile_Of_Cards.FIFO.Construct;
   begin
      for J in Valid_Stacks_Range loop
         Stack := T.Get_Stack (J);
         if not Stack.all.Is_Empty then
            Peek_Card := Stack.all.Peek;
            if Candidates.Has (Peek_Card) then
               Move_Card := Stack.all.Pop;
               Mandatory_Cards.Put (Move_Card);
            end if;
         end if;
      end loop;
      return Mandatory_Cards;
   end Remove_Mandatory_Cards;

   function To_String_One_Line (SIs : Stack_Images) return One_Line_String is
      One_Stack       : Short_Image_FIFO.Short_Image_FIFO_Type_Access;
      One_Short_Image : Card.Short_Image_Type;
      Ret_Val         : One_Line_String;
      Separator       : constant Character := ' ';
      Dst_Index       : Integer := 1;
   begin
      for J in Valid_Stacks_Range loop
         One_Stack := SIs (J);
         if One_Stack.all.Is_Empty then
            One_Short_Image := Card.Empty_Short_Image;
         else
            One_Short_Image := One_Stack.Get;
         end if;
         Ret_Val (Dst_Index) := One_Short_Image (1);
         Dst_Index := Dst_Index + 1;
         Ret_Val (Dst_Index) := One_Short_Image (2);
         Dst_Index := Dst_Index + 1;
         Ret_Val (Dst_Index) := Separator;
         Dst_Index := Dst_Index + 1;
      end loop;
      return Ret_Val;
   end To_String_One_Line;

--     function To_String (T : Tableau_Type) return String is
--        S : Ada.Strings.Unbounded.Unbounded_String
--          := Ada.Strings.Unbounded.Null_Unbounded_String;
--        Stacks    : constant Stack_Array := T.Stacks;
--        SIs       : Stack_Images;
--     begin
--        for J in Valid_Stacks_Range loop
--           SIs (J) := Stacks (J).Short_Images;
--        end loop;
--
--        return Ada.Strings.Unbounded.To_String (Source => S);
--     end To_String;

   --------------------------------------------------------------------
   --
   function Pop_From_Stack
     (T : Tableau_Type; J : Valid_Stacks_Range) return Card.Card_Type
   is
   begin
      return T.Stacks (J).all.Pop;
   exception
      when Tableau_Stack.Tableau_Stack_Empty_Exception =>
         raise Tableau_Stack_Empty_Exception;
   end Pop_From_Stack;

   function Get_Stack
     (T : Tableau_Type; J : Valid_Stacks_Range) return Tableau_Stack
     .Stack_Type_Access
   is
   begin
      return T.Stacks (J);
   end Get_Stack;

end Tableau;
