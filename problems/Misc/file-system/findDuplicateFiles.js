/* Write a problem to find all duplicate files within a folder */

/* f :: FolderPath -> [[File]]
 *
 * HashMap Sha1 [FilePath]
 * Recursively hash each file's contents to its SHA1 and store the filePath as the value
 * Time: O (numFiles * lengthOfLongestFile [needed to hash])
 *       O (numFiles) (if we read a constant number of blocks per file i.e. begining/middle/end)
 * Space: O (numFiles)
 *
 * For each sha1 in hm:
 *   go through [FilePath] and group duplicates by actually comparing the files
 * return all duplicates
 * Time: O (lenOfLongestFile * maxNumOfCollisions^2)
 * Space: O (2 * lengthOfLongestFile)
 *        O (2 * blockSize)
 *        (if done in blocks but also solves problem of full file not fitting in memory)
 *
 *
 * Concerns:
 * - Symlinks:
 *    - what if there are symlinks that point up
 *    (we need to keep our file traversal from going down infinite loops)
 * - Can we do this concurrently? multiple threads? What are the potential pit falls of this?
 * - What if a background process edits a file while our script is running?
 */


