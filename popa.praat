#     popa - Polish Orthography to Phonetic Alphabets

#     This Praat script converts Polish orthography into IPA and AS transcription

#     You can contact the author in case of quesitons: jakub.bortlik@gmail.com

#     The script was created for the purposes of polfon.upol.cz, a web site
#     dedicated to the pronunciation of Polish, whose creation was made
#     possible with the support of the Ministry of Education, Youth and Sports
#     of the Czech Republic, grant no. IGA_FF_2014_081 (Fonematika polštiny z
#     hlediska axiomatického funkcionalismu. Fonetická a fonologická analýza
#     současného polského jazyka).

#     Copyright (c) 2016 Jakub Bortlík

#     This program is free software: you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     (at your option) any later version.

#     This program is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#     GNU General Public License for more details.

#     You should have received a copy of the GNU General Public License
#     along with this program. If not, see <http://www.gnu.org/licenses/>.


#     README

#     The IPA transcription is partially based on: Wągiel, Marcin. 2012.
#     "Fonologie polštiny v pojetí axiomatického funkcionalismu" (MA diploma
#     thesis) and on an so far unpublished article: Wągiel, Marcin.
#     "Międzynarodowy alfabet fonetyczny (IPA) w transkrypcji fonetycznej języka
#     polskiego". In Stanisław Gajda and Irena Jokiel (eds.), Polonistyka wobec
#     wyzwań współczesności. V Kongres Polonistyki Zagranicznej, vol. II.
#     Opole: Wydawnictwo UO. 134–145

#     BEFORE RUNNING THIS SCRIPT: The script converts orthography into IPA. You
#     have to provide a .csv or .tsv file which has a column with "orth"
#     (without the quotes) written in its first row and with the text to be
#     converted in this column. There can be empty rows.

#     Known issues:
#     • Some programs (e.g. MS Excel) can have troubles reading the resulting
#     table correctly. This is because of diffenreces in encoding of special
#     Polish characters and phonetic symbols. The problem can be avoided by
#     selecting UTF-8 in the "Text writing preferences..." in the "Preferences"
#     submenu of the Praat menu. Then you have to select UTF-8 again when you
#     open the file from, e.g. MS Excel.
#     • The convertor does not handle correctly exceptional voice assimilation
#     of function words (e.g., the prepositions "pod, bez") and prefixes (e.g.,
#     "przeciwrdzewny" should be [pʂɛtɕifrdzɛwnɨ] but is [pʂɛtɕivrdzɛwnɨ]).
#     • The convertor does not handle correctly assimilation of place across
#     morphological boundaries (e.g., "bankom" and "fankom", should have [ηk]
#     and [nk] respectively but both are transcribed with [ηk], since this is
#     the pronunciation in some Polish varieties, whereas no variety has only
#     [nk] in these words).
#     • The convertor cannot handle foreign words with original orthography
#     (e.g. weekend, jazz, menu).
#     • Neither does is handle correctly the "foreign" letters "q" and "x" or
#     any foreign accents and diacritics.
#     • Praat does not have a trigraph for "dot below", "dot above", and "comma
#     below" which in AS are used for retroflexion, raized articulation of
#     vowels, and devoicing respectively. In the script, these diacritics are
#     represented as unicode characters, in contrast to other non-latin symbols
#     which are represented as backslash trigraphs. The combination of "dot
#     below" and "comma below" for devoiced retroflex (palatalized) /n/ is only
#     correctly rendered in fonts with good Unicode support such as DoulosSIL.
#     In fact, this combination may never really be needed, since there are
#     probably no contexts where /n/ would become devoiced and retroflex at the
#     same time. This possibility is there, however, for completeness' sake.


#     PREPARE YOUR DATA:
#     You need a file (preferably a .csv or .txt file, possibly also .xls, but
#     formatting may cause problems, .doc does not work at all.) with the
#     words/texts you want to transcribe. It is useful to have one phrase per line,
#     there just has to be a title of the column in the first line - (orth) by
#     defaul. You can have other columns in your file, but if you do, you have to
#     use the same field delimiter in the file and in the script. If there are
#     commas in your text make sure you select "tab" as the delimiter.

#     OPEN THE SCRIPT in praat (Open Praat script... in the main window) and
#     run it (press Ctrl-R on your keyboard, or click Run in the Run menu of
#     the script window).
#     The transcription is saved as "YOUR_FILE_NAME_transcribed.csv".

#     HOW IT WORKS:
#     The codes for consonants are a combination of five digits:
#     • place of articulation (1-6)
#     • manner of articulation (1-8)
#     • palatalization (0 or 1)
#     • voicing (0=voiceless, 1=voiced, 2 for "rz")
#     • consonant class (2 = obstruent, 3 = devoicable sonorant, 4 = nasal
#    	approximant, /j/ is not defined)
#     The codes for vowels go from 1 to 6, with four positional variants (+ 20).
#     The codes for nasal diphthongs are 30 + the value of the particular vowel.
#     The code for a word boundary (space) is 9999.
#     The codes for preceding pause is 9009, for folowing pause it is 9000 (the
#     latter has a 0 on position 4, so it can work for final devoicing just like
#     voiceless sounds do.


			#########
			## IPA:
			#########

###consonants
## bilabials
# nasals
ipa11003$ = "m̥"
ipa11013$ = "m"
ipa11103$ = "m̥ʲ"
ipa11113$ = "mʲ"

# plosives
ipa12002$ = "p"
ipa12012$ = "b"
ipa12102$ = "pʲ"
ipa12112$ = "bʲ"

# labiodental fricatives

ipa23002$ = "f"
ipa23012$ = "v"
ipa23102$ = "fʲ"
ipa23112$ = "vʲ"


## alveolars
# nasals
ipa31003$ = "n̥"
ipa31013$ = "n"
ipa31103$ = "n̥ʲ"
ipa31113$ = "nʲ"

# plosives
ipa32002$ = "t"
ipa32012$ = "d"
ipa32102$ = "tʲ"
ipa32112$ = "dʲ"

# fricatives
ipa33002$ = "s"
ipa33012$ = "z"
ipa33102$ = "sʲ"
ipa33112$ = "zʲ"

# affricates
ipa34002$ = "t͡s"
ipa34012$ = "d͡z"
ipa34102$ = "t͡sʲ"
ipa34112$ = "d͡zʲ"

# vibrants
ipa37003$ = "r̥"
ipa37013$ = "r"
ipa37103$ = "r̥ʲ"
ipa37113$ = "rʲ"

# laterals
ipa38003$ = "l̥"
ipa38013$ = "l"
ipa38103$ = "l̥ʲ"
ipa38113$ = "lʲ"


## retroflexes
#nasals
ipa41003$ = "ɳ̊"
ipa41013$ = "ɳ"
ipa41103$ = "ɳ̊ʲ"
ipa41113$ = "ɳʲ"

# plosives
ipa42002$ = "ʈ"
ipa42012$ = "ɖ"
ipa42102$ = "ʈʲ"
ipa42112$ = "ɖʲ"

# fricatives
ipa43002$ = "ʂ"
ipa43012$ = "ʐ"
ipa43102$ = "ʂʲ"
ipa43112$ = "ʐʲ"

# affricates
ipa44002$ = "t͡ʂ"
ipa44012$ = "d͡ʐ"
ipa44102$ = "t͡ʂʲ"
ipa44112$ = "d͡ʐʲ"


## palatals
# nasals
ipa51103$ = "ɲ̊"
ipa51113$ = "ɲ"

# fricatives
ipa53102$ = "ɕ"
ipa53112$ = "ʑ"

# affricates
ipa54102$ = "t͡ɕ"
ipa54112$ = "d͡ʑ"

# approximants
ipa5511$ = "j"

# nasal approximants
ipa56114$ = "j̃"

## velars
# nasals
ipa61003$ = "ŋ̊"
ipa61013$ = "ŋ"
ipa61103$ = "ŋ̊ʲ"
ipa61113$ = "ŋʲ"

# plosives
ipa62002$ = "k"
ipa62012$ = "ɡ"
ipa62102$ = "kʲ"
ipa62112$ = "ɡʲ"

# fricatives
ipa63002$ = "x"
ipa63012$ = "ɣ"
ipa63102$ = "xʲ"
ipa63112$ = "ɣʲ"

# approximants
ipa65003$ = "ʍ"
ipa65013$ = "w"
ipa65103$ = "ʍʲ"
ipa65113$ = "wʲ"

# nasal approximants
ipa66014$ = "w̃"


### vowels
# /i/ and /ɨ/ have the highest values, so that they are exempted from changed
# articulation in palatal environments by "if phoneValue < 5".
# Changed articulation is done by "phoneValue = phoneValue + 20"
ipa1$ = "u"
ipa21$ = "u̟"
ipa2$ = "ɛ"
ipa22$ = "ɛ̝"
ipa3$ = "ɔ"
ipa23$ = "ɔ̝"
ipa4$ = "a"
ipa24$ = "a̟"
ipa5$ = "i"
ipa6$ = "ɨ"

### word boundary
ipa9999$ = " "


			########
			## AS:
			########

###consonants
## bilabials
# nasals
as11003$ = "m̦"
as11013$ = "m"
as11103$ = "m̦ʹ"
as11113$ = "mʹ"

# plosives
as12002$ = "p"
as12012$ = "b"
as12102$ = "pʹ"
as12112$ = "bʹ"

# labiodental fricatives

as23002$ = "f"
as23012$ = "v"
as23102$ = "fʹ"
as23112$ = "vʹ"


## alveolars
# nasals
as31003$ = "n̦"
as31013$ = "n"
as31103$ = "n̦ʹ"
as31113$ = "nʹ"

# plosives
as32002$ = "t"
as32012$ = "d"
as32102$ = "tʹ"
as32112$ = "dʹ"

# fricatives
as33002$ = "s"
as33012$ = "z"
as33102$ = "sʹ"
as33112$ = "zʹ"

# affricates
as34002$ = "c"
as34012$ = "ʒ"
as34102$ = "cʹ"
as34112$ = "ʒʹ"

# vibrants
as37003$ = "r̦"
as37013$ = "r"
as37103$ = "r̦ʹ"
as37113$ = "rʹ"

# laterals
as38003$ = "l̦"
as38013$ = "l"
as38103$ = "l̦ʹ"
as38113$ = "lʹ"


## retroflexes
#nasals
as41003$ = "ṇ̦"
as41013$ = "ṇ"
as41103$ = "ṇ̦ʹ"
as41113$ = "ṇʹ"

# plosives
as42002$ = "ṭ"
as42012$ = "ḍ"
as42102$ = "ṭʹ"
as42112$ = "ḍʹ"

# fricatives
as43002$ = "š"
as43012$ = "ž"
as43102$ = "šʹ"
as43112$ = "žʹ"

# affricates
as44002$ = "č"
as44012$ = "ǯ"
as44102$ = "čʹ"
as44112$ = "ǯʹ"


## palatals
# nasals
as51103$ = "ń̦"
as51113$ = "ń"

# fricatives
as53102$ = "ś"
as53112$ = "ź"

# affricates
as54102$ = "ć"
as54112$ = "ʒ́"

# approximants
as5511$ = "i̯"

# nasal approximants
as56114$ = "ĩ̯"

## velars
# nasals
as61003$ = "η̦"
as61013$ = "η"
as61103$ = "η̦ʹ"
as61113$ = "ηʹ"

# plosives
as62002$ = "k"
as62012$ = "g"
as62102$ = "ḱ"
as62112$ = "ǵ"

# fricatives
as63002$ = "χ"
as63012$ = "γ"
as63102$ = "χʹ"
as63112$ = "γʹ"

# approximants
as65003$ = "u̯̦"
as65013$ = "u̯"
as65103$ = "u̯̦ʹ"
as65113$ = "u̯ʹ"

# nasal approximants
as66014$ = "ũ̯"

### vowels
# /i/ and /y/ have the highest values, so that they are exempted from changed
# articulation in palatal environments by "if phoneValue < 5"
# Changed articulation is done by "phoneValue = phoneValue + 20"
as1$ = "u"
as21$ = "u̇"
as2$ = "e"
as22$ = "ė"
as3$ = "o"
as23$ = "ȯ"
as4$ = "a"
as24$ = "ȧ"
as5$ = "i"
as6$ = "y"

### word boundary
as9999$ = " "

			##################
			## TRANSCRIPTION
			##################

form Information about the variety and the data
	boolean Transcribe_to_ipa 1
	boolean Transcribe_to_as 1
	comment Choose the variety of Polish with respect to voice assimilation
	optionmenu Variety: 1
		option Warsaw
		option Cracow-Poznan
	comment Show cases when Cracow-Poznan voice assimilation applies? 
	boolean Show_assimilation 0
	comment Choose the column which contains the data to be transcribed
	word Column_with_data orth
	comment Choose a column with information on what should be transcribed,
	comment (If left unchecked, every line will be transcribed:)
	boolean Use_column_with_info 0
	word Column_with_info code
	boolean Remove_phone_columns 1
	comment Choose the separator in your data
	optionmenu Separator: 1
		option tab
		option comma
	comment Save the transcription in the original folder or elsewhere? 
	optionmenu Folder: 1
		option same
		option different
	comment Do you want to remove the file from praat object list? 
	boolean Remove: 1
endform

data = 0
path$ = chooseReadFile$: "Open a table file"
if path$ <> "" and fileReadable (path$)
	data = Read Table from 'separator$'-separated file: path$
	fileName$ = selected$ ("Table")
else
	goto CANCEL
endif

if show_assimilation = 1 and variety = 2
writeInfoLine: "Regressivie voice assimilation in the Cracow-Poznan variety has
... been applied in line: "
endif

if data <> 0
	goto TABLE_LOADED
else
	goto CANCEL
endif

label TABLE_LOADED

pathLength = length (path$)
extension = rindex (path$, ".")
extension$ = right$ (path$, pathLength - (extension - 1))
origFolder$ = (path$ - extension$) - fileName$

Append column: "lowerCase"

ipaExists = 0
asExists = 0

nCol = Get number of columns

for c to nCol
	testColumn$ = Get column label: c
	if testColumn$ = "ipa"
		ipaExists = 1
	endif
	if testColumn$ = "as"
		asExists = 1
	endif
endfor

if ipaExists = 0 and transcribe_to_ipa = 1
	Append column: "ipa"
endif
if asExists = 0 and transcribe_to_as = 1
	Append column: "as"
endif

items = Get number of rows

# "phoneCol" is the number of columns for individual "phonemes". These columns
# are deleted at the end of the script.
phoneCol = 0

for i from 1 to items
	numberOfPhones = 0
	selectObject: data

	if use_column_with_info = 1
		code$ = Get value: i, column_with_info$
		if code$ = ""
			goto SKIP_ITEM
		else
			goto GET_ITEM
		endif
	endif

	label GET_ITEM

	orth$ = Get value: i, column_with_data$
	numberOfCharacters = length (orth$)
	ipa$ = ""
	as$ = ""

	# The following "while cycle" skips empty lines and deletes spaces at the
	# end of the string:
	if numberOfCharacters > 0 and index_regex (orth$, "[a-zA-Z]") > 0
		while rindex (orth$, " ") = numberOfCharacters
			orth$ = left$ (orth$, numberOfCharacters - 1)
			numberOfCharacters = length (orth$)
		endwhile
	endif

	# The following line removes some punctuation, however, quotes "" and ''
	# are currently not removed:
	orth$ = replace_regex$ (orth$, "[.,?!;:-]+", "", 0)

	# The following line replaces multiple spaces by a single space:
	orth$ = replace_regex$ (orth$, "[ ]{2,}", " ", 0)

	# The following line converts most upper-case letters to lower-case, however
	# letters with diacritics are not replaced and are handled separately later:
	lowerCase$ = replace_regex$ (orth$, ".*", "\L&", 0)

	selectObject: data
	Set string value: i, "lowerCase", lowerCase$
	lcNr = length (lowerCase$)

	# The following for cycle converts orthography into "phonemes" (without
	# assimilation of place and voice, palatalization and other phonological
	# rules):

	for char from 1 to lcNr
		numberOfPhones = numberOfPhones + 1

		# The following if cycle appends a new column, if the current item is longer
		# than the preceding one:

		if numberOfPhones > phoneCol
			phoneCol = numberOfPhones
			selectObject: data
			Append column: "ph'phoneCol'"
		endif

		# The following if cycles get one character and its context from left to right
		# at a time to deal with digraphs and trigraphs. For the last character in the
		# string nextChar$ is defined as "&", i.e. "end of string". Similarly
		# nextNext(Next)Char$ are defined for the last but one(/two) character.

		char$ = right$ (left$ (lowerCase$, char), 1)

		if char < lcNr
			nextChar$ = right$ (left$ (lowerCase$, char + 1), 1)
		else
			nextChar$ = "&"
		endif

		if char < lcNr - 1
			nextNextChar$ = right$ (left$ (lowerCase$, char + 2), 1)
		else
			nextNextChar$ = "&"
		endif

		if char < lcNr - 2
			nextNextNextChar$ = right$ (left$ (lowerCase$, char + 3), 1)
		else
			nextNextNextChar$ = "&"
		endif

		prevChar$ = right$ (left$ (lowerCase$, char - 1), 1)

		# The following if cycle converts characters into phonemes and deals with
		# letters with diacritics that could not be handled by the upper-case to
		# lower-case convertor:

		if char$ = "a"
			phoneme = 4
		elif char$ = "ą" or char$ = "Ą"
			phoneme = 33
		elif char$ = "b"
			phoneme = 12012
		elif char$ = "c"
			if nextChar$ = "h"
				phoneme = 63002
				char = char + 1
			elif nextChar$ = "z"
				phoneme = 44002
				char = char + 1
			elif nextChar$ = "i"
				phoneme = 54102
				if index ("aeiouyąęĄĘóÓ", nextNextChar$) > 0
					char = char + 1
				endif
			else
				phoneme = 34002
			endif
		elif char$ = "ć" or char$ = "Ć"
			phoneme = 54102
		elif char$ = "d"
			if (nextChar$ = "z" and nextNextChar$ = "i")
			... or nextChar$ = "ź" or nextChar$ = "Ź"
				phoneme = 54112
				if nextNextChar$ = "i"
				... and (index ("aeiouyąęĄĘóÓ", nextNextNextChar$) > 0)
					char = char + 2
				else
					char = char + 1
				endif
			elif nextChar$ = "z"
				phoneme = 34012
				char = char + 1
			elif nextChar$ = "ż"
				phoneme = 44012
				char = char + 1
			else
				phoneme = 32012
			endif
		elif char$ = "e"
			phoneme = 2
		elif char$ = "ę" or char$ = "Ę"
			phoneme = 32
		elif char$ = "f"
			phoneme = 23002
		elif char$ = "g"
			phoneme = 62012
		elif char$ = "h"
			phoneme = 63002
		elif char$ = "i"
			if index ("szcn ", prevChar$) = 0
			... and index ("aeiouyąęĄĘóÓ", nextChar$) > 0
				phoneme = 5511
			else
				phoneme = 5
			endif
		elif char$ = "j"
			phoneme = 5511
		elif char$ = "k"
			phoneme = 62002
		elif char$ = "l"
			phoneme = 38013
		elif char$ = "ł" or char$ = "Ł"
			phoneme = 65013
		elif char$ = "m"
			phoneme = 11013
		elif char$ = "n"
			if nextChar$ = "i"
				phoneme = 51113
				if index ("aeiouyąęĄĘóÓ", nextNextChar$) > 0
					char = char + 1
				endif
			else
				phoneme = 31013
			endif
		elif char$ = "ń" or char$ = "Ń"
			phoneme = 51113
		elif char$ = "o"
			phoneme = 3
		elif char$ = "ó" or char$ = "Ó"
			phoneme = 1
		elif char$ = "p"
			phoneme = 12002
		elif char$ = "r"
			if nextChar$ = "z"
				phoneme = 43022
				char = char + 1
			else
				phoneme = 37013
			endif
		elif char$ = "s"
			if nextChar$ = "i"
				phoneme = 53102
				if index ("aeiouyąęĄĘóÓ", nextNextChar$) > 0
					char = char + 1
				endif
			elif nextChar$ = "z"
				phoneme = 43002
				char = char + 1
			else
				phoneme = 33002
			endif
		elif char$ = "ś" or char$ = "Ś"
			phoneme = 53102
		elif char$ = "t"
			phoneme = 32002
		elif char$ = "u"
			# only change "u" to "w" if it is not in the suffix "-uX"
			if index ("", prevChar$) = 0 and index ("ae", prevChar$) > 0
			... and index ("&", nextNextChar$) = 0
				phoneme = 65013
			else
				phoneme = 1
			endif
		elif char$ = "w" or char$ = "v"
			phoneme = 23012
		elif char$ = "y"
			phoneme = 6
		elif char$ = "z"
			if nextChar$ = "i"
				phoneme = 53112
				if index ("aeiouyąęĄĘóÓ", nextNextChar$) > 0
					char = char + 1
				endif
			else
				phoneme = 33012
			endif
		elif char$ = "ź" or char$ = "Ź"
			phoneme = 53112
		elif char$ = "ż" or char$ = "Ż"
			phoneme = 43012
		elif char$ = " "
			phoneme = 9999
		endif

		# The next line writes individual "phonemes" to the table:

		selectObject: data
		Set numeric value: i, "ph'numberOfPhones'", 'phoneme'
	endfor

	# The following part reproduces the assimilation of voice and place,
	# palatalization rules, the realization of nasal diphthongs and other allophonic
	# changes. Since these rules are mostly regressive the numbering of phonemes is
	# reversed by the following for cycle. It REWRITES the values in the table of
	# "phonemes".

	for enohp from 1 to numberOfPhones
		phoneNr = (numberOfPhones + 1) - enohp
		phoneValue = Get value: i, "ph'phoneNr'"
		prevPhone = phoneNr - 1
		prevPrevPhone = phoneNr - 2
		nextPhone = phoneNr + 1
		nextNextPhone = phoneNr + 2
		diph = 0

		# nextNextPhoneValue are defined for phones followed by a "space". For the last
		# phoneNr next(Next)Phone$ is defined as "9000", i.e. "following pause".
		if phoneNr < numberOfPhones
			nextPhoneValue = Get value: i, "ph'nextPhone'"
			if phoneNr < (numberOfPhones - 1)
				nextNextPhoneValue = Get value: i, "ph'nextNextPhone'"
			else
				nextNextPhoneValue = 9000
			endif
		else
			nextPhoneValue = 9000
			nextNextPhoneValue = 9000
		endif

		# prev(Prev)Phone$ are defined for phones preceded by a "space". For the first
		# phoneNr prev(Prev)Phone$ is defined as "9009", i.g. "preceding pause".
		if phoneNr > 1
			prevPhoneValue = Get value: i, "ph'prevPhone'"
			if phoneNr > 2
				prevPrevPhoneValue = Get value: i, "ph'prevPrevPhone'"
			else
				prevPrevPhoneValue = 9009
			endif
		else
			prevPhoneValue = 9009
			prevPrevPhoneValue = 9009
		endif


		# Individual "phonemes" are not devoiced:
		if numberOfPhones = 1
			phoneValue = phoneValue

		# Voice assimilation for "rz", i.e. /ʐ/, which, however, behaves differently
		# from /ʐ/ spelled as "ż":
		elif phoneValue = 43022
			if (rindex (string$ (nextPhoneValue), "0") = 4)
			... or (nextPhoneValue = 9999
			... and mid$ (string$ (nextNextPhoneValue), 4, 1) = "0")
			... or (rindex (string$ (prevPhoneValue), "0") = 4)
				phoneValue = 43002
			else
				phoneValue = 43012
			endif

		# Voice assimilation for "w", i.e. /v/:
		elif phoneValue = 23012
			if (rindex (string$ (nextPhoneValue), "0") = 4)
			... or (rindex (string$ (prevPhoneValue), "0") = 4)
			... or (nextPhoneValue = 9999
			... and mid$ (string$ (nextNextPhoneValue), 4, 1) = "0")
			... or (rindex (string$ (prevPrevPhoneValue), "0") = 4
			... and rindex (string$ (prevPhoneValue), "7") = 2)
				phoneValue = 23002
			else
				phoneValue = 23012
			endif

		# Voiced obstruents are devoiced if followed by pause, or if the next sound (it
		# may be in the next word) is voiceless (it has the value: xxx0x)
		elif rindex (string$ (phoneValue), "2") = 5
		... and rindex (string$ (phoneValue), "1") = 4
			if rindex (string$ (nextPhoneValue), "0") = 4
			... or (nextPhoneValue = 9999
			... and (rindex (string$ (nextNextPhoneValue), "0") = 4
			... or (variety = 1
			... and rindex (string$ (nextNextPhoneValue), "2") <> 5)))
				phoneValue = phoneValue - 10

			else
				# Report Cracow-Poznan voice assimilation:
				if nextPhoneValue = 9999
				... and rindex (string$ (nextNextPhoneValue), "2") <> 5
				... and show_assimilation = 1
					ipaPhonePozn$ = ipa'phoneValue'$
					ipaNextPhonePozn$ = ipa'nextNextPhoneValue'$
					appendInfoLine: i + 1, ": /", ipaPhonePozn$, "/ + /",
					... ipaNextPhonePozn$, "/ is realized as [", ipaPhonePozn$,
					... " + ", ipaNextPhonePozn$, "]"
				endif
			endif

		elif rindex (string$ (phoneValue), "2") = 5
		... and rindex (string$ (phoneValue), "0") = 4
			if rindex (string$ (nextPhoneValue), "1") = 4
			... and rindex (string$ (nextPhoneValue), "2") = 5
			... or (nextPhoneValue = 9999
			... and rindex (string$ (nextNextPhoneValue), "1") = 4
			... and (rindex (string$ (nextNextPhoneValue), "2") = 5
			... or variety = 2))

				# Report Cracow-Poznan voice assimilation:
				if nextPhoneValue = 9999
				... and rindex (string$ (nextNextPhoneValue), "2") <> 5
				... and show_assimilation = 1
					v = phoneValue + 10
					ipaPhonePozn$ = ipa'phoneValue'$
					ipaPhonePoznVoiced$ = ipa'v'$
					ipaNextPhonePozn$ = ipa'nextNextPhoneValue'$
					appendInfoLine: i + 1, ": /", ipaPhonePozn$, "/ + /",
					... ipaNextPhonePozn$, "/ became [", ipaPhonePoznVoiced$,
					... " + ", ipaNextPhonePozn$, "]"
				endif
				phoneValue = phoneValue + 10
			endif
		endif

		# Assimilation of place for alveolars:
		if nextPhoneValue <> 4 and index (string$ (nextPhoneValue), "4" ) = 1
		... or (nextPhoneValue = 9999
		... and index (string$ (nextNextPhoneValue), "4" ) = 1)
			if phoneValue = 31013 or phoneValue = 32002 or phoneValue = 32012
				phoneValue = phoneValue + 10000
			endif

		# Velarizatin of /n/ (vowel /ɨ/ has to be prevented from triggering this
		# assimilation by "nextPhoneValue > 30"):
		elif (index (string$ (nextPhoneValue), "6" ) = 1
		... and nextPhoneValue > 30) and phoneValue = 31013
			phoneValue = phoneValue + 30000
		endif

		# Voice assimilation for sonorants: "n, m, ń, r, l, ł":
		# The sound has to be: a devoicable sonorant (xxxx3); it has to be voiced
		# (xxx1x); it has to be precede by an obstruent (xxxx2), pause (9009) or word
		# boundary (9999); # and it has to be followed by a voiceless sound (xxx0) or a
		# pause (9999) and a voiceless sound.
		if rindex (string$ (phoneValue), "3") = 5
		... and rindex (string$ (phoneValue), "1") = 4
		... and (rindex (string$ (prevPhoneValue), "2") = 5
		... or index (string$ (prevPhoneValue), "9") = 1)
		... and (rindex (string$ (nextPhoneValue), "0") = 4
		... or (nextPhoneValue = 9999
		... and rindex (string$ (nextNextPhoneValue), "0") = 4))
			phoneValue = phoneValue - 10

		# nasal diphthongs:
		elif phoneValue = 33 or phoneValue = 32

			# for "ą", "ę" followed by /l/ and /w/ and for final "ę", the diphthong becomes
			# a non-nasal monophthong:
			if index (string$ (nextPhoneValue), "38") = 1
			... or index (string$ (nextPhoneValue), "65") = 1
			... or (phoneValue = 32
			... and index (string$ (nextPhoneValue), "9") = 1)
				phoneValue = phoneValue - 30
			else
				diph = 1
				phoneValue = phoneValue - 30

				# if the following sound is a palatal fricative:
				if index (string$ (nextPhoneValue), "53") = 1
					nasal = 56114

				# if a non-palatal fricative or pause follows:
				elif index (right$ (string$ (nextPhoneValue), 4), "3") = 1
				... or index (string$ (nextPhoneValue), "9") = 1
					nasal = 66014

				# if a stop or affricate follows:
				else
					nasal = number (left$ (string$ (nextPhoneValue), 1) + "1"
					... + mid$ (string$ (nextPhoneValue), 3, 1) + "13")
				endif
			endif

		# If the palatal nasal /ɲ/, spelled as "ń", is not in final position
		# and not followed by a vowel:
		elif phoneValue = 51113
		... and index (string$ (nextPhoneValue), "9") <> 1
		... and nextPhoneValue > 25

			# Before fricatives it becomes a nasal approximant:
			if mid$ (string$ (nextPhoneValue), 2, 1) = "3"
				phoneValue = 56114

			# Before stops and affricates: the nasal assimilates to the place of
			# articulation of the following sound:
			else
				diph = 1
				phoneValue = 5511
				nasal = number (left$ (string$ (nextPhoneValue), 1) + "1"
				... + mid$ (string$ (nextPhoneValue), 3, 1) + "13")
			endif

		# Nasal stops /m/ and /n/ followed by a labiodental, alveolar or retroflex fricative, and
		# preceded by a vowel are produced as [w̃]; when followed by a palatal fricative,
		# they are produced as nasal [j̃]:
		elif mid$ (string$ (phoneValue), 2, 1) = "1"
		... and (mid$ (string$ (nextPhoneValue), 2, 1) = "3")
		... and nextPhoneValue > 30
		... and prevPhoneValue < 30
			if index (string$ (nextPhoneValue), "5") = 1
				phoneValue = 56114
			else
				phoneValue = 66014
			endif
		endif

		# Palatalization rules for sounds other than palatals and vowels if followed by
		# a palatal or palatalized sound: the current phoneValue must not be a palatal
		# sound, a vowel (or a nasal diphthong); the nextPhoneValue has to be palatal or
		# palatalized (xx1xx); or if there is a space between the words, the first sound
		# of the next word has to be palatal or palatalized:

		if phoneValue > 33 and mid$ (string$ (phoneValue), 3, 1) = "0"
		... and phoneValue <> 66014
		... and (mid$ (string$ (nextPhoneValue), 3, 1) = "1"
		... or nextPhoneValue = 5 or (nextPhoneValue = 9999
		... and (mid$ (string$ (nextNextPhoneValue), 3, 1) = "1"
		... or nextNextPhoneValue = 5)))

			# velars are special since after them /j/, i.e. "5511" is dropped:
			if index (string$ (phoneValue), "62") = 1 and nextPhoneValue = 5511
				ipa = length (ipa$)
				ipa$ = right$ (ipa$, ipa -1)
				as = length (as$)
				# AS uses a diacritic for /j/, therefore two positions
				# have to be subtracted
				as$ = right$ (as$, as - 2)
			endif
			phoneValue = phoneValue + 100

		# Changed articulation of vowels between palatal or palatalized sounds:
		elif phoneValue < 5 and mid$ (string$ (prevPhoneValue), 3, 1) = "1"
		... and (mid$ (string$ (nextPhoneValue), 3, 1) = "1" or (nextPhoneValue
		... = 9999 and mid$ (string$ (nextNextPhoneValue), 3, 1) = "1"))
			phoneValue = phoneValue + 20
		endif


		# Rewrite the value of "phoneValue"/"phoneme$" in the table:
		selectObject: data
		Set numeric value: i, "ph'phoneNr'", phoneValue

		### Append the phoneValue at the beginning of the word/phrase that is
		### being transcribed:
		# Geminates:
		# For IPA the previous sound has to be the same or its non-palatalized
		# counterpart (xx0xx)
		if (phoneValue = prevPhoneValue) or (phoneValue = prevPhoneValue + 100)
		... or (phoneValue = prevPhoneValue - 100)
			ipaPhoneValue$ = "ː"
			asPhoneValue$ = as'phoneValue'$
		elif phoneValue = nextPhoneValue
			ipaPhoneValue$ = ipa'phoneValue'$
			asPhoneValue$ = "•"
		else
			ipaPhoneValue$ = ipa'phoneValue'$
			asPhoneValue$ = as'phoneValue'$
		endif

		# if the phone is a "nasal diphthong", the nasal is added to the phone:
		if diph = 1
			ipaNasal$ = ipa'nasal'$
			asNasal$ = as'nasal'$
			ipaPhoneValue$ = ipaPhoneValue$ + ipaNasal$
			asPhoneValue$ = asPhoneValue$ + asNasal$
			dipth = 0
		endif

		ipa$ = ipaPhoneValue$ + ipa$
		as$ = asPhoneValue$ + as$
	endfor

		# Write the IPA transcription in the table:
		selectObject: data
		if transcribe_to_ipa = 1
			Set string value: i, "ipa", ipa$
		endif
		if transcribe_to_as = 1
			Set string value: i, "as", as$
		endif

	label SKIP_ITEM
endfor

Remove column: "lowerCase"

if remove_phone_columns = 1
	for p to phoneCol
		Remove column: "ph'p'"
	endfor
endif

if folder = 1
	fileSave$ = "'origFolder$''fileName$'_transcribed.csv"
	Save as 'separator$'-separated file: fileSave$
	appendInfoLine: "Saved as ", fileSave$
else
	fileSave$ = chooseWriteFile$: "Save as a 'separator$'-separated file",
	... "'fileName$'_transcribed.csv"
	if fileSave$ <> ""
		Save as 'separator$'-separated file: fileSave$
		appendInfoLine: "Saved as ", fileSave$
	endif
endif

if remove = 1
	selectObject: data
	Remove
else
	selectObject: data
	View & Edit
endif

label CANCEL

###########
# todo:
###########

# get rid of the goto's

###########
# repaired:
###########

# <m> before <fw> becomes [w̃]
# <u> before after vowels final and before final consonants does not become [w]
# correct rendition of geminated palatalized consonants
# replaced \.v, \.^ and \,v with unicode diacritics
# replaced all backslash trigraphs with Unicode characters
# replaced symbols for changed vowels <ȧėȯ>
# replaced copyleft notice with copyright notice
