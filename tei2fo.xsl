<?xml version='1.0' encoding='UTF-8'?>
<!DOCTYPE xsl:stylesheet [
<!ENTITY lsquo '&#x2018;' >
<!ENTITY rsquo '&#x2019;' >
<!ENTITY ldquo '&#x201C;' >
<!ENTITY rdquo '&#x201D;' >
<!ENTITY nbsp  '&#xA0;' >
<!ENTITY ndash '&#x2013;' >
<!ENTITY times '&#xD7;' >
]>

<!-- Copyright 2020-2021 Antenna House, Inc. -->
<!-- 'Moby-Dick' first edition. -->
<!-- http://purl.dlib.indiana.edu/iudl/wright/VAC7237 -->

<xsl:stylesheet
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:m="http://www.mentea.net/"
    xmlns:ahf="http://www.antennahouse.com/names/XSLT/Functions/Document"
    xmlns:axf="http://www.antennahouse.com/names/XSL/Extensions"
    xmlns:xhtml="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="ahf m tei xs xhtml"
    version="3.0">


<!-- ============================================================= -->
<!-- IMPORTS                                                       -->
<!-- ============================================================= -->

<xsl:import href="fo-layout.xsl"/>

<xsl:output
    method="xml"
    omit-xml-declaration='yes'
    indent="yes"
    encoding="UTF-8"/>


<!-- ============================================================= -->
<!-- xsl:strip-space                                               -->
<!-- ============================================================= -->

<xsl:strip-space elements="*" />


<!-- ============================================================= -->
<!-- KEYS                                                          -->
<!-- ============================================================= -->

<xsl:key
    name="footnote"
    match="note[@place = 'foot']"
    use="@xml:id" />

<!-- ============================================================= -->
<!-- STYLESHEET PARAMETERS                                         -->
<!-- ============================================================= -->

<xsl:param
    name="debug"
    select="'no'"
    as="xs:string" />

<xsl:param
    name="font-size"
    select="'8pt'"
    as="xs:string" />

<xsl:param
    name="line-height"
    select="'11.5pt'"
    as="xs:string" />

<xsl:param
    name="lang"
    select="'en'"
    as="xs:string" />

<xsl:param
    name="font-family-default"
    select="'source-serif-pro, Century, ''Times New Roman'', serif'"
    as="xs:string" />


<!-- ============================================================= -->
<!-- TEMPLATES                                                     -->
<!-- ============================================================= -->

<!-- axf:hyphenation-info -->
<!-- This template is just a convenience feature to allow any
     stylesheet(s) that import this stylesheet to add additional
     hyphenation information.

     Any stylesheet that imports this stylesheet and adds hyphenation
     information should use xsl:apply-imports to also use this
     template.  For example:

       <xsl:template match="axf:hyphenation-info"
                     mode="axf:hyphenation-info">
         <xsl:apply-imports />
         <axf:hyphenation-info
             language="eng"
             xmlns:axh="http://www.antennahouse.com/names/XSL/Hyphenations">
           <axh:exceptions>
             Phædon
           </axh:exceptions>
         </axf:hyphenation-info>
       </xsl:template>

     This template is necessary only because the corrections for
     errors found by the automated analysis have been broken into
     multiple stages that each can add additional hyphenation
     exceptions.  If this was one stylesheet, or if all the
     hyphenation exceptions were handled together, then this template
     would not be necessary.
-->
<xsl:template match="axf:hyphenation-info"
              mode="axf:hyphenation-info">
  <xsl:copy-of select="." />
</xsl:template>

<xsl:template name="declarations">
  <fo:declarations>
    <axf:document-info
        name="document-title"
        value="{/TEI/teiHeader/fileDesc/titleStmt/title}" />
    <axf:document-info
        name="author"
        value="{/TEI/teiHeader/fileDesc/titleStmt/author}" />
    <axf:document-info name="displaydoctitle" value="true" />
    <axf:document-info name="pagelayout" value="TwoPageRight" />
    <axf:document-info name="pagemode" value="useNone" />
    <axf:font-face src="url('bosox/BosoxFull-1ege.ttf')"
                   font-family="bosox"
                   font-weight="bold" />
    <axf:font-face src="url('harrowgate/harrowgate.regular.ttf')"
                   font-family="harrowgate" />
    <axf:font-face src="url('pinewood/pinewood-g2a3.ttf')"
                   font-family="pinewood" />
    <axf:font-face src="url('SourceSerifPro/SourceSerifPro-Regular.otf')"
                   font-family="source-serif-pro" />
    <axf:font-face src="url('SourceSerifPro/SourceSerifPro-It.otf')"
                   font-family="source-serif-pro"
                   font-style="italic" />
    <xsl:variable name="axf:hyphenation-info"
                  as="element(axf:hyphenation-info)">
      <axf:hyphenation-info language="eng" src="exceptions.xml" />
    </xsl:variable>
    <xsl:apply-templates
        select="$axf:hyphenation-info"
        mode="axf:hyphenation-info" />
  </fo:declarations>
</xsl:template>

<xsl:template name="bookmark-tree">
  <fo:bookmark-tree>
    <fo:bookmark
        internal-destination="{text/front/titlePage/pb[1]/@xml:id}"
        font-weight="bold">
      <fo:bookmark-title>
        <xsl:value-of
            select="teiHeader/fileDesc/titleStmt/title" />
      </fo:bookmark-title>
    </fo:bookmark>
    <xsl:for-each select="text/front/div[@type = 'contents']/list/item">
      <xsl:variable
          name="target"
          select="if (exists(ref))
                  then concat('chapter-', position())
                  else 'epilogue'"
          as="xs:string" />
      <fo:bookmark internal-destination="{$target}">
        <fo:bookmark-title>
          <xsl:choose>
            <xsl:when test="contains(., '—')">
              <xsl:value-of
                  select="replace(normalize-space(ahf:text(text())),
                                  '\.$', '')" />
            </xsl:when>
            <xsl:otherwise>
              <!-- 'Epilogue.', only. -->
              <xsl:value-of select="." />
            </xsl:otherwise>
          </xsl:choose>
        </fo:bookmark-title>
      </fo:bookmark>
    </xsl:for-each>
  </fo:bookmark-tree>
</xsl:template>

<xsl:template match="TEI">
  <fo:root font-size="{$font-size}"
           font-family="{$font-family-default}"
           font-selection-strategy="character-by-character"
           line-height="{$line-height}"
           hyphenation-keep="page"
           xml:lang="en">
    <xsl:call-template
        name="layout-master-set" />
    <xsl:call-template name="declarations" />
    <xsl:call-template name="bookmark-tree" />
    <!--
    <fo:page-sequence
        master-reference="PageMaster"
        writing-mode="from-page-master-region()"
        initial-page-number="auto-odd">
      <xsl:call-template name="PageMaster-static-content" />
      <fo:flow flow-name="xsl-region-body">
        <fo:block>
          <xsl:apply-templates select="teiHeader" />
        </fo:block>
      </fo:flow>
    </fo:page-sequence>
    -->
    <xsl:apply-templates select="text" />
  </fo:root>
</xsl:template>


<!-- ============================================================= -->
<!-- tei:titlePage                                                 -->
<!-- ============================================================= -->

<!-- 'MOBY-DICK; OR, THE WHALE' has different markup on the title page
     and the second fly title but has the same formatting.  Ignore the
     <titlePart> markup, which doesn't accurately describe the text
     anyway, and process the text. -->
<xsl:template match="docTitle | div[@type = 'fly_title']/head"
              priority="5">
  <fo:block
      font-size="24pt"
      letter-spacing="0.37em"
      line-height="1"
      text-align="center"
      font-stretch="extra-condensed">
    <xsl:analyze-string
        select="normalize-space(.)"
        regex="OR,">
      <xsl:matching-substring>
        <fo:block
            font-size="8pt" font-variant="all-small-caps"
            font-stretch="normal"
            letter-spacing="0.125em" space-before="30pt">
          <xsl:value-of select="." />
        </fo:block>
      </xsl:matching-substring>
      <xsl:non-matching-substring>
        <fo:block axf:letter-spacing-side="start">
          <xsl:if test="contains(., 'THE WHALE.')">
            <xsl:attribute name="space-before" select="'30pt'" />
            <xsl:attribute name="letter-spacing" select="'0.9em'" />
          </xsl:if>
          <xsl:analyze-string
              select="."
              regex="\.| ">
            <xsl:matching-substring>
              <fo:inline letter-spacing="0.3em">
                <xsl:value-of select="." />
              </fo:inline>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
              <xsl:value-of select="." />
            </xsl:non-matching-substring>
          </xsl:analyze-string>
        </fo:block>
      </xsl:non-matching-substring>
    </xsl:analyze-string>
  </fo:block>
</xsl:template>

<xsl:template
    match="div[@type = 'fly_title']">
  <fo:page-sequence
      master-reference="CoverFrontMaster">
    <fo:flow flow-name="xsl-region-body" hyphenate="true"
             text-align="justify" line-height="11pt">
      <fo:block-container padding-top="1.6in">
        <xsl:apply-templates />
      </fo:block-container>
    </fo:flow>
  </fo:page-sequence>
</xsl:template>

<xsl:template match="byline">
  <fo:block text-align="center" hyphenate="false"
            font-variant="all-small-caps">
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<xsl:template match="byline/text()">
  <!-- Provide structure that is not in the source XML. -->
  <xsl:analyze-string select="normalize-space(ahf:text(.))"
                      regex="AUTHOR OF">
    <xsl:matching-substring>
      <fo:block space-before="9pt" font-size="6pt">
        <xsl:value-of select="." />
      </fo:block>
    </xsl:matching-substring>
    <xsl:non-matching-substring>
      <xsl:analyze-string select="."
                          regex="BY">
        <xsl:matching-substring>
          <fo:block space-before="30pt" font-stretch="normal">
            <xsl:value-of select="normalize-space(.)" />
          </fo:block>
        </xsl:matching-substring>
        <xsl:non-matching-substring>
          <fo:block space-before="5pt" font-size="6pt"
                    font-variant="all-small-caps">
            <xsl:value-of select="normalize-space(.)" />
          </fo:block>
        </xsl:non-matching-substring>
      </xsl:analyze-string>
    </xsl:non-matching-substring>
  </xsl:analyze-string>
</xsl:template>

<xsl:template
    match="docAuthor">
  <fo:block  space-before="23pt" font-size="15pt"
             font-stretch="extra-condensed" letter-spacing="0.35em"
             axf:letter-spacing-side="start">
    <xsl:analyze-string select="normalize-space(.)"
                        regex=" ">
      <xsl:matching-substring>
        <fo:inline letter-spacing="0.5em">
          <xsl:value-of select="." />
        </fo:inline>
      </xsl:matching-substring>
      <xsl:non-matching-substring>
        <xsl:value-of select="." />
      </xsl:non-matching-substring>
    </xsl:analyze-string>
  </fo:block>
</xsl:template>

<xsl:template match="docImprint">
  <fo:block text-align="center" hyphenate="false" font-size="8pt" letter-spacing="0.24em" axf:letter-spacing-side="start">
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<xsl:template
    match="pubPlace[1]">
  <fo:block font-size="10pt" space-before="101pt" letter-spacing="0.33em">
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<xsl:template
    match="pubPlace[2]">
    <xsl:apply-templates />
    <xsl:text> </xsl:text>
</xsl:template>

<xsl:template
    match="publisher[1]">
  <fo:block space-before="6pt" space-after="5pt" font-size="8pt"
            letter-spacing="0.25em" axf:letter-spacing-side="start">
    <xsl:analyze-string select="normalize-space(.)"
                        regex="\.|,">
      <xsl:matching-substring>
        <fo:inline letter-spacing="0">
          <xsl:value-of select="." />
        </fo:inline>
      </xsl:matching-substring>
      <xsl:non-matching-substring>
        <xsl:value-of select="." />
      </xsl:non-matching-substring>
    </xsl:analyze-string>
  </fo:block>
</xsl:template>

<xsl:template match="docDate">
  <fo:block text-align="center" hyphenate="false" font-size="10pt"
            space-before="6pt" letter-spacing="0.2em"
            axf:letter-spacing-side="start">
    <xsl:analyze-string select="normalize-space(.)"
                        regex="\.">
      <xsl:matching-substring>
        <fo:inline letter-spacing="0">
          <xsl:value-of select="." />
        </fo:inline>
      </xsl:matching-substring>
      <xsl:non-matching-substring>
        <xsl:value-of select="." />
      </xsl:non-matching-substring>
    </xsl:analyze-string>
  </fo:block>
</xsl:template>

<xsl:attribute-set name="p">
  <xsl:attribute name="text-indent" select="'1.5em'" />
</xsl:attribute-set>

<xsl:template match="titlePage">
  <fo:page-sequence
      master-reference="CoverFrontMaster"
      format="i">
    <fo:flow flow-name="xsl-region-body" hyphenate="true"
             text-align="justify">
      <xsl:apply-templates />
    </fo:flow>
  </fo:page-sequence>
</xsl:template>


<!-- ============================================================= -->
<!-- TABLE OF CONTENTS                                             -->
<!-- ============================================================= -->

<xsl:template
    match="div[@type = 'contents']">
  <fo:page-sequence
      master-reference="CoverFrontMaster"
      initial-page-number="auto-odd"
      format="i">
    <xsl:call-template name="Contents-static-content" />
    <fo:flow flow-name="xsl-region-body" hyphenate="true"
             text-align="justify">
      <xsl:apply-templates />
    </fo:flow>
  </fo:page-sequence>
</xsl:template>

<xsl:template
    match="div[@type = 'contents']/head">
  <fo:block
      padding-before="0.16in"
      padding-after="0.24in" font-size="13pt"
      font-stretch="condensed" letter-spacing="0.28em"
      text-align="center"
      keep-with-next="always">
    <fo:marker marker-class-name="Chapter-Title">
      <xsl:apply-templates />
    </fo:marker>
    <xsl:apply-templates />
  </fo:block>
  <fo:block text-indent="0" text-align="center">
    <fo:external-graphic src="images/separator.svg"/>
  </fo:block>
</xsl:template>

<xsl:template match="div[@type = 'contents']/list">
  <fo:block-container
      column-count="2" column-gap="4pt"
      axf:column-rule-width="thin"
      axf:column-rule-style="solid"
      axf:column-rule-color="black"
      axf:column-rule-display="all"
      axf:column-rule-align="before"
      font-size="7pt" line-height="7.75pt"
      space-before="0.22in">
    <fo:table>
      <fo:table-column font-size="6pt" />
      <fo:table-header>
        <fo:table-row font-size="6pt" font-style="italic">
          <fo:table-cell
              text-align="center">
            <fo:block>Chap.</fo:block>
          </fo:table-cell>
          <fo:table-cell>
            <fo:block>&#xA0;</fo:block>
          </fo:table-cell>
          <!--<fo:table-cell>
            <fo:block>&#xA0;</fo:block>
          </fo:table-cell>-->
          <fo:table-cell
              text-align="right" number-columns-spanned="2">
            <fo:block>Page</fo:block>
          </fo:table-cell>
        </fo:table-row>
      </fo:table-header>
      <fo:table-body>
        <xsl:apply-templates select="item" />
      </fo:table-body>
    </fo:table>
  </fo:block-container>
</xsl:template>

<xsl:template match="div[@type = 'contents']/list/item"
              priority="5">
  <!-- Every chapter has a generated ID, and 'EPILOGUE.' is the only
       ToC entry without a page number. -->
  <xsl:variable
      name="target"
      select="if (exists(ref))
                then concat('chapter-', position())
              else 'epilogue'"
      as="xs:string" />

  <fo:table-row>
    <fo:table-cell
        text-align="right"
        font-variant="all-small-caps" font-size="from-table-column()">
      <fo:block>
        <fo:basic-link
              internal-destination="{$target}">
          <xsl:value-of select="substring-before(., '—')" />
        </fo:basic-link>
      </fo:block>
    </fo:table-cell>
    <fo:table-cell>
      <xsl:if test="contains(., '—')">
        <fo:block>—</fo:block>
      </xsl:if>
    </fo:table-cell>
    <fo:table-cell
        text-align="justify"
        start-indent="1em"
        text-indent="-1em">
      <fo:block axf:leader-expansion="force">
        <fo:basic-link
              internal-destination="{$target}">
          <xsl:choose>
            <xsl:when test="contains(., '—')">
              <xsl:value-of
                  select="replace(normalize-space(substring-after(ahf:text(text()), '—')),
                                  '\.$', '')" />
            </xsl:when>
            <xsl:otherwise>
              <!-- 'Epilogue.', only. -->
              <xsl:apply-templates />
            </xsl:otherwise>
          </xsl:choose>
        </fo:basic-link>
        <xsl:if test="exists(ref)">
          <fo:leader leader-pattern="dots"
                     leader-pattern-width="1em"
                     leader-alignment="end" />
        </xsl:if>
      </fo:block>
    </fo:table-cell>
    <fo:table-cell
        text-align="right"
        display-align="after"
        padding-left="4pt">
      <fo:block>
        <xsl:if test="exists(ref)">
          <fo:basic-link
              internal-destination="{$target}">
            <fo:page-number-citation ref-id="{$target}" />
          </fo:basic-link>
        </xsl:if>
      </fo:block>
    </fo:table-cell>
  </fo:table-row>
</xsl:template>


<!-- ============================================================= -->
<!-- ETYMOLOGY AND EXTRACTS                                        -->
<!-- ============================================================= -->

<xsl:template match="div[@type = 'intro_text']">
  <xsl:param name="font-size" select="'inherit'" as="xs:string" />
  <xsl:param name="line-height" select="'1rlh'" as="xs:string" />
  <xsl:param name="space-before" select="'0'" as="xs:string" />

  <fo:page-sequence
      master-reference="ExtractsMaster"
      format="i">
    <xsl:call-template name="Extracts-static-content" />
    <fo:flow flow-name="xsl-region-body" hyphenate="true"
             text-align="justify">
      <fo:marker marker-class-name="Chapter-Title">
        <xsl:apply-templates
            select="(fw[@type = 'head'], head)[1]/node()"
            mode="marker" />
      </fo:marker>
      <xsl:apply-templates select="head" />
      <fo:block text-indent="0" text-align="center"
                line-height="1rlh">
        <fo:external-graphic src="images/separator.svg" />
      </fo:block>
      <fo:block text-indent="0"
                font-size="{$font-size}"
                line-height="{$line-height}"
                space-before="{$space-before}">
        <xsl:apply-templates select="* except head" />
      </fo:block>
    </fo:flow>
  </fo:page-sequence>
</xsl:template>

<xsl:template
    match="div[@type = 'intro_text'][starts-with(head[1], 'EXTRACTS.')][2]"
    priority="5">
  <xsl:next-match>
    <xsl:with-param name="font-size" select="'8.9pt'" as="xs:string" />
    <xsl:with-param name="line-height" select="'9.4pt'" as="xs:string" />
    <xsl:with-param name="space-before" select="'0.26in'" as="xs:string" />
  </xsl:next-match>
</xsl:template>

<xsl:template
    match="div[@type = 'intro_text'][starts-with(head[1], 'ETYMOLOGY')][2]"
    priority="5">
  <xsl:next-match>
    <xsl:with-param name="line-height" select="'11pt'" as="xs:string" />
  </xsl:next-match>
</xsl:template>

<xsl:template
    match="div[@type = 'intro_text'][starts-with(head[1], 'ETYMOLOGY')][1]/head"
    priority="5">
  <fo:block
      text-align="center"
      space-before="1.37in" letter-spacing="0.35em" font-size="10pt"
      font-stretch="condensed"
      space-before.conditionality="retain"
      keep-with-next="always">
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<xsl:template
    match="div[@type = 'intro_text'][starts-with(head[1], 'ETYMOLOGY')][2]/head"
    priority="5">
  <fo:block
      text-align="center"
      space-before="0.4in" space-after="0.2in" letter-spacing="0.35em" font-size="10pt"
      space-before.conditionality="retain"
      keep-with-next="always">
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<xsl:template
    match="div[@type = 'intro_text']/head">
  <fo:block
      text-align="center"
      space-before="1.37in" letter-spacing="0.35em" font-size="10pt"
      font-stretch="condensed"
      space-before.conditionality="retain"
      keep-with-next="always">
    <xsl:if
        test="exists(head[@type = 'sub'] | fw[@type = 'head'])">
        <fo:marker marker-class-name="Chapter-Title">
          <xsl:apply-templates
              select="(fw[@type = 'head'], head[@type = 'sub'])[1]/node()"
              mode="marker" />
        </fo:marker>
    </xsl:if>
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<xsl:template
    match="div[@type = 'intro_text'][starts-with(head[1], 'ETYMOLOGY')]/head[@type = 'sub']"
    priority="10">
  <fo:block
      text-align="center"
      space-before="0.18in"
      space-after="0.14in" line-height="12pt"
      font-variant="all-small-caps" font-size="6pt" letter-spacing="0.3em"
      keep-with-next="always">
    <xsl:analyze-string select="normalize-space(.)"
                        regex="\(([^)]+)\.\)">
      <xsl:matching-substring>
        <xsl:text>(</xsl:text>
        <fo:inline font-variant="all-small-caps"
                   axf:letter-spacing-side="start">
          <xsl:value-of select="regex-group(1)" />
        </fo:inline>
        <fo:inline letter-spacing="0">.</fo:inline>
        <xsl:text>)</xsl:text>
      </xsl:matching-substring>
      <xsl:non-matching-substring>
        <xsl:value-of select="." />
      </xsl:non-matching-substring>
    </xsl:analyze-string>
  </fo:block>
</xsl:template>

<xsl:template
    match="div[@type = 'intro_text'][head[1] = 'ETYMOLOGY.']/p">
  <fo:block font-size="7pt" line-height="12pt"
            space-before="0.14in"
            axf:hyphenate-hyphenated-word="false"
            hyphenation-push-character-count="4"
            hyphenation-remain-character-count="4"
            xsl:use-attribute-sets="p">
      <xsl:apply-templates />
    </fo:block>
</xsl:template>

<xsl:template
    match="div[@type = 'intro_text'][head[1] = 'ETYMOLOGY']/p[1]">
  <fo:block space-before="0.2in"
            xsl:use-attribute-sets="p">
      <xsl:apply-templates />
    </fo:block>
</xsl:template>

<xsl:template
    match="div[@type = 'intro_text'][starts-with(head[1], 'EXTRACTS')][1]/head[1]"
    priority="10">
  <fo:block
      text-align="center" font-size="12pt"
                   font-stretch="condensed"
                   letter-spacing="0.4em"
                   axf:letter-spacing-side="start"
                   space-before="0.69in"
space-before.conditionality="retain"
keep-with-next="always">
    <xsl:analyze-string select="normalize-space(.)"
                        regex="\.">
      <xsl:matching-substring>
        <fo:inline letter-spacing="0">.</fo:inline>
      </xsl:matching-substring>
      <xsl:non-matching-substring>
        <xsl:value-of select="." />
      </xsl:non-matching-substring>
    </xsl:analyze-string>
  </fo:block>
</xsl:template>

<xsl:template
    match="div[@type = 'intro_text'][starts-with(head[1], 'EXTRACTS')][2]/head[1]"
    priority="10">
  <fo:block
      text-align="center" font-size="11pt"
                   letter-spacing="0.26em"
                   axf:letter-spacing-side="start"
                   space-before="56pt" space-after="0.23in"
                   font-stretch="condensed"
space-before.conditionality="retain"
keep-with-next="always">
    <xsl:analyze-string select="normalize-space(.)"
                        regex="\.">
      <xsl:matching-substring>
        <fo:inline letter-spacing="0">.</fo:inline>
      </xsl:matching-substring>
      <xsl:non-matching-substring>
        <xsl:value-of select="." />
      </xsl:non-matching-substring>
    </xsl:analyze-string>
  </fo:block>
</xsl:template>

<xsl:template match="head[@type = 'sub'][contains(., 'Sub-Sub')]"
              priority="10">
  <fo:block
      text-align="center"      
                   padding-before="0.15in"
                   padding-after="0.17in" font-stretch="expanded"
      font-family="harrowgate">
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<xsl:template
    match="div[@type = 'intro_text'][head[1] = 'EXTRACTS.'][1]/p">
  <fo:block font-size="7pt" line-height="9.8pt"
            axf:hyphenate-hyphenated-word="false"
            hyphenation-push-character-count="4"
            hyphenation-remain-character-count="4"
            word-spacing.minimum="-0.01em"
            xsl:use-attribute-sets="p">
      <xsl:apply-templates />
    </fo:block>
</xsl:template>

<xsl:template
    match="div[@type = 'fly_title'][1]"
    priority="5">
  <fo:page-sequence
      master-reference="CoverFrontMaster">
    <fo:flow flow-name="xsl-region-body" hyphenate="true"
             text-align="justify">
      <xsl:apply-templates />
    </fo:flow>
  </fo:page-sequence>
</xsl:template>

<xsl:template
    match="div[@type = 'dedication']">
  <fo:page-sequence
      master-reference="CoverFrontMaster">
    <fo:flow flow-name="xsl-region-body" hyphenate="true"
             text-align="justify">
      <xsl:apply-templates />
    </fo:flow>
  </fo:page-sequence>
</xsl:template>

<!-- Page numbers restart (with format '1') for body. -->
<xsl:template match="body">
  <fo:page-sequence
      master-reference="PageMaster"
      writing-mode="from-page-master-region()"
      initial-page-number="1"
      axf:baseline-grid="root">
    <xsl:call-template name="PageMaster-static-content" />
    <fo:flow flow-name="xsl-region-body" hyphenate="true"
             text-align="justify">
      <xsl:apply-templates />
    </fo:flow>
  </fo:page-sequence>
</xsl:template>

<!-- The TEI XML has another copy of the title that is not in the
     printed first edition. -->
<xsl:template match="div[@type = 'book']/head" />

<xsl:template
    match="div[@type = 'chapter'][exists(head[@type = 'sub'] | fw[@type = 'head'])]">
  <xsl:if test="exists(preceding-sibling::div[@type = current()/@type])">
    <fo:block axf:suppress-if-first-on-page="true" text-align="center"
              padding-top="0.125in"
              space-after="0.2in" space-after.precedence="force"
              axf:baseline-grid="none"
              axf:baseline-block-snap="none">
      <fo:external-graphic src="images/separator.svg" />
    </fo:block>
  </xsl:if>
  <fo:block
      id="{@type}-{count(preceding::div[@type = current()/@type]) + 1}">
    <fo:marker marker-class-name="Chapter-Title">
      <xsl:apply-templates
          select="(fw[@type = 'head'], head[@type = 'sub'])[1]/node()"
          mode="marker" />
    </fo:marker>
    <fo:block-container
        axf:baseline-grid="none"
        axf:baseline-block-snap="none"
        keep-together.within-page="always"
        keep-with-next.within-page="always"
        space-before="{if (exists(preceding::div[1][@type = 'chapter']))
                         then '0.5in'
                       else '0.72in'}"
      space-before.conditionality="retain">
      <xsl:apply-templates select="head" />
    </fo:block-container>
    <xsl:apply-templates select="* except head" />
  </fo:block>
</xsl:template>

<xsl:template
    match="div[@type = 'chapter'][exists(head[. = 'EPILOGUE.'])]"
    priority="5">
  <fo:page-sequence
      master-reference="PageMaster"
      id="epilogue">
    <fo:flow flow-name="xsl-region-body" hyphenate="true"
             text-align="justify">
      <fo:marker marker-class-name="Chapter-Title" />
      <xsl:apply-templates />
      <xsl:apply-templates select="following-sibling::closer"
                           mode="epilogue" />
    </fo:flow>
  </fo:page-sequence>
</xsl:template>

<!-- Chapter I, Loomings, has larger chapter-drop. -->
<xsl:template
    match="div[@type = 'chapter']/head">
  <fo:block
      text-align="center"
      word-spacing="0.2em"
      font-size="10pt"
      keep-with-next="always">
    <xsl:if
        test="exists(head[@type = 'sub'] | fw[@type = 'head'])">
        <fo:marker marker-class-name="Chapter-Title">
          <xsl:apply-templates
              select="(fw[@type = 'head'], head[@type = 'sub'])[1]/node()"
              mode="marker" />
        </fo:marker>
    </xsl:if>
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<xsl:template match="fw" />


<xsl:template match="head[@type = 'sub']"
              priority="5">
  <fo:block
      text-align="center"
      word-spacing="0.2em"
      padding-before="0.02in"
      padding-after="0.05in"
      font-variant="all-small-caps"
      keep-with-next="always">
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<!-- ============================================================= -->
<!-- Back                                                          -->
<!-- ============================================================= -->

<!-- Final page sequence, so force page count to multiple of 16. -->
<xsl:template match="back">
  <fo:page-sequence
      master-reference="PageMaster"
      initial-page-number="auto-odd"
      force-page-count="document 16">
    <!-- No headers or footers. -->
    <fo:flow flow-name="xsl-region-body" hyphenate="true"
             text-align="justify">
      <xsl:apply-templates />
    </fo:flow>
  </fo:page-sequence>
</xsl:template>

<xsl:template match="div[@type = 'advertisement']">
  <fo:block-container
      line-height="1em"
      height="100%" keep-together.within-page="always"
      overflow="condense" axf:overflow-condense="font-size"
      text-align-last="left">
    <xsl:apply-templates
        select="head[@type = 'sub'], head[empty(@type)]" />
    <xsl:apply-templates select="p" />
  </fo:block-container>
</xsl:template>

<xsl:template
    match="div[@type = 'advertisement']/head[empty(@type)]"
    priority="15">
  <fo:block
      space-after.precedence="1"
      text-align="center"
      text-align-last="center"
      keep-with-next="always"
      font-family="pinewood">
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<xsl:template
    match="div[@type = 'advertisement']/head"
    priority="10">
  <fo:block
      space-after.precedence="1"
      text-align="center"
      text-align-last="center"
      keep-with-next="always"
      font-family="bosox"
      font-weight="bold">
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<xsl:template
    match="div[@type = 'advertisement']/p[1]">
  <fo:block text-align="center"
      text-align-last="center">
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<xsl:template match="sp">
  <fo:block>
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<xsl:template match="q/p">
  <fo:block widows="3" orphans="3">
    <xsl:apply-templates />
    <xsl:if test="position() = last() and
                  exists(../following-sibling::*[1][self::bibl])">
      <fo:leader leader-pattern="space"/>
      <fo:leader leader-pattern="space" leader-length.optimum="100%"/>
      <fo:inline-container padding-left="2em" padding-right="0.125in"
                           max-width="80%" text-indent="0">
        <fo:block text-align="right">
          <xsl:apply-templates
              select="../following-sibling::*[1]/node()" />
        </fo:block>
      </fo:inline-container>
    </xsl:if>
  </fo:block>
</xsl:template>

<xsl:template
    match="bibl[exists(preceding-sibling::*[1][self::q[p]])]"
    priority="5" />

<xsl:template match="table">
  <fo:table-and-caption text-align="center" space-before="0.11in" font-size="10pt">
    <fo:table text-align="start">
      <fo:table-body>
        <xsl:apply-templates />
      </fo:table-body>
    </fo:table>
  </fo:table-and-caption>
</xsl:template>

<xsl:template match="row">
  <fo:table-row>
    <xsl:apply-templates />
  </fo:table-row>
</xsl:template>

<xsl:template match="cell">
  <fo:table-cell padding="0.25pt">
    <!-- Second column is in italics. -->
    <xsl:if test="position() = 2">
      <xsl:attribute name="font-style" select="'italic'" />
    </xsl:if>
    <!-- BPIL does not apply to right-to-left scripts. -->
    <xsl:if test="exists(foreign[lang('HEB')])">
      <xsl:attribute name="axf:line-break" select="'line'" />
    </xsl:if>
    <fo:block>
      <xsl:apply-templates />
    </fo:block>
  </fo:table-cell>
</xsl:template>

<xsl:template match="p">
  <fo:block xsl:use-attribute-sets="p">
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<!-- In second 'EXTRACTS.'. -->
<xsl:template match="cit">
  <fo:block space-before="0.16in" space-after="0.16in">
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<!-- At start of a chapter. -->
<xsl:template match="epigraph/cit"
              priority="5">
  <fo:block space-before="1em" space-after="1em">
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<xsl:template match="epigraph">
  <fo:block keep-with-next.within-page="always">
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<xsl:template match="bibl">
  <fo:block text-align="right" margin-right="2em"
             hyphenate="false" keep-with-previous.within-page="always">
    <xsl:apply-templates />
  </fo:block>
</xsl:template>


<!-- ============================================================= -->
<!-- COPYRIGHT                                                     -->
<!-- ============================================================= -->

<xsl:template match="div[@type = 'fly_title']/bibl">
  <fo:block text-align="center" hyphenate="false" font-size="5pt"
            line-height="10.5pt"
            space-before="2.33in" space-before.conditionality="retain">
    <!-- Provide structure that is not in the source XML. -->
    <xsl:analyze-string select="ahf:text(edition/text())"
                        regex="HERMAN MELVILLE,">
      <xsl:matching-substring>
        <fo:block>
          <xsl:value-of select="." />
        </fo:block>
      </xsl:matching-substring>
      <xsl:non-matching-substring>
        <fo:block>
          <xsl:value-of select="normalize-space(.)" />
        </fo:block>
      </xsl:non-matching-substring>
    </xsl:analyze-string>
  </fo:block>
</xsl:template>


<!-- ============================================================= -->
<!-- DEDICATION                                                    -->
<!-- ============================================================= -->

<xsl:template match="div[@type = 'dedication']/p">
  <fo:block text-align="center" hyphenate="false" font-size="8pt"
            line-height="10.5pt"
            space-before="1.53in" space-before.conditionality="retain"
            letter-spacing="0.25em" axf:letter-spacing-side="start">
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<xsl:template match="div[@type = 'dedication']/p/lb" />

<xsl:template
    match="div[@type = 'dedication']/p/
             text()[contains(., 'IN TOKEN')]">
  <fo:block font-variant="all-small-caps">
    <xsl:value-of select="normalize-space(.)" />
  </fo:block>
</xsl:template>

<xsl:template
    match="div[@type = 'dedication']/p/
             text()[contains(., 'OF MY ADMIRATION')]">
  <fo:block font-variant="all-small-caps" space-before="0.4in">
    <xsl:analyze-string
        select="normalize-space(.)"
        regex=",">
      <xsl:matching-substring>
        <fo:inline letter-spacing="0">
          <xsl:value-of select="." />
        </fo:inline>
      </xsl:matching-substring>
      <xsl:non-matching-substring>
        <xsl:value-of select="." />
      </xsl:non-matching-substring>
    </xsl:analyze-string>
  </fo:block>
</xsl:template>

<xsl:template
    match="div[@type = 'dedication']/p/
             text()[contains(., 'This Book is Inscribed')]">
  <fo:block font-size="13pt" font-family="'harrowgate'"
            space-before="0.36in" letter-spacing="0.167em">
    <xsl:value-of select="normalize-space(.)" />
  </fo:block>
</xsl:template>

<xsl:template
    match="div[@type = 'dedication']/p/
             text()[normalize-space(.) = 'TO']">
  <fo:block space-before="0.23in" font-variant="all-small-caps">
    <xsl:value-of select="normalize-space(.)" />
  </fo:block>
</xsl:template>

<xsl:template match="div[@type = 'dedication']/p/
                       text()[contains(., 'NATHANIEL HAWTHORNE')]">
  <fo:block space-before="0.23in" font-size="12pt"
            font-stretch="condensed" letter-spacing="0.28em">
    <xsl:analyze-string
        select="."
        regex="\.">
      <xsl:matching-substring>
        <fo:inline letter-spacing="0">
          <xsl:value-of select="." />
        </fo:inline>
      </xsl:matching-substring>
      <xsl:non-matching-substring>
        <xsl:value-of select="." />
      </xsl:non-matching-substring>
    </xsl:analyze-string>
  </fo:block>
</xsl:template>

<xsl:template match="body//q">
  <fo:block text-align="center"
            text-indent="0"
            space-before="0.25lh"
            font-size="7pt"
            line-height="9pt"
            axf:baseline-block-snap="before margin-box"
            axf:baseline-grid="new">
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<xsl:template match="lg">
  <fo:block text-align="center"
            space-before="0.16in"
            text-indent="0">
    <xsl:if test="not(parent::q)">
      <xsl:attribute name="space-after" select="'1em'" />
    </xsl:if>
    <xsl:if test="exists(ancestor::div[@type = 'chapter'])">
      <xsl:attribute name="font-size" select="'7pt'" />
      <xsl:attribute name="line-height" select="'9pt'" />
      <xsl:attribute name="axf:baseline-block-snap"
                     select="'before margin-box'" />
      <xsl:attribute name="axf:baseline-grid" select="'new'" />
      <xsl:attribute name="space-before" select="'0'" />
      <xsl:attribute name="space-after" select="'0'" />
    </xsl:if>
    <fo:inline-container
        axf:hanging-punctuation="start allow-end">
      <fo:block text-align="start">
        <xsl:apply-templates />
      </fo:block>
    </fo:inline-container>
  </fo:block>
</xsl:template>

<xsl:template match="l">
  <fo:block>
    <xsl:if test="@rend = 'ti-1'">
      <xsl:attribute name="text-indent" select="'2em'" />
    </xsl:if>
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<!-- <closer> is processed as part of the epilogue 'chapter'. -->
<xsl:template match="closer" />
<xsl:template match="closer" mode="epilogue">
  <fo:block text-align="center">
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<xsl:template match="speaker">
  <fo:block text-align="center" font-variant="all-small-caps lining-nums"
            keep-with-next.within-page="always"
            space-before="0.5lh">
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<xsl:template match="stage">
  <fo:block
      text-align="center" font-style="italic"
      keep-with-next.within-page="always">
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<xsl:template match="p/stage">
  <fo:inline font-style="italic">
    <xsl:apply-templates />
  </fo:inline>
</xsl:template>

<xsl:template match="abbr | emph | hi[@rend eq 'i'] | title">
  <fo:inline font-style="italic">
    <xsl:apply-templates />
  </fo:inline>
</xsl:template>

<xsl:template
    match="hi[@rend eq 'all-small-caps']">
  <fo:inline font-variant="all-small-caps">
    <xsl:apply-templates />
  </fo:inline>
</xsl:template>

<xsl:template
    match="hi[@rend eq 'small-caps']">
  <fo:inline font-variant="small-caps">
    <xsl:apply-templates />
  </fo:inline>
</xsl:template>

<!-- The foreign words in the table in 'Etymology' are not in
     italics. -->
<xsl:template match="foreign[empty(ancestor::table)]">
  <fo:inline font-style="italic">
    <xsl:apply-templates />
  </fo:inline>
</xsl:template>

<xsl:template match="list/item">
  <fo:block
      text-align="center" font-style="italic">
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<xsl:template match="lb">
  <fo:block />
</xsl:template>

<xsl:template match="pb[@xml:id]">
  <fo:wrapper xml:id="{@xml:id}" />
</xsl:template>

<xsl:template match="milestone[@unit = 'typography']">
  <fo:block text-align="center" white-space-collapse="false">
    <xsl:value-of select="@n" />
  </fo:block>
</xsl:template>

<xsl:template match="note[@place = 'foot']" />

<xsl:template match="ref[exists(key('footnote',
                                    substring-after(@target, '#')))]"
              priority="5">
  <fo:footnote
      id="{@xml:id}"
      axf:suppress-duplicate-footnote="true">
    <fo:inline>
      <fo:basic-link
          internal-destination="{substring-after(@target, '#')}">
        <xsl:value-of select="." />
      </fo:basic-link>
    </fo:inline>
    <fo:footnote-body
        id="{substring-after(@target, '#')}"
        font-size="7pt"
        line-height="10pt">
      <xsl:apply-templates
          select="key('footnote',
                      substring-after(@target, '#'))/node()" />
    </fo:footnote-body>
  </fo:footnote>
</xsl:template>

<xsl:template match="ref[@rend = 'super']">
  <xsl:value-of select="." />
  <xsl:value-of select="substring-after(@target, '#')" />
  <xsl:copy-of
      select="key('footnote', 'note_001')" />
</xsl:template>

<xsl:template match="note/p/ref">
  <fo:basic-link
      internal-destination="{substring-after(@target, '#')}"
      padding-end="0.5em">
    <xsl:value-of select="." />
  </fo:basic-link>
</xsl:template>

<!-- Drop identified typos and leave corrections from <corr>. -->
<xsl:template match="sic" />

<!-- Convert single and double quotes to 'curly' quotes. -->
<xsl:template match="text()" name="ahf:text">
  <xsl:param name="text" select="." as="text()" />

  <xsl:value-of select="ahf:text($text)" />
</xsl:template>

<xsl:function name="ahf:text" as="xs:string">
  <xsl:param name="text" as="text()" />

  <!-- The replacement that depends on the current node must be
       first. -->
  <xsl:variable
      name="text"
      select="if (matches($text, '&quot;$') and
                  empty($text/following-sibling::node()))
                then replace($text, '&quot;$', '&rdquo;')
              else $text"
      as="xs:string" />
  <!-- Moby-Dick uses broken English for speech from non-native
       speakers of English.  The speech can include words with the
       dropped initial vowel indicated by a right single-quote.
       Handle those before replacing any &apos; with left
       single-quotes. -->
  <xsl:variable
      name="text"
      select="replace($text, '''(s?t?(&quot;|\s|[.,;:]|(balmed|dention|em|gainst|ll|mong|parm|quid|specially|spose|stead|teak|till|[Tt]is|[Tt]was)(,|\.|\s)|$))', '&rsquo;$1')"
      as="xs:string" />
  <xsl:variable
      name="text"
      select="replace($text, '(^|\s|&quot;|—)''([^&quot;]|$)', '$1&lsquo;$2')"
      as="xs:string" />
  <xsl:variable
      name="text"
      select="replace($text, '(^|—|\s)&quot;', '$1&ldquo;')"
      as="xs:string" />
  <xsl:variable
      name="text"
      select="replace($text, '&quot;(\s|[—.,;:]|$)', '&rdquo;$1')"
      as="xs:string" />
  <xsl:variable
      name="text"
      select="replace($text, '([^\s])''([^\s])', '$1&rsquo;$2')"
      as="xs:string" />

  <!-- Variations on '* * *' in 'Extracts'. -->
  <xsl:variable
      name="text"
      select="replace($text, ' \*', '&#xA0;&#xA0;*')"
      as="xs:string" />
  <xsl:variable
      name="text"
      select="replace($text, '\* ', '*&#xA0;&#xA0;')"
      as="xs:string" />

  <xsl:sequence select="$text" />
</xsl:function>

<xsl:template match="figure">
  <fo:external-graphic src="images/mark.jpg"
                       alignment-baseline="middle" />
</xsl:template>

</xsl:stylesheet>
