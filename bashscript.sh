#!/bin/bash


read -p "Enter the domain to block: " domain


ip=$(dig +short $domain | tail -n 1)

# Check if IP was resolved
if [ -z "$ip" ]; then
    echo "Could not resolve domain to IP. Exiting."
    exit 1
fi


iptables -A OUTPUT -d $ip -j DROP
iptables -A INPUT -s $ip -j DROP


echo "Blocked all traffic to and from $ip ($domain)"
