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

<xsl:import href="tei2fo.xsl"/>


<!-- ============================================================= -->
<!-- TEMPLATES                                                     -->
<!-- ============================================================= -->

<!-- Additional hyphenation exceptions. -->
<xsl:template match="axf:hyphenation-info"
              mode="axf:hyphenation-info">
  <xsl:apply-imports />
  <axf:hyphenation-info
      language="eng"
      xmlns:axh="http://www.antennahouse.com/names/XSL/Hyphenations">
    <axh:exceptions>
      Actium
      Damocles
      Duodecimo
      humbug
      Hussey
      Jonah
      Jonah’s
      OCTAVO
      Octavo
      octavo
    </axh:exceptions>
  </axf:hyphenation-info>
</xsl:template>

<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[15]/p[4]/text()">
  <xsl:value-of
      select="replace(ahf:text(.), ' ye!&rdquo;$', '&nbsp;ye!&rdquo;')" />
</xsl:template>

<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[18]/p[25]/text()">
  <xsl:value-of
      select="replace(ahf:text(.), ' of\.&rdquo;$', '&nbsp;of.&rdquo;')" />
</xsl:template>

<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[29]/p[9]/text()">
  <xsl:value-of
      select="replace(ahf:text(.), 'retreated\.$', 'retrea&zwj;ted.')" />
</xsl:template>

<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[33]/p[5]/text()">
  <xsl:value-of
      select="replace(ahf:text(.), ' sea\.$', '&nbsp;sea.')" />
</xsl:template>

<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[37]/stage[1]/text()">
  <xsl:value-of
      select="replace(ahf:text(.), ' out\.$', '&nbsp;out.')" />
</xsl:template>

<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[42]/p[8]/text()">
  <xsl:value-of
      select="replace(ahf:text(.), ' so\?$', '&nbsp;so?')" />
</xsl:template>

<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[42]/p[23]/text()">
  <xsl:value-of
      select="replace(ahf:text(.), ' colt!$', '&nbsp;colt!')" />
</xsl:template>

<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[47]/p[1]/text()">
  <xsl:value-of
      select="replace(ahf:text(.), '\s+self\.$', '&nbsp;self.')" />
</xsl:template>

<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[50]/p[7]/text()">
  <fo:wrapper hyphenation-push-character-count="5">
    <xsl:next-match />
  </fo:wrapper>
</xsl:template>

<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[54]/p[52]/text()">
  <xsl:value-of
      select="replace(ahf:text(.), ' out\.$', '&nbsp;out.')" />
</xsl:template>

<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[54]/p[71]/text()">
  <xsl:value-of
      select="replace(ahf:text(.), ' me\.&rsquo;$', '&nbsp;me.&rsquo;')" />
</xsl:template>

<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[54]/p[108]/text()">
  <xsl:value-of
      select="replace(ahf:text(.), ' it\.&rsquo;$', '&nbsp;it.&rsquo;')" />
</xsl:template>

<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[59]/p[6]/text()">
  <xsl:value-of
      select="replace(ahf:text(.), ' life\.$', '&nbsp;life.')" />
</xsl:template>

<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[59]/p[11]/text() |
                     /TEI/text[1]/body[1]/div[1]/div[133]/p[35]/text()">
  <xsl:value-of
      select="replace(ahf:text(.), ' it\.$', '&nbsp;it.')" />
</xsl:template>

<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[61]/p[8]/text()">
  <xsl:value-of
      select="replace(ahf:text(.), ' up\.$', '&nbsp;up.')" />
</xsl:template>

<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[64]/p[16]/text()">
  <xsl:value-of
      select="replace(ahf:text(.), ' go\.$', '&nbsp;go.')" />
</xsl:template>

<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[64]/p[24]/text()">
  <xsl:value-of
      select="replace(ahf:text(.), ' on\.&rdquo;$', '&nbsp;on.&rdquo;')" />
</xsl:template>

<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[64]/p[56]/text()">
  <fo:wrapper hyphenation-push-character-count="5">
    <xsl:next-match />
  </fo:wrapper>
</xsl:template>

<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[72]/p[13]/text()">
  <xsl:value-of
      select="replace(ahf:text(.),
              '\s+ye\?&rdquo;', '&nbsp;ye?&rdquo;')" />
</xsl:template>

<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[81]/p[13]/text()">
  <xsl:value-of
      select="replace(ahf:text(.), ' say\.$', '&nbsp;say.')" />
</xsl:template>

<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[82]/p[3]/text() |
                     /TEI/text[1]/body[1]/div[1]/div[108]/p[18]/text() |
                     /TEI/text[1]/body[1]/div[1]/div[126]/p[18]/text()">
  <xsl:value-of
      select="replace(ahf:text(.), '\s+(\S+)$', '&nbsp;$1')" />
</xsl:template>

<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[117]/p[4]/text()">
  <xsl:value-of
      select="replace(ahf:text(.), ' he\.$', '&nbsp;he.')" />
</xsl:template>

<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[120]/p[1]/text()">
  <xsl:value-of
      select="replace(ahf:text(.),
                      ' sir\?&rdquo;$', '&nbsp;sir?&rdquo;')" />
</xsl:template>

<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[126]/p[5]/text()">
  <xsl:value-of
      select="replace(ahf:text(.), ' sea\.$', '&nbsp;sea.')" />
</xsl:template>
<!--
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[126]/p[18]/text()">
  <xsl:value-of
      select="replace(ahf:text(.), ' me\.$', '&nbsp;me.')" />
</xsl:template>
-->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[127]/p[16]/text()">
  <xsl:value-of
      select="replace(ahf:text(.),
                      ' sir\.&rdquo;$', '&nbsp;sir.&rdquo;')" />
</xsl:template>

<xsl:template match="/TEI/text[1]/back[1]/div[6]/p[1]/text()">
  <xsl:value-of
      select="replace(ahf:text(.), '\$2 00\.$', '\$2&nbsp;00.')" />
</xsl:template>

<xsl:template match="/TEI/text[1]/back[1]/div[6]/p[4]/text()">
  <xsl:value-of
      select="replace(ahf:text(.), '\$7 50\.$', '\$7&nbsp;50.')" />
</xsl:template>

</xsl:stylesheet>
