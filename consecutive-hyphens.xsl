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

<xsl:import href="line-start-end.xsl"/>


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
      Phædon
    </axh:exceptions>
  </axf:hyphenation-info>
</xsl:template>

<xsl:template match="/TEI/text[1]/body[1]/div[1]/div[62]/p[2]">
  <xsl:param name="atts" select="()" as="attribute()*" />

  <fo:block axf:hyphenate-hyphenated-word="false"
            xsl:use-attribute-sets="p">
    <xsl:copy-of select="$atts" />
    <xsl:apply-templates />
  </fo:block>
</xsl:template>

<xsl:template
    match="/TEI/text[1]/body[1]/div[1]/div[133]/note[1]/p[1]/text()">
  <xsl:analyze-string
      select="ahf:text(.)"
      regex="comprehensively">
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

</xsl:stylesheet>
