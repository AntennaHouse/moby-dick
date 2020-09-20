<?xml version='1.0' encoding='UTF-8'?>

<!-- 'Moby-Dick' first edition. -->
<!-- http://webapp1.dlib.indiana.edu/TEIgeneral/view?docId=wright/VAC7237.xml -->

<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:m="http://www.mentea.net/"
    xmlns:axf="http://www.antennahouse.com/names/XSL/Extensions"
    xmlns:xhtml="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="m tei xs xhtml"
    version="2.0">

<xsl:import href="fo-layout.xsl"/>

<xsl:output
    method="xml"
    omit-xml-declaration='yes'
    indent="yes"
    encoding="UTF-8"/>

<xsl:strip-space elements="*" />

<xsl:param
    name="debug"
    select="'no'"
    as="xs:string" />

<xsl:param
    name="no-rule"
    select="'article,preamble'"
    as="xs:string" />

<xsl:param
    name="font-size"
    select="'7.625pt'"
    as="xs:string" />

<xsl:param
    name="line-height"
    select="'1.5'"
    as="xs:string" />

<xsl:param
    name="font-family-default"
    select="'Century, ''Times New Roman'', serif'"
    as="xs:string" />

<xsl:param
    name="font-family-monospace"
    select="'TiredOfCourier, Courier, Courier New, opensymbol, symbol, ZapfDingbats, Lucida Sans Unicode'"
    as="xs:string" />

<xsl:variable
    name="no-rule-strings"
    select="if ($no-rule ne '')
        then tokenize($no-rule, ', *')
      else ()"
    as="xs:string*" />


<!--
<xsl:param name="grid-x" select="$page-width div 9"/>
<xsl:param name="grid-y" select="$page-height div 9"/>

<xsl:param name="body-inside" select="$grid-x * 1"/>
<xsl:param name="body-outside" select="$grid-x * 2"/>
<xsl:param name="body-before" select="$grid-y"/>
<xsl:param name="body-after" select="$grid-y * 2"/>

<xsl:param name="after-extent" select="$grid-y * 2 div 3"/>
<xsl:param name="before-extent" select="$grid-y div 2"/>
<xsl:param name="inside-extent" select="$grid-x"/>
<xsl:param name="outside-extent" select="$grid-x * 2"/>
-->
<xsl:param name="list-separation" select="'0.5em'"/>
<xsl:param name="label-separation" select="'0.5em'"/>

<xsl:param name="ordered-list-separation" select="'15pt'"/>
<xsl:param name="ordered-label-separation" select="'5pt'"/>

<xsl:attribute-set name="tei:p">
  <xsl:attribute name="text-indent" select="'1em'" />
</xsl:attribute-set>

<xsl:template match="tei:TEI">
  <fo:root font-size="{$font-size}"
           font-family="{$font-family-default}"
           font-selection-strategy="character-by-character"
           line-height="{$line-height}">
    <xsl:call-template
        name="layout-master-set"/>
    <fo:page-sequence
        master-reference="PageMaster"
        writing-mode="from-page-master-region()"
        initial-page-number="auto-odd">
      <xsl:call-template name="PageMaster-static-content"/>
      <fo:flow flow-name="xsl-region-body">
        <fo:block>
          <xsl:apply-templates select="tei:teiHeader" />
        </fo:block>
      </fo:flow>
    </fo:page-sequence>
    <xsl:apply-templates select="tei:text" />
  </fo:root>
</xsl:template>

<xsl:template match="tei:front | tei:body | tei:back">
  <fo:page-sequence
      master-reference="PageMaster"
      writing-mode="from-page-master-region()"
      initial-page-number="{if (self::tei:front or self::tei:body)
                              then 1
                            else 'auto-odd'}">
    <xsl:call-template name="PageMaster-static-content"/>
    <fo:flow flow-name="xsl-region-body" hyphenate="true"
             text-align="justify">
      <xsl:apply-templates />
    </fo:flow>
  </fo:page-sequence>
</xsl:template>

<xsl:template match="tei:div[@type = 'book']/tei:head" />
 
<xsl:template
    match="tei:docTitle | tei:byline | tei:docImprint | tei:docDate">
  <fo:block>
    <xsl:apply-templates />
  </fo:block>
</xsl:template>
 
<xsl:template
    match="tei:div[@type = ('fly_title', 'intro_text', 'contents', 'chapter', 'advertisement')]/tei:head">
  <fo:block
      padding-before="0.75in"
      space-after.precedence="1"
      text-align="center">
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<xsl:template match="tei:head[@type = 'sub']"
              priority="5">
  <fo:block
      text-align="center"
      padding-before="1em"
      padding-after="1em"
      font-variant="all-small-caps">
    <fo:marker marker-class-name="Chapter-Title">
      <xsl:apply-templates mode="marker" />
    </fo:marker>
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<xsl:template match="tei:sp">
  <fo:block>
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<xsl:template match="tei:p">
  <fo:block xsl:use-attribute-sets="tei:p">
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<xsl:template match="tei:epigraph">
  <fo:block>
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<xsl:template match="tei:bibl">
  <fo:block text-align="right">
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<xsl:template match="tei:l">
  <fo:block>
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<xsl:template match="tei:closer">
  <fo:block text-align="center">
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<xsl:template match="tei:stage">
  <fo:block
      text-align="center" font-style="italic">
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<xsl:template match="tei:list/tei:item">
  <fo:block
      text-align="center" font-style="italic">
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<xsl:template
    match="tei:hi[@rend eq 'i'] |
           text()[preceding-sibling::node()[1][self::tei:hi[@rend eq 'i']][empty(node())]]">
  <fo:inline font-style="italic">
    <xsl:value-of select="." />
  </fo:inline>
</xsl:template>

<xsl:template match="tei:lb">
  <fo:block />
</xsl:template>

<xsl:template match="tei:pb[@xml:id]">
  <fo:wrapper xml:id="{@xml:id}" />
</xsl:template>

</xsl:stylesheet>
