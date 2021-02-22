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

<xsl:output
    method="xml"
    omit-xml-declaration='yes'
    indent="no"
    encoding="UTF-8"/>

<!-- ============================================================= -->
<!-- STYLESHEET PARAMETERS                                         -->
<!-- ============================================================= -->


<!-- ============================================================= -->
<!-- ATTRIBUTE SETS                                                -->
<!-- ============================================================= -->


<!-- ============================================================= -->
<!-- TEMPLATES                                                     -->
<!-- ============================================================= -->

<!-- Copy everything else that doesn't have a template rule. -->
<xsl:mode on-no-match="shallow-copy" />

<xsl:template match="text()">
  <xsl:analyze-string select="." regex="&nbsp;">
    <xsl:matching-substring>
      <fo:change-bar-begin
          change-bar-class="nbsp"
          change-bar-style="solid"
          change-bar-color="#0000FF20"
          change-bar-width="5pt"
          change-bar-placement="alternate"
          change-bar-offset="0" />
      <xsl:value-of select="." />
      <fo:change-bar-end change-bar-class="nbsp" />
    </xsl:matching-substring>
    <xsl:non-matching-substring>
      <xsl:value-of select="." />
    </xsl:non-matching-substring>
  </xsl:analyze-string>
</xsl:template>

<xsl:template match="*[@axf:analyze-lines-before]"
              priority="5">
  <fo:change-bar-begin
      change-bar-class="axf_analyze-lines-before"
      change-bar-style="solid"
      change-bar-color="#FF000020"
      change-bar-width="5pt"
      change-bar-placement="alternate"
      change-bar-offset="5pt" />
  <xsl:next-match />
  <fo:change-bar-end change-bar-class="axf_analyze-lines-before" />
</xsl:template>

<xsl:template match="*[@axf:analyze-lines-after]"
              priority="5.1">
  <fo:change-bar-begin
      change-bar-class="axf_analyze-lines-after"
      change-bar-style="dashed"
      change-bar-color="#00FF0020"
      change-bar-width="5pt"
      change-bar-placement="alternate"
      change-bar-offset="5pt" />
  <xsl:next-match />
  <fo:change-bar-end change-bar-class="axf_analyze-lines-after" />
</xsl:template>

<xsl:template match="*[@axf:analyze-white-space]"
              priority="5.1">
  <fo:change-bar-begin
      change-bar-class="axf_analyze-white-space"
      change-bar-style="dashed"
      change-bar-color="#0000FF20"
      change-bar-width="5pt"
      change-bar-placement="alternate"
      change-bar-offset="5pt" />
  <xsl:next-match />
  <fo:change-bar-end change-bar-class="axf_analyze-white-space" />
</xsl:template>

<xsl:template match="*[@word-spacing.minimum]"
              priority="10">
  <fo:change-bar-begin
      change-bar-class="word-spacing.minimum"
      change-bar-style="solid"
      change-bar-color="#80800020"
      change-bar-width="5pt"
      change-bar-placement="alternate"
      change-bar-offset="10pt" />
  <xsl:next-match />
  <fo:change-bar-end change-bar-class="word-spacing.minimum" />
</xsl:template>

<xsl:template match="*[@letter-spacing.minimum]"
              priority="15">
  <fo:change-bar-begin
      change-bar-class="letter-spacing.minimum"
      change-bar-style="solid"
      change-bar-color="#00808020"
      change-bar-width="5pt"
      change-bar-placement="alternate"
      change-bar-offset="15pt" />
  <xsl:next-match />
  <fo:change-bar-end change-bar-class="letter-spacing.minimum" />
</xsl:template>

<xsl:template match="*[@hyphenation-push-character-count]"
              priority="20">
  <fo:change-bar-begin
      change-bar-class="hyphenation-push-character-count"
      change-bar-style="solid"
      change-bar-color="#80008020"
      change-bar-width="5pt"
      change-bar-placement="alternate"
      change-bar-offset="20pt" />
  <xsl:next-match />
  <fo:change-bar-end change-bar-class="hyphenation-push-character-count" />
</xsl:template>

<xsl:template match="*[@hyphenation-remain-character-count]"
              priority="20.1">
  <fo:change-bar-begin
      change-bar-class="hyphenation-remain-character-count"
      change-bar-style="solid"
      change-bar-color="#80008020"
      change-bar-width="5pt"
      change-bar-placement="alternate"
      change-bar-offset="20pt" />
  <xsl:next-match />
  <fo:change-bar-end change-bar-class="hyphenation-remain-character-count" />
</xsl:template>

<xsl:template match="*[@orphans]"
              priority="25">
  <fo:change-bar-begin
      change-bar-class="orphans"
      change-bar-style="solid"
      change-bar-color="#CC008020"
      change-bar-width="5pt"
      change-bar-placement="alternate"
      change-bar-offset="25pt" />
  <xsl:next-match />
  <fo:change-bar-end change-bar-class="orphans" />
</xsl:template>

<xsl:template match="*[@widows]"
              priority="25.1">
  <fo:change-bar-begin
      change-bar-class="widows"
      change-bar-style="solid"
      change-bar-color="#CC008020"
      change-bar-width="5pt"
      change-bar-placement="alternate"
      change-bar-offset="25pt" />
  <xsl:next-match />
  <fo:change-bar-end change-bar-class="widows" />
</xsl:template>

</xsl:stylesheet>
