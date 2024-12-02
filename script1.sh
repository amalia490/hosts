#!/bin/bash
cat /etc/hosts | while read -r line; do
if [[ -z "$line"  || \#* ]]; then
	continue
fi

ip=$(echo "$line" | awk '{print $1}')
name=$(echp "$line" | awk '{print $2}')

second_ip=$(nslookup "$name" | grep 'Address:' | tail -n 1 | awk '{print $2}')
if [[ "$second_ip" != "$ip" && ]]; then
	echo "Bogus IP for $name in  /etc/hosts! Found $second_ip instead of $ip."
fi
done
