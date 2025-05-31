* [English](#en)
* [日本語](#ja)

----

# <a name="en"></a>Moby-Dick

Stylesheet for transforming TEI XML of the American first edition of 'Moby-Dick' into XSL-FO for formatting with AH Formatter. The formatted output is a pastiche, not a facsimile, of the 1851 first edition. For a description of aspects of the styling, see [Formatting Moby-Dick](https://github.com/AntennaHouse/moby-dick/raw/master/doc/formatting-moby-dick.pdf).

PDF of the formatted first edition is included in every release. See https://github.com/AntennaHouse/moby-dick/releases/latest

## Contributing

Issues, comments, and especially pull requests are all welcome.

## Installation

1. Clone the repository and its 'moby-dick-tei' submodule from https://github.com/AntennaHouse/moby-dick

   ```
   git clone --recurse-submodules  https://github.com/AntennaHouse/moby-dick.git
   ```

## Updating from GitHub

```
git pull --recurse-submodules origin master
```

## Generating PDF

Run `moby-pdf.bat` to generate `moby-dick.pdf`.

## Sources

The source XML is in the https://github.com/AntennaHouse/moby-dick-tei repository that is used as a submodule of this repository.

The XML is based on files from the 'Wright American Fiction' project:

- http://purl.dlib.indiana.edu/iudl/wright/VAC7237

The source XML has multiple differences from the Wright version. In particular, the Wright version lacks markup for page headers and uses empty elements to mark the start of italic text rather than enclosing the text.

The mark image is from the Project Gutenberg version:

- http://www.gutenberg.org/1/15/

## Automated Analysis

AH Formatter V7.0 and later are able to automatically detect a range of typographic problems in a formatted document. Solving these problems usually requires editorial or stylistic changes, and sometimes both.

'Moby-Dick' is used as an example for the Automated Analysis feature of AH Formatter V7.0 and later. See [Automated Analysis Example: Moby-Dick](https://github.com/AntennaHouse/moby-dick/raw/master/doc/automated-analysis-example.pdf).

Analysis and correction for Moby-Dick are automated to occur in separate stages for different error types. This is simply for ease of explanation. Fixing each type of error in a separate stage is not a realistic solution. It is simpler and easier to correct the errors by starting at the beginning of the document and fixing each error in sequence.

Run `stages.bat` to format and analyze multiple renditions of 'Moby-Dick' with successively more error corrections applied.

The types of corrections that are made are discussed in `doc/automated-analysis-example.pdf`. The stages are:

- Stage 1: Base<br>Baseline version with no corrections applied
- Stage 2: Paragraph Widow 1<br>Reduce the limit for Paragraph Widow errors to 2em because the original has many paragraph widows
- Stage 3: Paragraph Widow 2<br>Correct most of the remaining Paragraph Widows
- Stage 4: Text Repeated at Line Start or Line End<br>Correct the paragraphs with text repeated at the start or end of consecutive lines
- Stage 5: Consecutive Hyphens<br>Correct the paragraphs with too many consecutive hyphens
- Stage 6: White-space<br>Correct wide white-space
- Stage 7: River<br>Correct rivers
- Stage 8: Lines Before and After<br>Correct too few lines before or after a heading
- Stage 9: Unbalanced Spreads<br>Correct spreads where the last lines on the facing pages are uneven

`stages.bat` expects the analysis-utility files (available from the GitHub repository at https://github.com/AntennaHouse/analysis-utility) to be in a sibling directory. I.e., in `../analysis-utility`.

`stages.bat` requires AH Formatter V7.1 (or V7.0 MR4 or later) plus Java and Saxon 9 or later.  (AH Formatter V7.0 MR4 will report only paragraph widow errors. Use a later version if possible.)

Specify the full path of `AHFCmd.exe` with the `-ahfcmd` option.

Specify the full path of `analyzer.bat` with the `-analyzer` option.

Specify the full path of `saxon9he.jar` with the `-saxon` option.

`stages.bat` can be slow: 'Moby-Dick' formats as more than 650 pages. It is formatted multiple times, and multiple analysis reports are also produced.

## Page Images

Images of the first American edition are available from the Wright American Fiction project and also from the Herman Melville Electronic Library at https://melville.electroniclibrary.org/moby-dick-the-whale-proofs.html.

## Developing the stylesheets

See "[Developing the Stylesheets](developing.md)".

## License

Copyright 2020-2021 Antenna House

### XSLT

XSLT files are licensed under the Apache License:

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

### Fonts

Fonts have their own licenses.

----

# <a name="ja"></a>白鯨「モービー・ディック」

「白鯨」のアメリカ初版のTEIをAH Formatterで組版するためのXSL-FOに変換するための組版対象のXML とスタイルシート。

組版対象のXML はこのリポジトリのサブモジュールとして使用されている別の GitHub リポジトリにあります。

組版対象のXML は「Wright American Fiction」プロジェクトのファイルに基にしています：

- http://purl.dlib.indiana.edu/iudl/wright/VAC7237

組版対象のXML はWright版と複数の違いがあります。特に、Wright版には見出しのマークアップがなく、テキストを囲むのではなく、空要素を使用して斜体テキストの開始をマークします。

マークの画像は Project Gutenberg 版のものです:

- http://www.gutenberg.org/1/15/

## インストール方法

1. リポジトリとその 「moby-dick-tei」サブモジュール を https://github.com/AntennaHouse/moby-dick
からクローンします。

   ```
   git clone --recurse-submodules  https://github.com/AntennaHouse/moby-dick.git
   ```

## GitHubからの更新

```
git pull --recurse-submodules origin master
```

## PDFの生成

`moby-pdf.bat`を実行して`moby-dick.pdf`を生成します。

## 組版結果の自動分析

AH Formatter V7.0 以降は、組版した文書内のさまざまな組版上の問題を自動的に検出できます。検出された問題を解決するには、通常、編集上または体裁上の変更が必要です。両方の変更が必要な場合もあります。

「白鯨」 は、AH Formatter V7.0以降の組版結果の自動分析の機能の例として使用しています。分析と修正は、イラー種類に応じて別々のステージで発生するように自動化されています。これは、説明を簡単にするためです。それぞれのエラーを別々のステージで修正することは、現実的な解決策ではありません。文書の先頭から順番にエラーを修正していく方がシムプルで簡単です。

 `stages.bat` を実行して、「白鯨」の複数のレンディションを組版して分析し、エラー修正を順次に適用します。

行われた修正については`doc/automated-analysis-example.pdf`で説明しています。ステージは以下のとおりです:

- ステージ 1: ベース<br>ベースライン版に修正を適用していません。 
- ステージ 2: 段落ウィドウ１<br>原典には多くの段落ウィドウエラーがあるため、段落ウィドウエラーの制限を2emに縮小します。 
- ステージ 3: 段落ウィドウ 2<br>残っているほとんどの段落ウィドウを修正します。
- ステージ 4: 同じ単語が行頭や行末で連続する行<br>同じ単語が行頭や行末で連続する行を修正します。
- ステージ 5: 連続ハイフン<br>連続したハイフンが多い段落を修正します。
- ステージ 6: 空白<br>広い空白を修正します。
- ステージ 7: リバー<br>リバーを修正します。
- ステージ 8: 前後の行数<br>見出しの前後の行数が少なすぎるのを修正します。
- ステージ 9: 不均衡な見開きページ<br>見開きページの最後の行が不揃いになっているのを修正します。

`stages.bat` は、分析ユーティリティファイルが兄弟ディレクトリにあることを期待しています。(GitHub リポジトリの https://github.com/AntennaHouse/analysis-utilityで入手できます。) 
つまり、 `../analysis-utility`内にあります。

`stages.bat` AH Formatter V7.1 (または V7.0 MR4 以降) と Java と Saxon 9 以降が必要とします。  (AH Formatter V7.0 MR4 は段落ウィドウのみを報告します。できれば、後の版を使用した方が良いです。)

`AHFCmd.exe`を`-ahfcmd` オプションで指定します。

`analyzer.bat`を`-analyzer` オプションで指定します。

`saxon9he.jar`を `-saxon` オプションで指定します。

`stages.bat` は遅い場合もあります: 「白鯨」は６５０ページ以上組版しています。 何度も組版し、分析報告も複数作成しています。

## Page Images

アメリカの初版の画像は、 Wright American Fiction プロジェクトのほか、　

https://melville.electroniclibrary.org/moby-dick-the-whale-proofs.html
のハーマン・メルヴィルの電子図書館から入手できます。

## Developing the stylesheets

[Developing the Stylesheets](developing.md)を参照してください。

## License

Copyright 2020-2021 Antenna House

### XSLT

XSLT ファイルは Apache Licenseにに基づいています:

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

### Fonts

それぞれのフォントは独自のライセンスがあります。
