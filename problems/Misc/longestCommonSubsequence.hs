-- lcs "a"         "b"         `shouldBe` ""
-- lcs "132535365" "123456789" `shouldBe` "12356"
lcs :: String -> String -> String
lcs x y = 
