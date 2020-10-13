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

<!-- 'Moby-Dick' first edition. -->
<!-- http://webapp1.dlib.indiana.edu/TEIgeneral/view?docId=wright/VAC7237.xml -->

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
    name="lang"
    select="'en'"
    as="xs:string" />

<xsl:param
    name="line-height"
    select="'11pt'"
    as="xs:string" />

<xsl:param
    name="font-family-default"
    select="'source-serif-pro, Century, ''Times New Roman'', serif'"
    as="xs:string" />

<xsl:param
    name="font-family-monospace"
    select="'TiredOfCourier, Courier, Courier New, opensymbol, symbol, ZapfDingbats, Lucida Sans Unicode'"
    as="xs:string" />


<!-- ============================================================= -->
<!-- TEMPLATES                                                     -->
<!-- ============================================================= -->

<xsl:template match="TEI">
  <fo:root font-size="{$font-size}"
           font-family="{$font-family-default}"
           font-selection-strategy="character-by-character"
           line-height="{$line-height}"
           xml:lang="en">
    <xsl:call-template
        name="layout-master-set" />
    <xsl:call-template name="declarations" />
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

<!-- 'MOBY-DICK; OR, THE WHALE' have different markup on the title
     page and the second fly title but have the same formatting.
     Ignore the <titlePart> markup, which doesn't accurately describe
     the text anyway, and process the text. -->
<xsl:template match="docTitle | div[@type = 'fly_title']/head"
              priority="5">
  <fo:block
      font-size="20pt"
      letter-spacing="0.33em"
      line-height="40pt"
      text-align="center"
      font-stretch="condensed">
    <xsl:analyze-string
        select="normalize-space(.)"
        regex="OR,">
      <xsl:matching-substring>
        <fo:block
            font-size="8pt" font-variant="all-small-caps"
            letter-spacing="0">
          <xsl:value-of select="." />
        </fo:block>
      </xsl:matching-substring>
      <xsl:non-matching-substring>
        <xsl:analyze-string
            select="."
            regex="\.|;">
          <xsl:matching-substring>
            <fo:inline letter-spacing="0">
              <xsl:value-of select="." />
            </fo:inline>
          </xsl:matching-substring>
          <xsl:non-matching-substring>
            <xsl:value-of select="." />
          </xsl:non-matching-substring>
        </xsl:analyze-string>
      </xsl:non-matching-substring>
    </xsl:analyze-string>
  </fo:block>
</xsl:template>

<xsl:attribute-set name="p">
  <xsl:attribute name="text-indent" select="'1em'" />
</xsl:attribute-set>

<xsl:template match="axf:hyphenation-info"
              mode="axf:hyphenation-info">
  <xsl:copy-of select="." />
</xsl:template>

<xsl:template name="declarations">
  <fo:declarations>
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
    <!--
    <axf:formatter-config xmlns:axs="http://www.antennahouse.com/names/XSL/Settings">
      <axs:formatter-settings bpil-penalty-hyphenation="1" bpil-highlight="#FF8" />
    </axf:formatter-config>
    -->
  </fo:declarations>
</xsl:template>

<xsl:template
    match="titlePage |
           div[@type = ('contents', 'intro_text')]">
  <fo:page-sequence
      master-reference="CoverFrontMaster"
      initial-page-number="{if (@type = 'contents')
                              then 'auto-odd'
                              else 'auto'}">
    <fo:flow flow-name="xsl-region-body" hyphenate="true"
             text-align="justify">
      <xsl:apply-templates />
    </fo:flow>
  </fo:page-sequence>
</xsl:template>

<xsl:template
    match="div[@type = ('fly_title', 'dedication')]">
  <fo:page-sequence
      master-reference="CoverFrontMaster">
    <fo:flow flow-name="xsl-region-body" hyphenate="true"
             text-align="justify">
      <fo:block-container display-align="center"
                          height="80%">
        <xsl:apply-templates />
      </fo:block-container>
    </fo:flow>
  </fo:page-sequence>
</xsl:template>

<xsl:template
    match="body | back">
  <fo:page-sequence
      master-reference="PageMaster"
      writing-mode="from-page-master-region()"
      initial-page-number="{if (self::front or self::body)
                              then 1
                              else 'auto-odd'}"
      force-page-count="{if (self::back)
                           then 'document 16'
                         else 'auto'}">
    <xsl:call-template name="PageMaster-static-content" />
    <fo:flow flow-name="xsl-region-body" hyphenate="true"
             text-align="justify">
      <xsl:apply-templates />
    </fo:flow>
  </fo:page-sequence>
</xsl:template>

<xsl:template match="div[@type = 'book']/head" />

<xsl:template
    match="docAuthor | pubPlace[1] | publisher[1]">
  <fo:block>
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<xsl:template
    match="byline | docDate | docImprint">
  <fo:block text-align="center" hyphenate="false">
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<xsl:template
    match="div[@type = 'chapter'][exists(head[@type = 'sub'] | fw[@type = 'head'])]">
  <fo:block
      id="{@type}-{count(preceding::div[@type = current()/@type]) + 1}">
    <fo:marker marker-class-name="Chapter-Title">
      <xsl:apply-templates
          select="(fw[@type = 'head'], head[@type = 'sub'])[1]/node()"
          mode="marker" />
    </fo:marker>
    <xsl:apply-templates />
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

<xsl:template
    match="div[@type = ('fly_title', 'intro_text', 'chapter')]/head">
  <fo:block
      padding-before="0.75in"
      space-after.precedence="1"
      text-align="center"
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
    match="div[@type = 'contents']/head">
  <fo:block
      padding-before="0.3in"
      padding-after="0.3in"
      space-after.precedence="1"
      text-align="center"
      keep-with-next="always">
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<xsl:template match="head[@type = 'sub']"
              priority="5">
  <fo:block
      text-align="center"
      padding-before="1em"
      padding-after="1em"
      font-variant="all-small-caps"
      keep-with-next="always">
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<xsl:template match="fw" />

<xsl:template match="div[@type = 'contents']/list">
  <fo:block-container
      column-count="2" column-gap="5pt"
      axf:column-rule-width="thin"
      axf:column-rule-style="solid"
      axf:column-rule-color="black"
      axf:column-rule-display="all"
      axf:column-rule-align="before"
      font-size="7pt" line-height="7.75pt">
    <fo:table>
      <fo:table-column text-align="—" />
      <fo:table-header>
        <fo:table-row font-size="6pt" font-style="italic">
          <fo:table-cell
              text-align="center">
            <fo:block>Chap.</fo:block>
          </fo:table-cell>
          <fo:table-cell>
            <fo:block>&#xA0;</fo:block>
          </fo:table-cell>
          <fo:table-cell>
            <fo:block>&#xA0;</fo:block>
          </fo:table-cell>
          <fo:table-cell
              text-align="center">
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
        font-variant="all-small-caps">
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
                  select="replace(normalize-space(substring-after(text(), '—')),
                          '\.$', '')" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="." />
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
        display-align="after">
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
<!-- Advertisement                                                 -->
<!-- ============================================================= -->

<xsl:template match="div[@type = 'advertisement']">
  <fo:block-container
      break-before="page"
      line-height="1em"
      height="100%" keep-together.within-page="always"
      overflow="condense" axf:overflow-condense="font-size"
      text-align-last="left">
    <xsl:apply-templates />
  </fo:block-container>
</xsl:template>

<xsl:template
    match="div[@type = 'advertisement']/head">
  <fo:block
      space-after.precedence="1"
      text-align="center"
      keep-with-next="always">
    <xsl:apply-templates />
  </fo:block>
</xsl:template>


<xsl:template match="sp">
  <fo:block>
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<xsl:template match="body//q">
  <fo:block text-align="center"
            space-before="1em"
            space-after="1em">
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<xsl:template match="q/p">
  <fo:block>
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<xsl:template match="p">
  <fo:block xsl:use-attribute-sets="p">
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<xsl:template match="cit">
  <fo:block space-before="1em" space-after="1em">
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<xsl:template match="epigraph">
  <fo:block>
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<xsl:template match="bibl">
  <fo:block text-align="right" margin-right="2em"
             hyphenate="false" keep-with-previous.within-page="always">
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<xsl:template match="lg">
  <fo:block text-align="center"
            space-before="1em">
    <xsl:if test="not(parent::q)">
      <xsl:attribute name="space-after" select="'1em'" />
    </xsl:if>
    <fo:inline-container
        axf:hanging-punctuation="start allow-end">
      <xsl:if test="exists(ancestor::div[@type = 'chapter'])">
        <xsl:attribute name="font-size" select="'0.8em'" />
      </xsl:if>
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
  <fo:block space-before="1em" space-after="1em"
            text-align="center" font-variant="all-small-caps"
            keep-with-next.within-page="always">
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

<!-- Drop identified typos and leave corections from <corr>. -->
<xsl:template match="sic" />

<!-- Convert single and double quotes to 'curly' quotes.
     Exception for "'balmed" and "'em" in "The Spouter-Inn". -->
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
  <xsl:variable
      name="text"
      select="replace($text, '''(s?t?(&quot;|\s|[.,;:]|balmed\s|em\s|$))', '&rsquo;$1')"
      as="xs:string" />
  <xsl:variable
      name="text"
      select="replace($text, '(^|\s|&quot;)''', '$1&lsquo;')"
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

<xsl:template match="table">
  <fo:table-and-caption text-align="center">
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
  <fo:table-cell>
    <xsl:if test="empty(foreign)">
      <xsl:attribute name="font-style" select="'italic'" />
    </xsl:if>
    <!-- BPIL does not work for right-to-left scripts. -->
    <xsl:if test="exists(foreign[lang('HEB')])">
      <xsl:attribute name="axf:line-break" select="'line'" />
    </xsl:if>
    <fo:block>
      <xsl:apply-templates />
    </fo:block>
  </fo:table-cell>
</xsl:template>

</xsl:stylesheet>
