#!/bin/bash
#
# translate.sh - translate a folder full of adoc files while suffixing the original structure
#
# Created by Martin Jahr (@selfscrum)
#
# Just call the file in the directory with english *.adoc files. The script will translate each file
# sentence by sentence (not the most efficient way but quick to create). Asciidoctor syntax is kept.
# Output files are renamed to *.adoc.de
#
# To make the script work, you need to purchase a deepl API access and set the environment variable 
# DEEPL_AUTH_KEY to the auth token provided to you by deepl. 
#
# LICENSE INFO: Creative Commons Attribution-ShareAlike 4.0 International Public License

for i in $(ls -1 *.adoc); do
		while IFS= read -r line; do
			# we need some preparation since deepl eats some of the asciidoc markups
			prefix=""
			suffix=""
			# save img ref
			if [[ $(echo "${line::5}") == '[#img' ]] ; then
				suffix=$line
				line=""
			fi
			# save chapter ref
			if [[ $(echo "${line::5}") == '[#cha' ]] ; then
				suffix=$line
				line=""
			fi
			# save appendix ref
			if [[ $(echo "${line::5}") == '[#app' ]] ; then
				suffix=$line
				line=""
			fi
			# save leading "*"
			if [[ $(echo "${line::1}") == '*' ]] ; then
				prefix='* '
				line=$(echo "$line" | sed -e 's/\*\(.*\)/\1/')
			fi
			# save leading "."
			if [[ $(echo "${line::1}") == '.' ]] ; then
				prefix="."
				line=$(echo "$line" | sed -e 's/\.\(.*\)/\1/')
			fi
			# save leading "_"
			if [[ $(echo "${line::1}") == '_' ]] ; then
				prefix="_"
				line=$(echo "$line" | sed -e 's/_\(.*\)/\1/')
			fi
			# save end of quote paragraph ("_ +")
			if [[ $(echo "${line:(-3)}") == '_ +' ]] ; then
				suffix="_ +"
				line=$(echo "$line" | sed -e 's/\(.*\)_ +/\1/')
			fi
			# save end of paragraph ("+")
			if [[ $(echo "${line:(-1)}") == '+' ]] ; then
				suffix=" +"
				line=$(echo "$line" | sed -e 's/\(.*\)+/\1/')
			fi
            # get rid of "&"
			line=$(echo "$line" | sed -e 's/\&/ and /g')

			echo -n "$prefix"
			# translate, extract text from json result and fix wrong conversions "(# ... )" back to "[# ... ]"
			echo -n $(curl https://api.deepl.com/v2/translate \
				-d auth_key=$DEEPL_AUTH_KEY \
				-d "text=$line"  \
				-d "source_lang=EN" \
				-d "target_lang=DE"\
				-d "preserve_formatting=1" \
					| jq -r .translations[0].text \
					| sed -e 's/(#\(.*\))/[#\1]/' )
			echo -e "$suffix"
		done < $i > $i.de
done
