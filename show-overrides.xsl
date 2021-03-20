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

<xsl:output
    method="xml"
    use-character-maps="zwj"
    omit-xml-declaration='yes'
    indent="no"
    encoding="UTF-8"/>

<!-- Generate &zwj; as numeric character reference so it is
     visible. -->
<xsl:character-map name="zwj">
  <xsl:output-character character="&zwj;" string="&amp;#x2060;" />
</xsl:character-map>

<!-- ============================================================= -->
<!-- STYLESHEET PARAMETERS                                         -->
<!-- ============================================================= -->

<xsl:param name="limit" select="'0.2'" as="xs:string" />

<xsl:param name="tint-base" select="0.2" as="xs:decimal" />

<xsl:param name="saturation" select="'100%'" as="xs:string" />

<xsl:param name="change-bar-width" select="'5'" as="xs:string" />

<!-- ============================================================= -->
<!-- ATTRIBUTE SETS                                                -->
<!-- ============================================================= -->


<!-- ============================================================= -->
<!-- TEMPLATES                                                     -->
<!-- ============================================================= -->

<!-- Copy everything else that doesn't have a template rule. -->
<xsl:mode on-no-match="shallow-copy" />

<xsl:template match="fo:flow//text()">
  <xsl:analyze-string select="." regex="&nbsp;">
    <xsl:matching-substring>
      <fo:change-bar-begin
          change-bar-class="nbsp"
          change-bar-style="solid"
          change-bar-color="#0000FF20"
          change-bar-width="{$change-bar-width}pt"
          change-bar-placement="alternate"
          change-bar-offset="0" />
      <xsl:value-of select="." />
      <fo:change-bar-end change-bar-class="nbsp" />
    </xsl:matching-substring>
    <xsl:non-matching-substring>
      <xsl:analyze-string select="." regex="&zwj;">
        <xsl:matching-substring>
          <fo:change-bar-begin
              change-bar-class="zwj"
              change-bar-style="solid"
              change-bar-color="#0000FF20"
              change-bar-width="{$change-bar-width}pt"
              change-bar-placement="alternate"
              change-bar-offset="0" />
          <xsl:value-of select="." />
          <fo:change-bar-end change-bar-class="zwj" />
        </xsl:matching-substring>
        <xsl:non-matching-substring>
          <xsl:value-of select="." />
        </xsl:non-matching-substring>
      </xsl:analyze-string>
    </xsl:non-matching-substring>
  </xsl:analyze-string>
</xsl:template>

<xsl:template match="fo:flow//*[@axf:analyze-lines-before]"
              priority="5">
  <fo:change-bar-begin
      change-bar-class="axf_analyze-lines-before"
      change-bar-style="solid"
      change-bar-color="#FF000020"
      change-bar-width="{$change-bar-width}pt"
      change-bar-placement="alternate"
      change-bar-offset="{$change-bar-width}pt" />
  <xsl:next-match />
  <fo:change-bar-end change-bar-class="axf_analyze-lines-before" />
</xsl:template>

<xsl:template match="fo:flow//*[@axf:analyze-lines-after]"
              priority="5.1">
  <fo:change-bar-begin
      change-bar-class="axf_analyze-lines-after"
      change-bar-style="dashed"
      change-bar-color="#00FF0020"
      change-bar-width="{$change-bar-width}pt"
      change-bar-placement="alternate"
      change-bar-offset="{$change-bar-width}pt" />
  <xsl:next-match />
  <fo:change-bar-end change-bar-class="axf_analyze-lines-after" />
</xsl:template>

<xsl:template match="*[@axf:analyze-white-space]"
              priority="5.1">
  <fo:change-bar-begin
      change-bar-class="axf_analyze-white-space"
      change-bar-style="dashed"
      change-bar-color="#0000FF20"
      change-bar-width="{$change-bar-width}pt"
      change-bar-placement="alternate"
      change-bar-offset="{$change-bar-width}pt" />
  <xsl:next-match />
  <fo:change-bar-end change-bar-class="axf_analyze-white-space" />
</xsl:template>

<xsl:template match="fo:flow//*[@word-spacing.minimum]"
              priority="10">
  <fo:change-bar-begin
      change-bar-class="word-spacing.minimum"
      change-bar-style="solid"
      change-bar-color="{if (starts-with(normalize-space(@word-spacing.minimum), '-'))
                           then concat('hsla(0, 100%, 40%, ',
                                       $tint-base,
                                       ')')
                         else concat('hsla(180, 100%, 40%, ',
                                     $tint-base,
                                     ')')}"
      change-bar-width="{$change-bar-width}pt"
      change-bar-placement="alternate"
      change-bar-offset="10pt" />
  <xsl:next-match />
  <fo:change-bar-end change-bar-class="word-spacing.minimum" />
</xsl:template>

<xsl:template match="fo:flow//*[@letter-spacing.minimum]"
              priority="15">
  <fo:change-bar-begin
      change-bar-class="letter-spacing.minimum"
      change-bar-style="solid"
      change-bar-color="{if (starts-with(normalize-space(@letter-spacing.minimum), '-'))
                           then concat('hsla(300, 100%, 40%, ',
                                       $tint-base,
                                       ')')
                         else concat('hsla(120, 100%, 40%, ',
                                     $tint-base,
                                     ')')}"
      change-bar-width="{$change-bar-width}pt"
      change-bar-placement="alternate"
      change-bar-offset="15pt" />
  <xsl:next-match />
  <fo:change-bar-end change-bar-class="letter-spacing.minimum" />
</xsl:template>

<xsl:template match="fo:flow//*[@hyphenation-push-character-count]"
              priority="20">
  <fo:change-bar-begin
      change-bar-class="hyphenation-push-character-count"
      change-bar-style="solid"
      change-bar-color="hsla(60, 100%, 40%, 0.2)"
      change-bar-width="{$change-bar-width}pt"
      change-bar-placement="alternate"
      change-bar-offset="20pt" />
  <xsl:next-match />
  <fo:change-bar-end change-bar-class="hyphenation-push-character-count" />
</xsl:template>

<xsl:template match="fo:flow//*[@hyphenation-remain-character-count]"
              priority="20.1">
  <fo:change-bar-begin
      change-bar-class="hyphenation-remain-character-count"
      change-bar-style="solid"
      change-bar-color="hsla(60, 100%, 40%, 0.2)"
      change-bar-width="{$change-bar-width}pt"
      change-bar-placement="alternate"
      change-bar-offset="20pt" />
  <xsl:next-match />
  <fo:change-bar-end change-bar-class="hyphenation-remain-character-count" />
</xsl:template>

<xsl:template match="fo:flow//*[@orphans]"
              priority="25">
  <fo:change-bar-begin
      change-bar-class="orphans"
      change-bar-style="solid"
      change-bar-color="hsla(240, 100%, 40%, 0.2)"
      change-bar-width="{$change-bar-width}pt"
      change-bar-placement="alternate"
      change-bar-offset="25pt" />
  <xsl:next-match />
  <fo:change-bar-end change-bar-class="orphans" />
</xsl:template>

<xsl:template match="fo:flow//*[@widows]"
              priority="25.1">
  <fo:change-bar-begin
      change-bar-class="widows"
      change-bar-style="solid"
      change-bar-color="hsla(240, 100%, 40%, 0.2)"
      change-bar-width="{$change-bar-width}pt"
      change-bar-placement="alternate"
      change-bar-offset="25pt" />
  <xsl:next-match />
  <fo:change-bar-end change-bar-class="widows" />
</xsl:template>

<xsl:template match="fo:flow//*[@keep-together.within-line]"
              priority="30">
  <fo:change-bar-begin
      change-bar-class="keep-together.within-line"
      change-bar-style="solid"
      change-bar-color="hsla(270, 100%, 40%, 0.2)"
      change-bar-width="{$change-bar-width}pt"
      change-bar-placement="alternate"
      change-bar-offset="30pt" />
  <xsl:next-match />
  <fo:change-bar-end change-bar-class="keep-together.within-line" />
</xsl:template>


<!-- ============================================================= -->
<!-- FUNCTIONS                                                     -->
<!-- ============================================================= -->

<xsl:function name="ahf:change-bar-color" as="xs:string">
  <xsl:param name="value" as="xs:string" />
  <xsl:param name="positive" as="xs:string" />
  <xsl:param name="negative" as="xs:string" />

  <xsl:sequence
      select="if (starts-with(normalize-space($value), '-'))
                then concat('hsla(300, 100%, 40%, ',
                                       $tint-base,
                                       ')')
              else concat('hsla(120, 100%, 40%, ',
                                     $tint-base,
                                     ')')" />
</xsl:function>

</xsl:stylesheet>
