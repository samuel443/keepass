# /arena
_colifight () {
	SRC=$(w3m -debug -dump_source -o accept_encoding=='*;q=0' "$URL/collfight/enterFight" -o user_agent="$(shuf -n1 .ua)")
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep 'collfight/take' | head -n1 | cut -d\' -f2) #/arena/attack/1/1234567*/
	SRC=$(w3m -debug -dump_source -o accept_encoding=='*;q=0' "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
	SRC=$(w3m -debug -dump_source -o accept_encoding=='*;q=0' "$URL/collfight/enterFight" -o user_agent="$(shuf -n1 .ua)")
}
_AtakeHelp () {
	_clanid
	if [[ -n $CLD ]]; then
		w3m -debug -o accept_encoding=='*;q=0' "$URL/clan/$CLD/quest/take/3" -o user_agent="$(shuf -n1 .ua)" | head -n15;
		w3m -debug -o accept_encoding=='*;q=0' "$URL/clan/$CLD/quest/help/3" -o user_agent="$(shuf -n1 .ua)" | head -n15;
		w3m -debug -o accept_encoding=='*;q=0' "$URL/clan/$CLD/quest/take/4" -o user_agent="$(shuf -n1 .ua)" | head -n15;
		w3m -debug -o accept_encoding=='*;q=0' "$URL/clan/$CLD/quest/help/4" -o user_agent="$(shuf -n1 .ua)" | head -n15;
	fi
}
_AdeleteEnd () {
	_clanid
	if [[ -n $CLD ]]; then
		w3m -debug -o accept_encoding=='*;q=0' "$URL/clan/$CLD/quest/deleteHelp/3" -o user_agent="$(shuf -n1 .ua)" | head -n15;
		w3m -debug -o accept_encoding=='*;q=0' "$URL/clan/$CLD/quest/deleteHelp/4" -o user_agent="$(shuf -n1 .ua)" | head -n15;
		w3m -debug -o accept_encoding=='*;q=0' "$URL/clan/$CLD/quest/end/3" -o user_agent="$(shuf -n1 .ua)" | head -n15;
		w3m -debug -o accept_encoding=='*;q=0' "$URL/clan/$CLD/quest/end/4" -o user_agent="$(shuf -n1 .ua)" | head -n15;
	fi
}
_arena () {
	SRC=$(w3m -debug -dump_source -o accept_encoding=='*;q=0' "$URL/arena/" -o user_agent="$(shuf -n1 .ua)")
	ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep 'arena/attack' | head -n1 | cut -d\' -f2) #/arena/attack/1/1234567*/
	EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep 'lab/wizard' | head -n1 | cut -d\' -f2) #/lab/wizard/potion/1234567*/?ref=/arena/
	while [[ -z $EXIT && -n $ACCESS ]]; do
		SRC=$(w3m -debug -dump_source -o accept_encoding=='*;q=0' "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)")
		ACCESS=$(echo $SRC | sed 's/href=/\n/g' | grep 'arena/attack' | head -n1 | cut -d\' -f2) #/arena/attack/1/1234567*/
		echo "$ACCESS"
		EXIT=$(echo $SRC | sed 's/href=/\n/g' | grep 'lab/wizard' | head -n1 | cut -d\' -f2) #/lab/wizard/potion/1234567*/?ref=/arena/
	done
	echo -e "arena (✔)\n"
}
_fullmana () {
	ARENA=$(w3m -debug -dump_source -o accept_encoding=='*;q=0' $URL/arena/quit -o user_agent="$(shuf -n1 .ua)" | sed "s/href='/\n/g" | grep "attack/1" | head -n1 | cut -d\/ -f5 | tr -cd "[[:digit:]]")
	echo " ⚔ - 1 Attack..."
	ATK1=$(w3m -debug -dump_source -o accept_encoding=='*;q=0' "$URL/arena/attack/1/?r=$ARENA" -o user_agent="$(shuf -n1 .ua)" | sed "s/href='/\n/g" | grep --color "arena/lastPlayer" | head -n1 | cut -d\' -f1 | tr -cd "[[:digit:]]")
	echo " ⚔ - Full Attack..."
	w3m -debug -dump "$URL/arena/lastPlayer/?r=$ATK1&fullmana=true" -o user_agent="$(shuf -n1 .ua)"
}
