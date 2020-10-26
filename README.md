# Moby-Dick

Source XML and stylesheet for transforming TEI of first American edition of 'Moby-Dick' into XSL-FO for formatting with AH Formatter.

Source XML is based on files from 'Wright American Fiction' project:

- http://webapp1.dlib.indiana.edu/TEIgeneral/view?docId=wright/VAC7237.xml

The source XML has multiple differences from the Wright version. In particular, the Wright version lacks markup for page headers and uses empty elements to mark the start of italic text rather than enclosing the text.

The mark image is from the Project Gutenberg version:

- http://www.gutenberg.org/1/15/

## Automated Analysis

Run `stages.bat` to format and analyse multiple renditions of 'Moby-Dick' with successively more error corrections applied.

`stages.bat` expects the analysis-utility files (available from the GitHub repository) to be in a sibling directory. I.e., in `../analysis-utility`.

`stages.bat` requires AH Formatter V7.0, Java, and Saxon 9 or later.  (AH Formatter V7.0 MR4 will report only paragraph widow errors. Use a later version if possible.)

Specify the full path of `AHFCmd.exe` with the `-ahfcmd` option.

Specify the full path of `saxon9he.jar` with the `-saxon` option.

`stages.bat` can be slow: 'Moby-Dick' formats as more than 650 pages. It is formatted eight times, and four analysis reports are also produced.

The types of corrections that are made are discussed in `doc/automated-analysis-example.docx`.

## Page Images

Images of the first American edition are available from the Wright American Fiction project and also from the Herman Melville Electronic Library at https://melville.electroniclibrary.org/moby-dick-the-whale-proofs.html.
