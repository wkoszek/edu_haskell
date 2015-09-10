type CreditNumber = Int
type LastName = String
type Address = String

data Billing =
	  CreditCard CreditNumber
	| CashAmount
	| Name LastName Address
	  deriving (Show)

v = CreditCard 345345
