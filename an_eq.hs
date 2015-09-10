type Duo1 = (Int, String)
type Duo2 = (Int, String)

data Sample =	Sample Duo1
		deriving (Eq, Show)

data Sample2 =	Sample2 Duo2
 		deriving (Show, Eq)

main =	do
		let
			aa = Sample (1, "Just one")
			ab = Sample (2, "This is two")
			ac = Sample2 (3, "asdsad")

		print (aa)
		print (ab)
		print (aa == ab)

--		print (aa == ac)


		putStrLn "woj"
