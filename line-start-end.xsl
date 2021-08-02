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

<!--
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-->

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

<xsl:import href="paragraph-widow-2.xsl"/>


<!-- ============================================================= -->
<!-- TEMPLATES                                                     -->
<!-- ============================================================= -->

<!-- Additional hyphenation exceptions. -->
<!--
<xsl:template match="axf:hyphenation-info"
              mode="axf:hyphenation-info">
  <xsl:apply-imports />
  <axf:hyphenation-info
      language="eng"
      xmlns:axh="http://www.antennahouse.com/names/XSL/Hyphenations">
    <axh:exceptions>
      Phædon
    </axh:exceptions>
  </axf:hyphenation-info>
</xsl:template>
-->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[3]/p[45]/text()">
  <xsl:value-of
      select="replace(ahf:text(.), 'to be', 'to&nbsp;be')" />
</xsl:template>

<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[11]/p[2]/text()">
  <xsl:value-of
      select="replace(ahf:text(.), 'you feel', 'you&nbsp;feel')" />
</xsl:template>

<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[13]/p[5]">
  <fo:block word-spacing.minimum="0.03em"
            xsl:use-attribute-sets="p">
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<!-- 'I thought him...' (pg. 84) -->
<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[16]/p[54]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <xsl:next-match>
    <xsl:with-param name="atts" as="attribute()*">
      <xsl:attribute name="word-spacing.minimum" select="'0.01em'" />
      <xsl:sequence select="$atts" />
    </xsl:with-param>
  </xsl:next-match>
</xsl:template>

<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[81]/p[29]/text()">
  <xsl:value-of
      select="replace(ahf:text(.), 'of the thing', 'of&nbsp;the thing')" />
</xsl:template>

<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[96]/p[3]/text()">
  <xsl:value-of
      select="replace(ahf:text(.), 'the rear', 'the&nbsp;rear')" />
</xsl:template>

<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[107]/p[5]/text()">
  <xsl:value-of
      select="replace(ahf:text(.), 'by any', 'by&nbsp;any')" />
</xsl:template>

</xsl:stylesheet>
