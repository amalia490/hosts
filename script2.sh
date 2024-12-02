#!/bin/bash

validate_ip() {
    local hostname=$1
    local ip=$2
    local dns_server=$3

    res_ip=$(nslookup "$hostname" "$dns_server" | grep 'Address:' | tail -n 1 | awk '{print $2}')
    
    if [[ -z "$res_ip" ]]; then
        echo "Hostname-ul $hostname nu poate fi rezolvat folosind serverul DNS $dns_server"
    elif [[ "$res_ip" != "$ip" ]]; then
        echo "Bogus IP pentru $hostname în /etc/hosts! Găsit $res_ip în loc de $ip."
    else
        echo "Asocierea pentru $hostname este validă."
    fi
}

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

