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
<!-- For processing TEI-encoded 'Moby-Dick' first edition from
     http://purl.dlib.indiana.edu/iudl/wright/VAC7237
-->

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

<xsl:import href="lines.xsl"/>


<!-- ============================================================= -->
<!-- STYLESHEET PARAMETERS                                         -->
<!-- ============================================================= -->


<!-- ============================================================= -->
<!-- ATTRIBUTE SETS                                                -->
<!-- ============================================================= -->


<!-- ============================================================= -->
<!-- TEMPLATES                                                     -->
<!-- ============================================================= -->

<!-- Page numbers are from the First Edition. -->

<!-- 'With halting steps...' (pg. 8) -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[2]/p[4]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.005em'" />
      <xsl:attribute name="word-spacing.minimum" select="'-0.005em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'With halting steps...' (pg. 8) -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[2]/p[4]/text()">
  <xsl:value-of select="ahf:no-break(., 'cheeriest inns.')" />
</xsl:template>

<!-- 'It was a queeer sort of place...' (pg. 10) -->
<!-- Make a line on pg. 10 to push a line to pg. 11. -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[2]/p[9]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.0075em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.0075em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Upon entering the place...' (pg. 14) -->
<!-- Make a line on formatted pg. 14 to add a line on pg. 16. -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[3]/p[7]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.001em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.0025em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Now, take away the awful fear...' (pg. 30) -->
<!-- Lose a line so pg. 35 will lose three lines. -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[4]/p[4]/text()">
  <xsl:value-of
      select="ahf:no-break(., ('truth is', 'unusual regarding'))" />
</xsl:template>

<!-- 'He commenced dressing...' (pg. 31) -->
<!-- Lose a line so pg. 35 will lose three lines. -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[4]/p[5]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.01em'" />
      <xsl:attribute name="word-spacing.minimum" select="'-0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Seeing, now...' (pg. 31) -->
<!-- Lose a line so pg. 35 will lose three lines.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[4]/p[6]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.01em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Seeing, now...' (pg. 31) -->
<!-- Undo previous river fix to help lose a line. -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[4]/p[6]/text()">
  <xsl:value-of select="ahf:text(.)" />
</xsl:template>

<!-- 'But, besides...' (pg. 35) -->
<!-- Gain a line so pg. 36 will fill text block.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[6]/p[3]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- '"'I am a Hebrew,'...' (pg. 50) -->
<!-- Gain a line so pg. 51 will fill the text block. -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[9]/p[14]/text()">
  <xsl:value-of
      select="ahf:no-break(., ('indignant gale'))" />
</xsl:template>

<!-- 'Returning to the Spouter-Inn...' (pg. 54) -->
<!-- Avoid a paragraph widow.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[10]/p[1]/text()">
  <xsl:sequence
      select="ahf:no-break(., 'heathenish way.')" />
</xsl:template>

<!-- 'A Sag Harbor ship...' (pg. 61) -->
<!-- Lose a line so pg. 66 will fill text block.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[12]/p[3]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.005em'" />
      <xsl:attribute name="word-spacing.minimum" select="'-0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'I thought him...' (pg. 84) -->
<!-- Override 'line-start-end.xsl' override to gain a line so pg. 85
     fills its text block. -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[16]/p[54]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.0075em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.015em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Lay, indeed, thought I...' (pg. 86) -->
<!-- Gain a line so pg. 86 will fill text block.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[16]/p[59]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'0.01em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Alarmed at this...' (pg. 87) -->
<!-- Gain a line so pg. 87 will fill text block.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[16]/p[68]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.0075em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.015em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Alarmed at this...' (pg. 87) -->
<!-- Gain a line so pg. 87 will fill text block.  -->
<!-- 'the door' avoids adding a river. -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[16]/p[68]/text()">
  <xsl:value-of
      select="ahf:no-break(., ('the door', 'Well then, down'))" />
</xsl:template>

<!-- '"Come hither to me...' (pg. 89) -->
<!-- Gain a line to help three lines turn over on pg. 90.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[16]/p[81]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.01em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'As I walked away...' (pg. 90) -->
<!-- Gain a line to help three lines turn over on pg. 90.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[16]/p[82]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'As Queequeg's Ramadan...' (pg. 91) -->
<!-- Gain a line to help three lines turn over on pg. 90.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[17]/p[1]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.005em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- '"I won't allow it...' (pg. 93) -->
<!-- Lose a line to pull two lines back to pg. 93.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[17]/p[12]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.015em'" />
      <xsl:attribute name="word-spacing.minimum" select="'-0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Finding myself thus...' (pg. 99) -->
<!-- Gain a line to make pg. 98 fill its text block.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[18]/p[12]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'With finger pointed...' (pg. 104) -->
<!-- Lose a line to make pg. 103 fill its text block.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[19]/p[27]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.0095em'" />
      <xsl:attribute name="word-spacing.minimum" select="'-0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Look here, friend...' (pg. 104) -->
<!-- Gain a line to make pg. 104 move two lines.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[19]/p[28]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.01em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Elijah! thought I...' (pg. 105) -->
<!-- Gain a line to make pg. 104 move two lines.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[19]/p[34]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.02em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'A day or two passed...' (pg. 106) -->
<!-- Gain a line to make pg. 105 move three lines.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[20]/p[1]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.02em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'But it was startling...' (pg. 107) -->
<!-- Gain a line to make pg. 107 gain two lines.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[20]/p[6]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'0.015em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'During these days...' (pg. 108) -->
<!-- Gain a line to make pg. 107 gain two lines.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[20]/p[7]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.01em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'During these days...' (pg. 108) -->
<!-- Gain a line to make pg. 107 gain two lines.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[20]/p[7]/text()">
  <xsl:analyze-string
      select="ahf:text(.)"
      regex="cover up">
    <xsl:matching-substring>
      <fo:inline keep-together.within-line="always">
        <xsl:value-of select="." />
      </fo:inline>
    </xsl:matching-substring>
    <xsl:non-matching-substring>
      <xsl:analyze-string
          select="."
          regex="nothing\.">
        <xsl:matching-substring>
          <fo:wrapper hyphenate="false">
            <xsl:value-of select="." />
          </fo:wrapper>
        </xsl:matching-substring>
        <xsl:non-matching-substring>
          <xsl:value-of select="." />
        </xsl:non-matching-substring>
      </xsl:analyze-string>
    </xsl:non-matching-substring>
  </xsl:analyze-string>
</xsl:template>

<!-- '"Yes, we are...' (pg. 109) -->
<!-- Gain a line to make pg. 108 fill its text block.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[21]/p[8]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.01em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Meantime, overseeing...' (pg. 114) -->
<!-- Gain a line to make pg. 113 fill its text block.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[22]/p[10]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.018em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'At last, the anchor...' (pg. 114) -->
<!-- Gain a line to make pg. 114 fill its text block.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[22]/p[12]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.0075em'" />
      <xsl:attribute name="word-spacing.minimum" select="'-0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'So, almost every twenty-four...' (pg. 138) -->
<!-- Gain a line to make pg. 138 fill its text block.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[29]/p[3]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'0.018em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- '"I was never served so...' (pg. 139) -->
<!-- Gain a line to make pg. 140 fill its text block.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[29]/p[10]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'0.01em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- '"I was never served so...' (pg. 139) -->
<!-- Avoid a new river.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[29]/p[10]/text()">
  <xsl:value-of
      select="ahf:no-break(., ('when it'))" />
</xsl:template>

<!-- '"Such a queer dream...' (pg. 142) -->
<!-- Gain a line to make pg. 143 fill its text block.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[31]/p[2]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'0.015em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Already we are boldly...' (pg. 144) -->
<!-- Gain a line to make pg. 147 fill its text block.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[32]/p[1]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'BOOK III...Huzza Porpoise...' (pg. 157) -->
<!-- Gain a line to make pg. 161 fill its text block.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[32]/p[40]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'-0.01em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'BOOK III...Huzza Porpoise...' (pg. 157) -->
<!-- Gain a line to make pg. 161 fill its text block.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[32]/p[40]/text()">
  <xsl:analyze-string
      select="ahf:text(.)"
      regex="miniature\.">
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

<!-- 'The large importance...' (pg. 160) -->
<!-- Lose a line to pull two lines to pg. 162.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[33]/p[2]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'-0.01em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Nor, perhaps...' (pg. 161) -->
<!-- Avoid new white-space error.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[33]/p[6]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.01em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'When the last echo...' (pg. 163) -->
<!-- Avoid new white-space error.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[34]/p[2]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.02em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'It was a sight...' (pg. 167) -->
<!-- Gain a line to make pg. 167 fill its text block.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[34]/p[9]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.005em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.01em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'When the entire...' (pg. 177) -->
<!-- Gain a line to make pg. 177 fill its text block.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[36]/p[9]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.015em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'My soul is more than matched...' (pg. 186) -->
<!-- Lose a line to make second song fit on pg. 188.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[38]/p[1]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'-0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'It is a thing well known...' (pg. 200) -->
<!-- Gain a line to make pg. 201 fill its text block.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[41]/p[12]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Let us try...' (pg. 213) -->
<!-- Lose a line to make pg. 212 fill its text block.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[42]/p[13]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.018em'" />
      <xsl:attribute name="word-spacing.minimum" select="'-0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Nor is it...' (pg. 214) -->
<!-- Lose a line to pull two lines to pg. 217.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[42]/p[16]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.01em'" />
      <xsl:attribute name="word-spacing.minimum" select="'-0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Though, consumed...' (pg. 234) -->
<!-- Lose a line to pull two lines to pg. 236.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[46]/p[1]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.005em'" />
      <xsl:attribute name="word-spacing.minimum" select="'-0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'The ship was now kept...' (pg. 240) -->
<!-- Lose a line to pull three lines to pg. 240.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[47]/p[12]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.005em'" />
      <xsl:attribute name="word-spacing.minimum" select="'-0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'The phantoms...' (pg. 240) -->
<!-- Lose a line to pull three lines to pg. 240.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[48]/p[1]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.01em'" />
      <xsl:attribute name="word-spacing.minimum" select="'-0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- '"Oh, I don't mind 'em...' (pg. 242) -->
<!-- Gain a line to make pg. 242 fill its text block.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[48]/p[11]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.005em'" />
      <xsl:attribute name="word-spacing.minimum" select="'-0.015em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Now the advent...' (pg. 244) -->
<!-- Gain a line to make pg. 244 fill its text block.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[48]/p[20]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Not very far distant...' (pg. 245) -->
<!-- Gain a line to make pg. 245 fill its text block.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[48]/p[24]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.01em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.015em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'There are certain queer times...' (pg. 252) -->
<!-- Gain a line to make pg. 252 fill its text block.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[49]/p[1]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.005em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.018em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Here then...' (pg. 253) -->
<!-- Gain a line to make pg. 254 fill its text block.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[49]/p[7]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.01em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Among whale-wise people...' (pg. 255) -->
<!-- Lose a line to pull two lines to pg. 256.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[50]/p[4]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.01em'" />
      <xsl:attribute name="word-spacing.minimum" select="'-0.015em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Now, with the subordinate phantoms...' (pg. 257) -->
<!-- Lose a line to pull two lines to pg. 256.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[50]/p[7]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.01em'" />
      <xsl:attribute name="word-spacing.minimum" select="'-0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Days, weeks passed...' (pg. 258) -->
<!-- Gain a line to fix pg. 257-262.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[51]/p[1]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.005em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'It was while...' (pg. 258) -->
<!-- Gain a line to fix pg. 257-262.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[51]/p[2]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.0025em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.01em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'During all this blackness...' (pg. 261) -->
<!-- Avoid new rivers.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[51]/p[2]/text()">
  <xsl:value-of
      select="ahf:no-break(., ('a silent'))" />
</xsl:template>

<!-- 'Walking the deck...' (pg. 259) -->
<!-- Gain a line to fix pg. 257-262.  -->
<!-- Avoid page break from subordinate fo:block in 'river.xsl'. -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[51]/p[3]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <fo:block xsl:use-attribute-sets="p"
            letter-spacing.minimum="0.005em"
            word-spacing.minimum="0.02em">
      <xsl:sequence select="$atts" />
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<!-- 'But, at last...' (pg. 260) -->
<!-- Gain a line to fix pg. 257-262.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[51]/p[7]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.01em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Cape of Good Hope...' (pg. 261) -->
<!-- Gain a line to fix pg. 257-262.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[51]/p[9]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.005em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.018em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'During all this blackness...' (pg. 261) -->
<!-- Gain a line to fix pg. 257-262.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[51]/p[10]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.005em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'During all this blackness...' (pg. 261) -->
<!-- Gain a line to fix pg. 257-262.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[51]/p[10]/text()">
  <xsl:value-of
      select="ahf:no-break(., ('the needle'))" />
</xsl:template>

<!-- 'Were this world...' (pg. 264) -->
<!-- Lose a line to pull a line to pg. 264.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[52]/p[8]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'-0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'But look at the...' (pg. 267) -->
<!-- Gain a line to make pg. 267 fill its text block.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[53]/p[6]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.005em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.01em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'But look at the...' (pg. 267) -->
<!-- Avoid consecutive hyphens.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[53]/p[6]/text()">
  <xsl:value-of
      select="ahf:no-break(., ('and such'))" />
</xsl:template>

<!-- '"Much this way...' (pg. 273) -->
<!-- Avoid em dash at end of pg. 273 and fill pg. 274.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[54]/p[9]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.005em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.01em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- '"Much this way...' (pg. 273) -->
<!-- Avoid em dash at end of pg. 273 and fill pg. 274.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[54]/p[9]/text()">
  <xsl:value-of
      select="ahf:no-break(., 'deck, and')" />
</xsl:template>

<!-- '"Now, gentlemen...' (pg. 275) -->
<!-- Lose a line to pull two lines to pg. 276.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[54]/p[16]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.01em'" />
      <xsl:attribute name="word-spacing.minimum" select="'-0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- '"Now, gentlemen...' (pg. 275) -->
<!-- Lose a line to pull two lines to pg. 276.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[54]/p[16]/text()">
  <xsl:value-of
      select="ahf:no-break(., 'with his')" />
</xsl:template>

<!-- 'Steelkilt rose...' (pg. 277) -->
<!-- Lose a line to pull two lines to pg. 277.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[54]/p[20]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.01em'" />
      <xsl:attribute name="word-spacing.minimum" select="'-0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'For three hundred and sixty miles...' (pg. 278) -->
<!-- Gain a line to fill pg. 278.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[54]/p[27]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.01em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- '"I see! I see!...' (pg. 280) -->
<!-- Lose a line to pull a line to pg. 279.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[54]/p[32]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'-0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- '"Better turn to now...' (pg. 283) -->
<!-- Gain a line to push a line to pg. 283.  -->
<!-- Makes the same paragraph widow as in the First Edition. -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[54]/p[49]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- '"Upon hearing the frantic project...' (pg. 284) -->
<!-- Gain a line to push a line to pg. 284.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[54]/p[53]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'0.01em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'On Tower-hill...' (pg. 302) -->
<!-- Gain a line to fill pg. 302.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[57]/p[1]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.0025em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.015em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Then, again...' (pg. 304) -->
<!-- Lose a line to pull two lines to pg. 304 (and lose a separator).  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[57]/p[9]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.005em'" />
      <xsl:attribute name="word-spacing.minimum" select="'-0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'But it was only the sound...' (pg. 305) -->
<!-- Lose a line to pull three lines to pg. 307 (and lose a
     separator).  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[58]/p[4]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.02em'" />
      <xsl:attribute name="word-spacing.minimum" select="'-0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Indeed, in other respects...' (pg. 306) -->
<!-- Lose a line to pull three lines to pg. 307 (and lose a
     separator).  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[58]/p[5]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'-0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'In the English boats...' (pg. 312) -->
<!-- Gain a line to push two lines to pg. 317.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[60]/p[5]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Before lowering the boat...' (pg. 313) -->
<!-- Gain a line to push two lines to pg. 317.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[60]/p[7]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Thus the whale-line...' (pg. 313) -->
<!-- Gain a line to push two lines to pg. 318.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[60]/p[8]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.01em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Suddenly bubbles...' (pg. 316) -->
<!-- Gain a line to push two lines to pg. 318.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[61]/p[6]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.02em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'The crotch alluded...' (pg. 323) -->
<!-- Gain a line to push two lines to pg. 324.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[63]/p[2]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Furthermore: you must know...' (pg. 323) -->
<!-- Gain a line to push two lines to pg. 324.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[63]/p[4]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.01em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'If moody Ahab...' (pg. 325) -->
<!-- Gain a line to push two lines to pg. 327.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[64]/p[4]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.015em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Here be it known...' (pg. 326) -->
<!-- Gain a line to push two lines to pg. 327.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[64]/p[6]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.01em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'About midnight...' (pg. 326) -->
<!-- Gain a line to push two lines to pg. 327.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[64]/p[7]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.01em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- '"Your woraciousness...' (pg. 329) -->
<!-- Gain a line to fill pg. 329.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[64]/p[23]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.01em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- '"When dis old brack man...' (pg. 331) -->
<!-- Gain a line to fill pg. 331.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[64]/p[48]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.02em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.022em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- '"When dis old brack man...' (pg. 331) -->
<!-- Gain a line to fill pg. 331.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[64]/p[48]/text()">
  <xsl:value-of
      select="ahf:no-break(., 'go nowhere;')" />
</xsl:template>

<!-- '"Queequeg no care...' (pg. 337) -->
<!-- Lines were cramped.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[66]/p[4]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'A word or two more...' (pg. 342) -->
<!-- Gain a line to push a line to pg. 344.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[68]/p[6]/text()">
  <xsl:value-of
      select="ahf:no-break(., 'a Polar')" />
</xsl:template>

<!-- 'By and bye...' (pg. 348) -->
<!-- Gain a line to push a line to pg. 351.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[71]/p[2]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.004em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.015em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Can'st not read it?...' (pg. 354) -->
<!-- Gain a line to fill pg. 354.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[71]/p[24]/text()">
  <xsl:value-of
      select="ahf:no-break(., 'way, hand')" />
</xsl:template>

<!-- 'Being the savage's bowsman...' (pg. 355) -->
<!-- Lose a line to pull four lines to pg. 359.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[72]/p[2]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.011em'" />
      <xsl:attribute name="word-spacing.minimum" select="'-0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- '"Enough," replied Starbuck...' (pg. 359) -->
<!-- Don't have just &mdash; on a line.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[72]/p[16]/text()">
  <xsl:value-of
      select="ahf:no-break(., 'but&mdash;')" />
</xsl:template>

<!-- 'Now, during the past night...' (pg. 360) -->
<!-- Gain a line to push a line to pg. 361.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[73]/p[2]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.005em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- '"In heaven's name, man...' (pg. 381) -->
<!-- Don't have just &mdash; on a line.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[78]/p[6]/text()">
  <xsl:value-of
      select="ahf:no-break(., 'will ye!')" />
</xsl:template>

<!-- 'In the full-grown creature...' (pg. 387) -->
<!-- Gain a line to fill pg. 387.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[80]/p[2]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.02em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'In the full-grown creature...' (pg. 387) -->
<!-- Gain a line to fill pg. 387.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[80]/p[2]/text()">
  <xsl:analyze-string
      select="ahf:text(.)"
      regex="to regard that mystic">
    <xsl:matching-substring>
      <fo:inline keep-together.within-line="always">
        <xsl:value-of select="." />
      </fo:inline>
    </xsl:matching-substring>
    <xsl:non-matching-substring>
      <xsl:value-of select="." />
    </xsl:non-matching-substring>
  </xsl:analyze-string>
</xsl:template>

<!-- 'But if from...' (pg. 388) -->
<!-- Gain a line to fill pg. 388.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[80]/p[5]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.01em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'But so decided...' (pg. 394) -->
<!-- Gain a line to push a line to pg. 395.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[81]/p[24]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'0.01em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'But so decided...' (pg. 394) -->
<!-- Lose a line to avoid.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[81]/p[24]/text()">
  <xsl:value-of
      select="ahf:no-break(., ('him in', 'stretching from'))" />
</xsl:template>

<!-- 'But the monster's run...' (pg. 396) -->
<!-- Lose a line to pull two lines to pg. 397.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[81]/p[29]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'-0.015em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'His motions...' (pg. 398) -->
<!-- Gain a line to fill pg. 399.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[81]/p[35]/text()">
  <xsl:value-of
      select="ahf:no-break(., 'been struck. His life,')" />
</xsl:template>

<!-- 'As the boats now...' (pg. 398) -->
<!-- Gain a line to fill pg. 399.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[81]/p[36]/text()">
  <xsl:value-of
      select="ahf:no-break(., 'men, and')" />
</xsl:template>

<!-- 'What other marvels...' (pg. 400) -->
<!-- Gain a line to fill pg. 400.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[81]/p[42]/text()">
  <xsl:value-of
      select="ahf:no-break(., ('every moment', 'the sinking'))" />
</xsl:template>

<!-- 'The more I dive...' (pg. 402) -->
<!-- Prevent paragraph widow.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[82]/p[2]/text()">
  <xsl:sequence
      select="ahf:no-hyphen(., 'fraternity')" />
</xsl:template>

<!-- 'Let not the modern paintings...' (pg. 404) -->
<!-- Gain a line to fill pg. 405.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[82]/p[5]/text()">
  <xsl:value-of
      select="ahf:no-break(., ('name; who', 'disdain, since even', 'we are', 'than they'))" />
</xsl:template>

<!-- 'Let us, then...' (pg. 411) -->
<!-- Gain a line to fill pg. 411.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[85]/p[2]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.01em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Let us, then...' (pg. 411) -->
<!-- Gain a line to fill pg. 411.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[85]/p[2]/text()">
  <xsl:sequence
      select="ahf:no-break(., 'inhaling the disengaged')" />
</xsl:template>

<!-- 'Stripped to our shirts and drawers...' (pg. 427) -->
<!-- Different river override. -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[87]/p[15]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'0'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Stripped to our shirts and drawers...' (pg. 427) -->
<!-- Undo override from 'river.xsl'. -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[87]/p[15]/text()">
  <xsl:sequence
      select="ahf:no-break(., 'swimming hither')" />
</xsl:template>

<!-- 'Riotous and disordered...' (pg. 435) -->
<!-- Lose a line to pull two lines from pg. 436.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[87]/p[33]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.01em'" />
      <xsl:attribute name="word-spacing.minimum" select="'-0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Riotous and disordered...' (pg. 435) -->
<!-- Lose a line to pull two lines from pg. 436.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[87]/p[33]/text()">
  <xsl:sequence
      select="ahf:no-break(., 'draw near')" />
</xsl:template>

<!-- 'The result of this lowering...' (pg. 436) -->
<!-- Gain a line to fill pg. 436.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[87]/p[34]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Now, though...' (pg. 436) -->
<!-- Gain a line to fill pg. 436.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[88]/p1[2]/text()">
  <xsl:sequence
      select="ahf:no-break(., 'but young vigorous')" />
</xsl:template>

<!-- 'Is it not a saying...' (pg. 443) -->
<!-- Gain a line to fill pg. 443.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[89]/p[14]/text()">
  <xsl:sequence
      select="ahf:no-break(., ('harpooneer, John', 'the law'))" />
</xsl:template>

<!-- 'I wish it was broken...' (pg. 451) -->
<!-- Gain a line to fill pg. 452.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[91]/p[21]/text()">
  <xsl:sequence
      select="ahf:no-break(., 'the job')" />
</xsl:template>

<!-- 'Marking all this...' (pg. 452) -->
<!-- Gain a line to fill pg. 453.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[91]/p[28]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.02em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Marking all this...' (pg. 452) -->
<!-- Avoid consecutive hyphens.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[91]/p[28]/text()">
  <xsl:sequence
      select="ahf:no-break(., 'that the two')" />
</xsl:template>

<!-- 'Now this ambergris...' (pg. 455) -->
<!-- Lose a line to pull two lines to pg. 458.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[92]/p[1]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'-0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'It came to pass...' (pg. 459) -->
<!-- Lose a line to pull two lines to pg. 464.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[93]/p[4]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.005em'" />
      <xsl:attribute name="word-spacing.minimum" select="'-0.015em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Removing the fireboard...' (pg. 469) -->
<!-- Gain a line to fill pg. 470.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[96]/p[3]/text()">
  <xsl:sequence
      select="ahf:no-break(., ('the rear', 'as fast as it', 'rear wall'))" />
</xsl:template>

<!-- 'But one morning...' (pg. 478) -->
<!-- Lose a line to pull two lines to pg. 481.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[99]/p[2]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.0075em'" />
      <xsl:attribute name="word-spacing.minimum" select="'-0.015em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- '"There now's the old Mogul...' (pg. 480) -->
<!-- Gain a line to fill to pg. 483.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[99]/p[9]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'0.01em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- '"There now's the old Mogul...' (pg. 480) -->
<!-- Avoid a river.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[99]/p[9]/text()">
  <xsl:sequence
      select="ahf:no-break(., 'this as queer')" />
</xsl:template>

<!-- 'Having already in various ways...' (pg. 503) -->
<!-- Gain a line to fill pg. 503.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[103]/p[4]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.015em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Since I have undertaken...' (pg. 506) -->
<!-- Lose a line to pull two lines to pg. 506.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[104]/p[2]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'-0.01em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Drat the file...' (pg. 521) -->
<!-- Gain a line to fill pg. 523.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[108]/p[1]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Um-m. So he must...' (pg. 522) -->
<!-- Gain a line to fill pg. 523.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[108]/p[9]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.005em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Bungle away at it then...' (pg. 524) -->
<!-- Avoid paragraph widow.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[108]/p[31]/text()">
  <xsl:sequence
      select="ahf:no-break(., ('bid with', 'vertebra. So.'))" />
</xsl:template>

<!-- 'Well, well, well...' (pg. 525) -->
<!-- Gain a line to satisfy 'lines before' on pg. 526.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[108]/sp[2]/p[1]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.005em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Hold; while Prometheus...' (pg. 523) -->
<!-- Gain a line to push a line to pg. 525.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[108]/p[11]/text()">
  <xsl:sequence
      select="ahf:no-break(., 'I order eyes')" />
</xsl:template>

<!-- 'At such times...' (pg. 544) -->
<!-- Gain a line to push a line to fill pg. 545.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[114]/p[2]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'0.01em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'At such times...' (pg. 544) -->
<!-- Gain a line to push a line to fill pg. 545.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[114]/p[2]/text()">
  <xsl:sequence
      select="ahf:no-break(., 'these are')" />
</xsl:template>

<!-- 'Then gazing at his quadrant...' (pg. 553) -->
<!-- Lose a line to pull three lines to pg. 554.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[118]/p[3]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.015em'" />
      <xsl:attribute name="word-spacing.minimum" select="'-0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- '"Um, um, um...' (pg. 565) -->
<!-- Cosmetic.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[122]/p[1]/text()">
  <xsl:sequence
      select="ahf:no-break(., 'um, um!')" />
</xsl:template>

<!-- 'Ere knocking...' (pg. 567) -->
<!-- Gain a line to fill pg. 567.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[123]/p[7]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Ere knocking...' (pg. 567) -->
<!-- Gain a line to fill pg. 567.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[123]/p[7]/text()">
  <xsl:sequence
      select="ahf:no-break(., 'evolved an evil thought')" />
</xsl:template>

<!-- 'Long maintaining...' (pg. 569) -->
<!-- Gain a line to fill pg. 570.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[124]/p[2]/text()">
  <xsl:sequence
      select="ahf:no-break(., 'how the same')" />
</xsl:template>

<!-- 'Upon this every soul...' (pg. 570) -->
<!-- Cosmetic..  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[124]/p[7]/text()">
  <xsl:sequence
      select="ahf:no-break(., 'the cause.')" />
</xsl:template>

<!-- 'Meanwhile, whatever...' (pg. 571) -->
<!-- Gain a line to fill pg. 572.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[124]/p[13]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'While now the fated...' (pg. 573) -->
<!-- Lose a line to pull a line to pg. 574.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[125]/p[1]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'-0.005em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'I crush the quadrant...' (pg. 575) -->
<!-- Gain a line to fill pg. 575.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[125]/p[18]/text()">
  <xsl:sequence
      select="ahf:no-break(., ('the carpenter', 'to it'))" />
</xsl:template>

<!-- 'There can be no hearts...' (pg. 576) -->
<!-- Gain a line to fill pg. 576.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[125]/p[26]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.01em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'There can be no hearts...' (pg. 576) -->
<!-- Gain a line to fill pg. 576.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[125]/p[26]/text()">
  <xsl:sequence
      select="ahf:no-break(., ('and have', 'lives. Thou'))" />
</xsl:template>

<!-- '"Oh, boy, nor will I thee...' (pg. 576) -->
<!-- Lose a line to pull two lines to pg. 576.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[125]/p[28]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'-0.0025em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Steering now south-eastward...' (pg. 577) -->
<!-- Lose a line to pull a line to pg. 577.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[126]/p[1]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.004em'" />
      <xsl:attribute name="word-spacing.minimum" select="'-0.01em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Those rocky islands...' (pg. 577) -->
<!-- Lose a line to pull a line to pg. 578.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[126]/p[4]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.02em'" />
      <xsl:attribute name="word-spacing.minimum" select="'-0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'But the bodings...' (pg. 578) -->
<!-- Lose a line to pull three lines to pg. 579.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[126]/p[5]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.005em'" />
      <xsl:attribute name="word-spacing.minimum" select="'-0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'And thus the first man...' (pg. 578) -->
<!-- Lose a line to pull three lines to pg. 579.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[126]/p[7]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.01em'" />
      <xsl:attribute name="word-spacing.minimum" select="'-0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Now, as it shortly...' (pg. 586) -->
<!-- Gain a line to fill pg. 587.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[128]/p[13]/text()">
  <xsl:sequence
      select="ahf:no-break(., 'race. Nor does it unfrequently')" />
</xsl:template>

<!-- 'And yet, somehow...' (pg. 592) -->
<!-- Gain a line to fill pg. 592.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[130]/p[6]/text()">
  <xsl:sequence
      select="ahf:no-break(., 'rib. For')" />
</xsl:template>

<!-- '"Nothing, nothing, sir!...' (pg. 601) -->
<!-- Prevent paragraph widow.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[133]/p[6]/text()">
  <xsl:sequence
      select="ahf:no-hyphen(., 'reply.')" />
</xsl:template>

<!-- 'All sail being set...' (pg. 602) -->
<!-- Gain a line to fill pg. 602.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[133]/p[8]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'0.01em'" />
      <xsl:attribute name="word-spacing.minimum" select="'0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'All sail being set...' (pg. 602) -->
<!-- Gain a line to fill pg. 602.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[133]/p[8]/text()">
  <xsl:sequence
      select="ahf:no-hyphen(., 'two thirds')" />
</xsl:template>

<!-- 'And thus, through...' (pg. 604) -->
<!-- Gain a line to fill pg. 604.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[133]/p[19]/text()">
  <xsl:sequence
      select="ahf:no-hyphen(., 'of sight')" />
</xsl:template>

<!-- 'But at last...' (pg. 616) -->
<!-- Gain a line for fill pg. 617.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[134]/p[20]/text()">
  <xsl:sequence
      select="ahf:no-break(., 'more line: and then')" />
</xsl:template>

<!-- 'The first uprising momentum...' (pg. 617) -->
<!-- Gain a line for fill pg. 618.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[134]/p[23]/text()">
  <xsl:sequence
      select="ahf:no-break(., ('for a', 'his work', 'for that time', 'intertangled lines'))" />
</xsl:template>

<!-- '"The Parsee!...' (pg. 619) -->
<!-- Avoid paragraph widow.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[134]/p[37]/text()">
  <xsl:sequence
      select="ahf:no-break(., ('in&mdash2;'))" />
</xsl:template>

<!-- 'So once more...' (pg. 621) -->
<!-- Avoid paragraph widow.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[134]/p[47]/text()">
  <xsl:sequence
      select="ahf:no-hyphen(., 'earliest sun.')" />
</xsl:template>

<!-- '"In his infallible wake...' (pg. 621) -->
<!-- Gain a line to fill pg. 623.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[135]/p[3]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'0.005em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'And thus, through...' (pg. 621) -->
<!-- Avoid paragraph widow.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[135]/p[5]/text()">
  <xsl:sequence
      select="ahf:no-hyphen(., 'braces!')" />
</xsl:template>

<!-- '"They will last...' (pg. 629) -->
<!-- Lose a line to pull a a line to pg. 631.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[135]/p[42]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'-0.02em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'At length as the craft...' (pg. 630) -->
<!-- Gain a line to fill pg. 630.  -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[135]/p[43]/text()">
  <xsl:sequence
      select="ahf:no-break(., 'third man')" />
</xsl:template>

</xsl:stylesheet>
