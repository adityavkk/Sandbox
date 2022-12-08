const alertNames = (keyName, keyTime) => {
  const visitsByName = keyName.reduce((map, name, i) => {
    if (map[name]) {
      map[name].push(parseTime(keyTime[i]))
    }
    else {
      map[name] = [parseTime(keyTime[i])]
    }
    return map
  }, {})

  const result = Object.entries(visitsByName)
    .filter(([name, times]) => hasAlert(times))
    .map(([name, _]) => name)
    result.sort()
    return result
}

const parseTime = timeS => {
  const [hour, min] = timeS.split(":")
  return +hour * 60 + +min
}

const withinHour = (start, end) => { 
  const timeDiff = end - start
  const result = timeDiff >= 0 && timeDiff <= 60
  return result
}

const hasAlert = (times) => {
  times.sort()
  const window = []
  for(let time of times) {
    while(window.length && !withinHour(window[0], time)) window.shift()
    window.push(time)
    if (window.length >= 3) return true
  }
  return false
}
