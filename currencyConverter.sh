#!/bin/bash
#Get the currency result like X currency1 = Y currency2
output=$(wget -q -O - "http://www.google.com/finance/converter?a=$1&from=$2&to=$3" | sed '/res/!d;s/<[^>]*>//g')
#split the result
IFS='=' read -a temp <<< "$output"
#to upper case the currency2
tocurrency=$(echo $3 | awk '{print toupper($0)}')
#remove the "currency2" from the string (actually split into an array)
IFS=$tocurrency read -a final <<< "${temp[1]}"
#google returns currency result with US locale '.' floating divider
#so we have to replace the '.' with ',' to use printf
originalString=${final[0]}
replaceString=","
resultString=${originalString/./$replaceString}
#convert to two decimal result
echo ${resultString}
#return ${final[0]}
