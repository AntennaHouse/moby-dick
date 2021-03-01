<?xml version='1.0' encoding='UTF-8'?>
<!DOCTYPE xsl:stylesheet [
<!ENTITY lsquo  '&#x2018;' >
<!ENTITY rsquo  '&#x2019;' >
<!ENTITY ldquo  '&#x201C;' >
<!ENTITY rdquo  '&#x201D;' >
<!ENTITY mdash  '&#x2014;' >
<!ENTITY mdash2 '&#x2E3A;' >
<!ENTITY mdash3 '&#x2E3B;' >
<!ENTITY nbsp   '&#xA0;'   >
<!ENTITY ndash  '&#x2013;' >
<!ENTITY times  '&#xD7;'   >
<!ENTITY zwj    '&#x2060;' >
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

<xsl:import href="white-space.xsl"/>


<!-- ============================================================= -->
<!-- ATTRIBUTE SETS                                                -->
<!-- ============================================================= -->


<!-- ============================================================= -->
<!-- TEMPLATES                                                     -->
<!-- ============================================================= -->

<!-- Page numbers are from the First Edition. -->

<!-- 'Though I cannot tell why...' (pg. 7) -->
<xsl:template
    match="/TEI/text[1]/body[1]/div[1]/div[1]/p[12]/text()">
  <xsl:analyze-string
      select="ahf:text(.)"
      regex="why this">
    <xsl:matching-substring>why&nbsp;this</xsl:matching-substring>
    <xsl:non-matching-substring>
      <xsl:value-of select="." />
    </xsl:non-matching-substring>
  </xsl:analyze-string>
</xsl:template>

<!-- 'Crossing this dusky entry...' (pg. 13) -->
<xsl:template
    match="/TEI/text[1]/body[1]/div[1]/div[3]/p[5]/text()">
  <xsl:analyze-string
      select="ahf:text(.)"
      regex="dark looking">
    <xsl:matching-substring>dark&nbsp;looking</xsl:matching-substring>
    <xsl:non-matching-substring>
      <xsl:value-of select="." />
    </xsl:non-matching-substring>
  </xsl:analyze-string>
</xsl:template>

<!-- 'I observed, however...' (pg. 16) -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[3]/p[22]/text()">
  <xsl:value-of
      select="replace(replace(ahf:text(.),
                              'stood full', 'stood&nbsp;full'),
                      'a coffer-dam', 'a&nbsp;coffer-dam')" />
</xsl:template>

<!-- 'Folding back the counterpane...' (pg. 21) -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[3]/p[51]/text()">
  <xsl:value-of
      select="replace(ahf:text(.), 'besides the', 'besides&nbsp;the')" />
</xsl:template>

<!-- 'Lord save me...' (pg. 23) -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[3]/p[55]/text()">
  <xsl:value-of
      select="replace(replace(ahf:text(.), 'at all', 'at&nbsp;all'),
                      'of skin.', 'of&nbsp;skin.')" />
</xsl:template>

<!-- 'But the interval...' (pg. 26) -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[3]/p[61]/text()">
  <xsl:value-of
      select="replace(ahf:text(.), 'of tobacco', 'of&nbsp;tobacco')" />
</xsl:template>

<!-- 'I lay there dismally...' (pg. 29) -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[4]/p[3]/text()">
  <xsl:value-of
      select="replace(ahf:text(.), 'And it', 'And&nbsp;it')" />
</xsl:template>

<!-- 'Seeing, now...' (pg. 31) -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[4]/p[6]/text()">
  <xsl:value-of
      select="replace(ahf:text(.), 'was watching', 'was&nbsp;watching')" />
</xsl:template>

<!-- 'Shaking off the sleet...' (pg. 39) -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[7]/p[3]/text()">
  <xsl:value-of
      select="replace(ahf:text(.), 'of the scene', 'of&nbsp;the scene')" />
</xsl:template>

<!-- 'The perpendicular parts of this side ladder...' (pg. 42) -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[8]/p[3]/text()">
  <xsl:value-of
      select="replace(ahf:text(.), 'a joint', 'a&nbsp;joint')" />
</xsl:template>

<!-- '"With this sin of disobedience in him...' (pg. 46) -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[9]/p[7]/text()">
  <xsl:value-of
      select="replace(ahf:text(.), 'sailors for', 'sailors&nbsp;for')" />
</xsl:template>

<!-- '"And now the time of tide has come...' (pg. 49) -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[9]/p[12]/text()">
  <xsl:value-of
      select="replace(ahf:text(.), 'A dreadful', 'A&nbsp;dreadful')" />
</xsl:template>

<!-- 'It was quite late in the evening...' (pg. 71) -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[15]/p[1]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.0075em'" />
      <xsl:attribute name="word-spacing.minimum" select="'-0.0075em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Fishiest of all fishy places...' (pg. 74) -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[15]/p[14]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.0075em'" />
      <xsl:attribute name="word-spacing.minimum" select="'-0.0075em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'So that there are instances...' (pg. 82) -->
<xsl:template
    match="/TEI/text[1]/body[1]/div[1]/div[16]/p[43]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.0075em'" />
      <xsl:attribute name="word-spacing.minimum" select="'-0.0075em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'As I walked away...' (pg. 90) -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[16]/p[82]/text()">
  <xsl:value-of
      select="replace(ahf:text(.), 'loss of', 'loss&nbsp;of')" />
</xsl:template>

<!-- 'And just so I now did...' (pg. 96) -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[17]/p[26]/text()">
  <xsl:value-of select="ahf:no-break(., 'primitive religions')" />
</xsl:template>

<!-- '"That's true, that's true...' (pg. 103) -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[19]/p[23]/text()">
  <xsl:value-of select="ahf:no-break(., 'when he')" />
</xsl:template>

<!-- 'Why did the Dutch...' (pg. 120) -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[24]/p[6]">
  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.01em'" />
      <xsl:attribute name="word-spacing.minimum" select="'-0.01em'" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Concerning all this...' (pg. 172) -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[35]/p[6]/text()">
  <xsl:value-of select="ahf:no-break(., 'well, Captain')" />
</xsl:template>

<!-- 'Jollies?...' (pg. 195) -->
<xsl:template
    match="/TEI/text[1]/body[1]/div[1]/div[40]/sp[45]/p[1]">
  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.0075em'" />
      <xsl:attribute name="word-spacing.minimum" select="'-0.0075em'" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Judge, then...' (pg. 202) -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[41]/p[18]/text()">
  <xsl:value-of select="ahf:no-break(., 'of torn')" />
</xsl:template>

<!-- 'Suddenly bubbles...' (pg. 316) -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[61]/p[6]/text()">
  <xsl:value-of select="ahf:no-break(., 'in the trough')" />
</xsl:template>

<!-- 'In the first place...' (pg. 338) -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[67]/p[2]/text()">
  <xsl:value-of select="ahf:no-break(., 'windlass, and')" />
</xsl:template>

<!-- 'He had been originally nurtured...' (pg. 349) -->
<xsl:template
    match="/TEI/text[1]/body[1]/div[1]/div[71]/p[8]">
  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.0002em'" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Nevertheless, it may well be believed...' (pg. 357) -->
<xsl:template
    match="/TEI/text[1]/body[1]/div[1]/div[72]/p[7]">
  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'-0.02em'" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Now, during the past night...' (pg. 360) -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[73]/p[2]/text()">
  <xsl:value-of select="ahf:no-break(., 'to be')" />
</xsl:template>

<!-- 'But why pester...' (pg. 414) -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[85]/p[8]/text()">
  <xsl:value-of select="ahf:no-break(., 'this world')" />
</xsl:template>

<!-- 'As if too long...' (pg. 426) -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[87]/p[13]/text()">
  <xsl:analyze-string
      select="ahf:text(.)"
      regex="philanthropists">
    <xsl:matching-substring>
      <fo:wrapper hyphenate="false">
        <xsl:value-of select="." />
      </fo:wrapper>
    </xsl:matching-substring>
    <xsl:non-matching-substring>
      <xsl:value-of select="." />
    </xsl:non-matching-substring>
  </xsl:analyze-string>
</xsl:template>

<!-- 'Stripped to our shirts and drawers...' (pg. 427) -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[87]/p[15]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'-0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Meanwhile, as we thus lay entranced...' (pg. 433) -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[87]/p[28]/text()">
  <xsl:value-of select="ahf:no-break(., 'as it were')" />
</xsl:template>

<!-- 'The schools composing...' (pg. 439) -->
<xsl:template
    match="/TEI/text[1]/body[1]/div[1]/div[88]/p[9]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'-0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- '"Aye, blacksmith, it is the one...' (pg. 541) -->
<xsl:template
    match="/TEI/text[1]/body[1]/div[1]/div[113]/p[12]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'-0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Deliberately standing...' (pg. 571) -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[124]/p[12]/text()">
  <xsl:value-of select="ahf:no-break(., 'out his')" />
</xsl:template>

<!-- 'Caught and twisted...' (pg. 616) -->
<xsl:template
    match="/TEI/text[1]/body[1]/div[1]/div[134]/p[21]">
  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'-0.01em'" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>


<!-- ============================================================= -->
<!-- FUNCTIONS                                                     -->
<!-- ============================================================= -->

<xsl:function name="ahf:no-break" as="xs:string">
  <xsl:param name="text" as="text()" />
  <xsl:param name="substrings" as="xs:string+" />
  
  <xsl:variable name="string"
                select="normalize-space(ahf:text($text))"
                as="xs:string" />

  <!-- <pb> between words could that mean space before or after <pb>
       was normalized away. -->
  <xsl:variable name="string"
                select="if (matches($text, '^\s'))
                          then concat(' ', $string)
                        else $string"
                as="xs:string" />
  <xsl:variable name="string"
                select="if (matches($text, '\s$'))
                          then concat($string, ' ')
                        else $string"
                as="xs:string" />

  <xsl:sequence select="ahf:no-break-sub($string, $substrings)" />
</xsl:function>

<xsl:function name="ahf:no-break-sub" as="xs:string">
  <xsl:param name="string" as="xs:string" />
  <xsl:param name="substrings" as="xs:string+" />

  <xsl:variable
      name="substring"
      select="replace($substrings[1], '(\?)', '\\\\\\\\$1')"
      as="xs:string" />
  
  <xsl:variable name="replace-string"
      select="replace(replace(replace($substring, ' ', '&nbsp;'),
                              '([&mdash;&mdash2;&mdash3;])(\S)',
                              '$1&zwj;$2'),
                      '(\S)([&mdash;&mdash2;&mdash3;])',
                      '$1&zwj;$2')"
      as="xs:string" />

  <xsl:variable name="string"
      select="replace($string,
                      $substring,
                      $replace-string)"
      as="xs:string" />

  <xsl:choose>
    <xsl:when test="count($substrings) = 1">
      <xsl:sequence select="$string" />
    </xsl:when>
    <xsl:otherwise>
      <xsl:sequence
          select="ahf:no-break-sub($string,
                                   $substrings[position() > 1])" />
    </xsl:otherwise>
  </xsl:choose>
</xsl:function>

<xsl:function name="ahf:no-hyphen" as="item()+">
  <xsl:param name="text" as="text()" />
  <xsl:param name="substrings" as="xs:string+" />
  
  <xsl:variable name="string"
                select="normalize-space(ahf:text($text))"
                as="xs:string" />

  <!-- <pb> between words could that mean space before or after <pb>
       was normalized away. -->
  <xsl:variable name="string"
                select="if (matches($text, '^\s'))
                          then concat(' ', $string)
                        else $string"
                as="xs:string" />
  <xsl:variable name="string"
                select="if (matches($text, '\s$'))
                          then concat($string, ' ')
                        else $string"
                as="xs:string" />

  <xsl:sequence select="ahf:no-hyphen-sub($string, $substrings)" />
</xsl:function>

<xsl:function name="ahf:no-hyphen-sub" as="item()+">
  <xsl:param name="string" as="xs:string" />
  <xsl:param name="substrings" as="xs:string+" />
  
  <xsl:variable name="replace-string" as="item()+">
    <xsl:analyze-string
        select="$string"
        regex="{$substrings[1]}">
      <xsl:matching-substring>
        <fo:inline keep-together.within-line="always">
          <xsl:value-of select="." />
        </fo:inline>
      </xsl:matching-substring>
      <xsl:non-matching-substring>
        <xsl:value-of select="." />
      </xsl:non-matching-substring>
    </xsl:analyze-string>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="count($substrings) = 1">
      <xsl:sequence select="$replace-string" />
    </xsl:when>
    <xsl:otherwise>
      <xsl:for-each select="$replace-string">
        <xsl:choose>
          <xsl:when test="self::*">
            <xsl:sequence select="." />
          </xsl:when>
          <xsl:otherwise>
            <xsl:sequence
                select="ahf:no-hyphen-sub(.,
                                          $substrings[position() > 1])" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
    </xsl:otherwise>
  </xsl:choose>
</xsl:function>

</xsl:stylesheet>
