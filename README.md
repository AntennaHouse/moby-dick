# Moby-Dick

Source XML and stylesheet for transforming TEI of first American edition of 'Moby-Dick' into XSL-FO for formatting with AH Formatter.

Source XML is based on files from 'Wright American Fiction' project:

- http://purl.dlib.indiana.edu/iudl/wright/VAC7237

The source XML has multiple differences from the Wright version. In particular, the Wright version lacks markup for page headers and uses empty elements to mark the start of italic text rather than enclosing the text.

The mark image is from the Project Gutenberg version:

- http://www.gutenberg.org/1/15/

## Automated Analysis

AH Formatter V7.0 and later are able to automatically detect a range of typographic problems in a formatted document. Solving these problems usually requires editorial or stylistic changes, and sometimes both.

'Moby-Dick' is used as an example for the Automated Analysis feature of AH Formatter V7.0 and later. Analysis and correction are automated to occur in separate stages for different error types. This is simply for ease of explanation. In practice, errors can be corrected in any useful sequence.

Run `stages.bat` to format and analyse multiple renditions of 'Moby-Dick' with successively more error corrections applied.

The types of corrections that are made are discussed in `doc/automated-analysis-example.docx`. The stages are:

- Stage 1: Base<br>Baseline version with no corrections applied
- Stage 2: Paragraph Widow 1<br>Reduce the limit for Paragraph Widow errors to 2em because the original has many paragraph widows
- Stage 3: Paragraph Widow 2<br>Correct most of the remaining Paragraph Widows
- Stage 4: Text Repeated at Line Start or Line End<br>Correct the paragraphs with text repeated at the start or end of consecutive lines
- Stage 5: Consecutive Hyphens<br>Correct the paragraphs with too many consecutive hyphens
- Stage 5: White-space<br>Correct wide white-space

`stages.bat` expects the analysis-utility files (available from the GitHub repository at https://github.com/AntennaHouse/analysis-utility) to be in a sibling directory. I.e., in `../analysis-utility`.

`stages.bat` requires AH Formatter V7.1 (or V7.0 MR4 or later) plus Java and Saxon 9 or later.  (AH Formatter V7.0 MR4 will report only paragraph widow errors. Use a later version if possible.)

Specify the full path of `AHFCmd.exe` with the `-ahfcmd` option.

Specify the full path of `analyzer.bat` with the `-analyzer` option.

Specify the full path of `saxon9he.jar` with the `-saxon` option.

`stages.bat` can be slow: 'Moby-Dick' formats as more than 650 pages. It is formatted eight times, and four analysis reports are also produced.

## Page Images

Images of the first American edition are available from the Wright American Fiction project and also from the Herman Melville Electronic Library at https://melville.electroniclibrary.org/moby-dick-the-whale-proofs.html.
