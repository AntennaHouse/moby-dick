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
