#!/bin/bash
set -ex

if [ -f $1 ]; then
  sed 's/Ĺ‚/ł/g' -i $1
  sed 's/Ĺ›/ś/g' -i $1
  sed 's/Ä™/ę/g' -i $1
  sed 's/Ä‡/ć/g' -i $1
  sed 's/ĹĽ/ż/g' -i $1
  sed 's/Ăł/ó/g' -i $1
  sed 's/Ä…/ą/g' -i $1
  sed 's/Ĺş/ź/g' -i $1
  sed 's/Ĺš/Ś/g' -i $1
  sed 's/Ĺ„/ń/g' -i $1
  sed 's/Ĺ»/Ż/g' -i $1
else
  echo "This is not a file :o"
fi

