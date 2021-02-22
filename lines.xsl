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

<xsl:import href="river.xsl"/>


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

<xsl:template
    match="p[preceding-sibling::*[1][self::head][@type = 'sub']]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="orphans"
                     select="$analyze-lines-after" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<xsl:template match="div[@type = 'chapter']/p[last()]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="widows"
                     select="$analyze-lines-before" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'To accomplish his object...' (pg. 235) -->
<!-- River caused by setting 'orphans' and 'widows'. -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[46]/p[2]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="letter-spacing.minimum" select="'-0.005em'" />
      <xsl:attribute name="word-spacing.minimum" select="'-0.005em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<!-- 'Walking the deck with...' (pg. 259) -->
<!-- For lines before Chapter LII (pg. 262) -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[51]/p[3]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <fo:block text-align-last="justify" xsl:use-attribute-sets="p">
    <xsl:copy-of select="$atts" />
    <xsl:variable name="text" select="ahf:text(text())" />
    <xsl:value-of select="substring-before($text, 'so many sails,')" />
    <xsl:text>so many sails,</xsl:text>
    <fo:block text-indent="0" text-align-last="left">
      <xsl:value-of select="substring-after($text, 'so many sails,')" />
    </fo:block>
  </fo:block>
</xsl:template>

</xsl:stylesheet>
