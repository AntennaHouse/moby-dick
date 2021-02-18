<?xml version='1.0' encoding='UTF-8'?>
<!DOCTYPE xsl:stylesheet [
<!ENTITY lsquo '&#x2018;' >
<!ENTITY rsquo '&#x2019;' >
<!ENTITY ldquo '&#x201C;' >
<!ENTITY rdquo '&#x201D;' >
<!ENTITY nbsp  '&#xA0;' >
<!ENTITY ndash '&#x2013;' >
<!ENTITY times '&#xD7;' >
<!ENTITY zwj   '&#x2060;' >
]>

<!-- Copyright 2020 Antenna House, Inc. -->
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

<xsl:import href="consecutive-hyphens.xsl"/>


<!-- ============================================================= -->
<!-- ATTRIBUTE SETS                                                -->
<!-- ============================================================= -->

<!-- Table of Contents. -->
<xsl:attribute-set name="contents">
  <xsl:attribute name="axf:analyze-white-space" select="'none'" />
</xsl:attribute-set>


<!-- ============================================================= -->
<!-- TEMPLATES                                                     -->
<!-- ============================================================= -->

<!-- Page numbers are from the First Edition. -->

<!-- '* * * It is a matter of great astonishment...' (pg. xix) -->
<xsl:template
    match="/TEI/text[1]/front[1]/div[8]/p[1]/cit[61]/q[1]/p[2]">
  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.0075em'" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'On one occasion...' (pg. xxii) -->
<xsl:template
    match="/TEI/text[1]/front[1]/div[8]/p[1]/cit[77]/q[1]/p[1]">
  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.015em'" />
      <xsl:attribute name="word-spacing.minimum" select="'-0.015em'" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Come on, Queequeg...' (pg. 72) -->
<xsl:template
    match="/TEI/text[1]/body[1]/div[1]/div[15]/p[5]">
  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="axf:analyze-white-space" select="'none'" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Here ends BOOK II. (Octavo)...' (pg. 157) -->
<xsl:template
    match="/TEI/text[1]/body[1]/div[1]/div[32]/p[37]">
  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="axf:analyze-white-space" select="'none'" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'There are certain queer times...' (pg. 252) -->
<xsl:template
    match="/TEI/text[1]/body[1]/div[1]/div[49]/p[1]">
  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.005em'" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- Change 'According to the invariable usage...' (pg. 321) to affect
     page break for 'The old black...' (pg. 327) -->
<xsl:template
    match="/TEI/text[1]/body[1]/div[1]/div[62]/p[2]">
  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.0075em'" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'The devil fetch...' -->
<xsl:template
    match="/TEI/text[1]/body[1]/div[1]/div[3]/p[29]">
  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.0075em'" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- Change 'It is not probable that this monomania...' to affect page
     break for 'Here, then, was this grey-headed...' -->
<xsl:template
    match="/TEI/text[1]/body[1]/div[1]/div[41]/p[20]">
  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.006em'" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Already several fatalities...' (pg. 202) -->
<xsl:template
    match="/TEI/text[1]/body[1]/div[1]/div[41]/p[17]">
  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.005em'" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'The boat was now all but jammed...' (pg. 435) -->
<xsl:template
    match="/TEI/text[1]/body[1]/div[1]/div[87]/p[32]">
  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.0075em'" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'The schools composing...' (pg. 439) -->
<xsl:template
    match="/TEI/text[1]/body[1]/div[1]/div[88]/p[9]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="axf:analyze-white-space" select="'none'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Squeeze! squeeze! squeeze!...' (pg. 464) -->
<xsl:template
    match="/TEI/text[1]/body[1]/div[1]/div[94]/p[5]">
  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.0015em'" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- '"He waxes brave...' (pg. 528) -->
<xsl:template
    match="/TEI/text[1]/body[1]/div[1]/div[109]/p[17]">
  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="axf:analyze-white-space" select="'none'" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Like noiseless nautilus...' (pg. 603) -->
<xsl:template
    match="/TEI/text[1]/body[1]/div[1]/div[133]/p[16]/text()">
  <xsl:analyze-string
      select="ahf:text(.)"
      regex="Like noiseless nautilus shells, their light prows sped through the sea;">
    <xsl:matching-substring>
      <fo:inline letter-spacing.minimum="-0.0075em">
        <xsl:value-of select="." />
      </fo:inline>
    </xsl:matching-substring>
    <xsl:non-matching-substring>
      <xsl:value-of select="." />
    </xsl:non-matching-substring>
  </xsl:analyze-string>
</xsl:template>

</xsl:stylesheet>
