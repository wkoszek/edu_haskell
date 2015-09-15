sumList (x:xs) = do
			print(x)
			x + sumList xs
sumList []     = 0
