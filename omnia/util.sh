#!/usr/bin/env bash

#get median of  a list of numbers
getMedian () {
	local _numbers=( "$@" )
	tr " " "\\n" <<< "${_numbers[@]}" | datamash median 1
}

#extracts prices from list of messages
extractPrices () {
    local _msgs=( "$@" )
    local _prices
    for msg in "${_msgs[@]}"; do
       _prices+=("$(echo "$msg" | jq '.price')")
    done
    echo "${_prices[@]}"
}

join () { 
	local IFS=","
	echo "$*"
}

#get unix timestamp in ms
timestampMs () {
    date +"%s%3N"
}

#get unix timestamp in s
timestampS () {
	date +"%s"
}

#convert price to hex
price2Hex () {
	local _price="$1"
	#convert price to wei and then uint256
	seth --to-uint256 "$(seth --to-wei "$_price" eth)"
}

#converts blockstamp to hex
time2Hex () {
	local _time="$1"
	#convert blockstamp to uint256
	seth --to-uint256 "$_time"

}

#gets keccak-256 hash of 1 or more input arguments
keccak256Hash () {
	local _inputs
	for arg in "$@"; do
		_inputs+="$arg"
	done
	seth keccak "$_inputs"
}