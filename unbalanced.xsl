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

</xsl:stylesheet>
