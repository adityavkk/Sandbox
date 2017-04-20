"""
Suppose we represent our file system as a string. For example, the string
"user\n\tpictures\n\tdocuments\n\t\tnotes.txt" represents:
    user
        pictures
        documents
            notes.txt

Given a file system representation, we want to find the longest absolute path
,in terms of characters, to a file within our system.

For fileSystem = "user\n\tpictures\n\tdocuments\n\t\tnotes.txt", the output should be
24
namely, "user/documents/notes.txt" is the longest path and it contains 24 characters
"""

"""
f :: FSString -> LongestFilePath

type JSONFs = Folder Name [JSONFs]
            | File File
            | Empty

type File = String
type Name = String

parse :: FSString -> JSONFs
- if fs is empty: return empty json
- (json, rest) = parseFolder
- return merge(json, parse(rest))

parseFolder :: FSString -> TabsToAccept -> (JSONFs, FSString)
- if fs string is empty: return {}
- if fs starts with a file: return parseFile fs
- (name, rest) = consume till \n
- (folder, rest) = consume fs till (tabs or end)
- (contents, rest') = zeroOrMore (parseFolder folder (tabs + 1))
- return ({ name : contents }, (rest' + rest))

parseFile :: FSString -> File
- if fs starts with a folder: return false
- (name, rest) = consume till \n
- return (file(name) rest)

zeroOrMore :: Parser -> FSString -> ([Result], FSString)
- (contents, rest) = p fs
- ps = [contents]
- while contents:
    - (contents, rest) = p rest
    - append contents ps
return ps
"""


