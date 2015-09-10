type Title = String
type Year = Int

data BookInfo =
		Book Title Year
		deriving (Show)

a = Book "Programming Ruby" 2001
b = Book "Ruby Programming" 2002


