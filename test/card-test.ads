with AUnit.Test_Suites;
with AUnit.Test_Fixtures;

package Card.Test is

   function Suite return AUnit.Test_Suites.Access_Test_Suite;

private
   type Test is new AUnit.Test_Fixtures.Test_Fixture with null record;

   procedure Ctor_Rank (T : in out Test);
   procedure Ctor_Top_Rank (T : in out Test);
   procedure Ctor_Suit (T : in out Test);
   procedure Rank_Is_Equal_To_Using_Identical_Rank (T : in out Test);
   procedure Rank_Is_Equal_To_Using_Equal_Rank (T : in out Test);
   procedure Rank_Is_Higher_Than_True (T : in out Test);
   procedure Rank_Is_Higher_Than_False (T : in out Test);
   procedure Rank_Is_Lower_Than_True (T : in out Test);
   procedure Rank_Is_Lower_Than_False (T : in out Test);
   procedure Suit_Is_Equal_To_Using_Identical_Suit (T : in out Test);
   procedure Suit_Is_Equal_To_Using_Equal_Suit (T : in out Test);
   procedure Suit_Is_Red_Diamond (T : in out Test);
   procedure Suit_Is_Red_Heart (T : in out Test);
   procedure Is_Equal_To_Identical_Rank_Identical_Suit (T : in out Test);
   procedure Is_Equal_To_Equal_Rank_Identical_Suit (T : in out Test);
   procedure Is_Equal_To_Identical_Rank_Equal_Suit (T : in out Test);
   procedure Is_Equal_To_Equal_Rank_Equal_Suit (T : in out Test);
   procedure Image_1 (T : in out Test);

end Card.Test;
