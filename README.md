Popa - Polish Orthography to Phonetic Alphabets
===============================================

README

The IPA transcription is partially based on: Wągiel, Marcin. 2012.
"Fonologie polštiny v pojetí axiomatického funkcionalismu" (MA diploma
thesis) and on an so far unpublished article: Wągiel, Marcin.
"Międzynarodowy alfabet fonetyczny (IPA) w transkrypcji fonetycznej języka
polskiego". In Stanisław Gajda and Irena Jokiel (eds.), Polonistyka wobec
wyzwań współczesności. V Kongres Polonistyki Zagranicznej, vol. II.
Opole: Wydawnictwo UO. 134–145

BEFORE RUNNING THIS SCRIPT: The script converts orthography into IPA. You
have to provide a .csv or .tsv file which has a column with "orth"
(without the quotes) written in its first row and with the text to be
converted in this column. There can be empty rows.

Known issues:
* Some programs (e.g. MS Excel) can have troubles reading the resulting
table correctly. This is because of diffenreces in encoding of special
Polish characters and phonetic symbols. The problem can be avoided by
selecting UTF-8 in the "Text writing preferences..." in the "Preferences"
submenu of the Praat menu. Then you have to select UTF-8 again when you
open the file from, e.g. MS Excel.
* The convertor does not handle correctly exceptional voice assimilation
of function words (e.g., the prepositions "pod, bez") and prefixes (e.g.,
"przeciwrdzewny" should be [pʂɛtɕifrdzɛwnɨ] but is [pʂɛtɕivrdzɛwnɨ]).
* The convertor does not handle correctly assimilation of place across
morphological boundaries (e.g., "bankom" and "fankom", should have [ηk]
and [nk] respectively but both are transcribed with [ηk], since this is
the pronunciation in some Polish varieties, whereas no variety has only
[nk] in these words).
* The convertor cannot handle foreign words with original orthography
(e.g. weekend, jazz, menu).
* Neither does is handle correctly the "foreign" letters "q" and "x" or
any foreign accents and diacritics.
* Praat does not have a trigraph for "dot below", "dot above", and "comma
below" which in AS are used for retroflexion, raized articulation of
vowels, and devoicing respectively. In the script, these diacritics are
represented as unicode characters, in contrast to other non-latin symbols
which are represented as backslash trigraphs. The combination of "dot
below" and "comma below" for devoiced retroflex (palatalized) /n/ is only
correctly rendered in fonts with good Unicode support such as DoulosSIL.
In fact, this combination may never really be needed, since there are
probably no contexts where /n/ would become devoiced and retroflex at the
same time. This possibility is there, however, for completeness' sake.


PREPARE YOUR DATA:
You need a file (preferably a .csv or .txt file, possibly also .xls, but
formatting may cause problems, .doc does not work at all.) with the
words/texts you want to transcribe. It is useful to have one phrase per line,
there just has to be a title of the column in the first line - (orth) by
defaul. You can have other columns in your file, but if you do, you have to
use the same field delimiter in the file and in the script. If there are
commas in your text make sure you select "tab" as the delimiter.

OPEN THE SCRIPT in praat (Open Praat script... in the main window) and
run it (press Ctrl-R on your keyboard, or click Run in the Run menu of
the script window).
The transcription is saved as "YOUR_FILE_NAME_transcribed.csv".

HOW IT WORKS:
The codes for consonants are a combination of five digits:
* place of articulation (1-6)
* manner of articulation (1-8)
* palatalization (0 or 1)
* voicing (0=voiceless, 1=voiced, 2 for "rz")
* consonant class (2 = obstruent, 3 = devoicable sonorant, 4 = nasal
  approximant, /j/ is not defined)
The codes for vowels go from 1 to 6, with four positional variants (+ 20).
The codes for nasal diphthongs are 30 + the value of the particular vowel.
The code for a word boundary (space) is 9999.
The codes for preceding pause is 9009, for folowing pause it is 9000 (the
latter has a 0 on position 4, so it can work for final devoicing just like
voiceless sounds do.
