-- Design a method to find the frequency of occurrences of any given word in a book
-- What if we were running this alogirthm multiple times?

-- Create a frequency table of words in the book
-- lookup word and return

import qualified Data.HashMap.Lazy as H
import           Prelude hiding (lookup)

data Book = B { corpus    :: String
              , frequency :: H.HashMap String Int
              , lookup    :: String -> Maybe Int
              }

instance Show Book where
  show (B c f _) = show c ++ "\n\n" ++ show f

makeBook :: String -> Book
makeBook s = B s freqTable (`H.lookup` freqTable)
  where freqTable = foldr (\ word -> H.insertWith (+) word 1) H.empty (words s)

ipsum = "Magni accusantium numquam minima laborum rem porro facilis omnis. Sint voluptatem architecto eum cumque. Accusantium ut magnam sit sit. Aut error ipsa labore consequatur nisi est veniam. Doloribus ea consectetur rerum. Quis eos blanditiis error quisquam.\
\Ab quam id et quia corrupti voluptatem exercitationem nihil. Omnis rerum consequatur dolorem ut. Aliquam aut ut voluptates enim asperiores ea.\
\Accusantium quisquam temporibus a modi odit aspernatur rerum sit. Et pariatur in ut optio est labore. A id aut non doloremque reprehenderit.\
\Id ullam quia assumenda ratione vitae. Est at error est vitae deleniti. Voluptatem vel mollitia qui eligendi.\
\Et et quia qui corrupti vel modi error reiciendis. Exercitationem rem quasi est earum cumque voluptas. Quia eveniet voluptatibus eaque sed aliquid voluptatem at."

book = makeBook ipsum
