# Delete branches that haven't received commits for a week
for k in $(git branch | sed /\*/d); do
  if [ -n "$(git log -1 --since='1 week ago' -s $k)" ]; then
    do
      echo -e `git show --format="%ci %cr %an" $k | head -n 1`
    # git branch -D $k
  fi
done
