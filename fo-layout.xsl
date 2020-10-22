<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:axf="http://www.antennahouse.com/names/XSL/Extensions"
    xmlns:xhtml="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="axf xhtml xs"
    version="2.0">

<!-- 'Moby-Dick' first edition. -->

<!-- Page dimensions are in inches because 1850 in the USA was
     pre-metric. -->

<!-- Using page size of 7 3/8 x 4.8 inches after using scanned page as
     background in AH Formatter and adjusting sizes until page lined
     up with scan.
-->

<xsl:param name="page-height" select="7.375"/>
<xsl:param name="page-width" select="4.78"/>

<xsl:param name="text-block-width" select="3.125"/>

<xsl:param name="body-inside"
           select="$page-width - $text-block-width - $body-outside"/>
<xsl:param name="body-outside" select="0.905"/>
<xsl:param name="body-before" select="0.875"/>
<xsl:param name="body-after" select="1"/>

<xsl:param name="after-extent" select="$body-after"/>
<xsl:param name="before-extent" select="$body-before"/>
<xsl:param name="inside-extent" select="$body-inside"/>
<xsl:param name="outside-extent" select="$body-outside"/>

<xsl:template name="layout-master-set">
  <fo:layout-master-set>
    <fo:simple-page-master master-name="First-PageMaster"
                           page-height="{$page-height}in"
                           page-width="{$page-width}in">
      <fo:region-body
          margin-top="{$body-before}in"
          margin-bottom="{$body-after}in"
          margin-right="{$body-outside}in"
          margin-left="{$body-inside}in"/>
      <fo:region-before
          extent="{$before-extent}in"
          display-align="after"
          precedence="true"
          region-name="First-Header"/>
      <fo:region-after
          extent="{$after-extent}in"
          display-align="before"
          region-name="First-Footer"/>
      <fo:region-start
          reference-orientation="270"
          extent="{$inside-extent}in"/>
      <fo:region-end
          region-name="First-Outside"
          reference-orientation="180"
          extent="{$outside-extent}in"/>
    </fo:simple-page-master>
    <fo:simple-page-master master-name="Odd-PageMaster"
                           page-height="{$page-height}in"
                           page-width="{$page-width}in">
      <fo:region-body
          margin-top="{$body-before}in"
          margin-bottom="{$body-after}in"
          margin-right="{$body-outside}in"
          margin-left="{$body-inside}in" />
      <fo:region-before
          extent="{$before-extent}in"
          display-align="after"
          region-name="Odd-Header"/>
      <fo:region-after
          extent="{$after-extent}in"
          display-align="before"
          region-name="Odd-Footer"/>
      <fo:region-start
          reference-orientation="270"
          extent="{$inside-extent}in"/>
      <fo:region-end
          region-name="Odd-Outside"
          reference-orientation="180"
          extent="{$outside-extent}in"/>
    </fo:simple-page-master>
    <fo:simple-page-master master-name="Even-PageMaster"
                           page-height="{$page-height}in"
                           page-width="{$page-width}in">
      <fo:region-body
          margin-top="{$body-before}in"
          margin-bottom="{$body-after}in"
          margin-right="{$body-inside}in"
          margin-left="{$body-outside}in" />
      <fo:region-before
          extent="{$before-extent}in"
          display-align="after"
          region-name="Even-Header"/>
      <fo:region-after
          region-name="Even-Footer"
          extent="{$after-extent}in"
          display-align="before"/>
      <fo:region-start
          extent="{$outside-extent}in"/>
      <fo:region-end
          extent="{$inside-extent}in"/>
    </fo:simple-page-master>
    <fo:simple-page-master master-name="PageMaster-CoverFront"
                           page-height="{$page-height}in"
                           page-width="{$page-width}in">
      <fo:region-body
          margin-top="{$body-before}in"
          margin-bottom="{$body-after}in"
          margin-right="{$body-inside}in"
          margin-left="{$body-outside}in" />
    </fo:simple-page-master>
    <fo:simple-page-master master-name="Front-Odd-PageMaster"
                           page-height="{$page-height}in"
                           page-width="{$page-width}in">
      <fo:region-body
          margin-top="{$body-before}in"
          margin-bottom="{$body-after}in"
          margin-right="{$body-outside}in"
          margin-left="{$body-inside}in" />
      <fo:region-before
          extent="{$before-extent}in"
          display-align="after"
          region-name="Odd-Header"/>
      <fo:region-after
          extent="{$after-extent}in"
          display-align="before"
          region-name="Odd-Footer"/>
      <fo:region-start
          reference-orientation="270"
          extent="{$inside-extent}in"/>
      <fo:region-end
          region-name="Odd-Outside"
          reference-orientation="180"
          extent="{$outside-extent}in"/>
    </fo:simple-page-master>
    <fo:simple-page-master master-name="Front-Even-PageMaster"
                           page-height="{$page-height}in"
                           page-width="{$page-width}in">
      <fo:region-body
          margin-top="{$body-before}in"
          margin-bottom="{$body-after}in"
          margin-right="{$body-inside}in"
          margin-left="{$body-outside}in" />
      <fo:region-before
          extent="{$before-extent}in"
          display-align="after"
          region-name="Even-Header"/>
      <fo:region-after
          region-name="Even-Footer"
          extent="{$after-extent}in"
          display-align="before"/>
      <fo:region-start
          extent="{$outside-extent}in"/>
      <fo:region-end
          extent="{$inside-extent}in"/>
    </fo:simple-page-master>
    <fo:simple-page-master master-name="PageMaster-Cover"
                           margin-top="15mm"
                           margin-bottom="15mm"
                           margin-right="5mm"
                           margin-left="10mm"
                           page-height="{$page-height}in"
                           page-width="{$page-width}in">
      <fo:region-body
          margin-top="{$body-before}in"
          margin-bottom="{$body-after}in"
          margin-right="{$body-inside}in"
          margin-left="{$body-outside}in" />
      <fo:region-before
          extent="{$before-extent}in"
          display-align="after"
          region-name="Even-Header"/>
      <fo:region-after
          region-name="Even-Footer"
          extent="{$after-extent}in"
          display-align="before"/>
      <fo:region-start
          extent="{$outside-extent}in"/>
      <fo:region-end
          extent="{$inside-extent}in"/>
    </fo:simple-page-master>
    <fo:simple-page-master master-name="PageMaster-CoverBlank"
                           margin-top="15mm"
                           margin-bottom="15mm"
                           margin-right="5mm"
                           margin-left="10mm"
                           page-height="{$page-height}in"
                           page-width="{$page-width}in">
      <fo:region-body
          margin-top="{$body-before}in"
          margin-bottom="{$body-after}in"
          margin-right="{$body-inside}in"
          margin-left="{$body-outside}in" />
    </fo:simple-page-master>
    <fo:page-sequence-master master-name="CoverFrontMaster">
      <fo:repeatable-page-master-alternatives>
        <!--<fo:conditional-page-master-reference
            master-reference="PageMaster-CoverFront"
            page-position="first" />-->
        <fo:conditional-page-master-reference
            master-reference="Front-Odd-PageMaster"
            odd-or-even="odd" />
        <fo:conditional-page-master-reference
            master-reference="Front-Even-PageMaster"
            odd-or-even="even" />
      </fo:repeatable-page-master-alternatives>
    </fo:page-sequence-master>
    <fo:page-sequence-master master-name="ExtractsMaster">
      <fo:single-page-master-reference
            master-reference="PageMaster-CoverFront" />
      <fo:repeatable-page-master-alternatives>
        <fo:conditional-page-master-reference
            master-reference="PageMaster-CoverFront"
            blank-or-not-blank="blank" />
        <fo:conditional-page-master-reference
            master-reference="Front-Odd-PageMaster"
            odd-or-even="odd" />
        <fo:conditional-page-master-reference
            master-reference="Front-Even-PageMaster"
            odd-or-even="even" />
      </fo:repeatable-page-master-alternatives>
    </fo:page-sequence-master>
    <fo:page-sequence-master master-name="PageMaster">
      <fo:repeatable-page-master-alternatives>
        <fo:conditional-page-master-reference
            master-reference="First-PageMaster"
            page-position="first" />
        <fo:conditional-page-master-reference
            master-reference="Odd-PageMaster"
            odd-or-even="odd" />
        <fo:conditional-page-master-reference
            master-reference="Even-PageMaster"
            odd-or-even="even" />
      </fo:repeatable-page-master-alternatives>
    </fo:page-sequence-master>
    <fo:page-sequence-master master-name="MobyDickPageMaster">
      <fo:repeatable-page-master-alternatives>
        <fo:conditional-page-master-reference
            master-reference="First-PageMaster"
            page-position="first" />
        <fo:conditional-page-master-reference
            master-reference="Odd-PageMaster"
            odd-or-even="odd" />
        <fo:conditional-page-master-reference
            master-reference="Even-PageMaster"
            odd-or-even="even" />
      </fo:repeatable-page-master-alternatives>
    </fo:page-sequence-master>
  </fo:layout-master-set>
</xsl:template>

<xsl:template name="footer-leader">
  <fo:leader
      leader-length.optimum="80%"
      leader-length.maximum="100%"/>
</xsl:template>

<xsl:template name="PageMaster-static-content">
  <fo:static-content flow-name="Even-Header">
    <xsl:call-template name="Even-Header" />
  </fo:static-content>
  <fo:static-content flow-name="First-Outside">
    <xsl:call-template name="First-Outside" />
  </fo:static-content>
  <fo:static-content flow-name="Odd-Outside">
    <xsl:call-template name="Odd-Outside" />
  </fo:static-content>
  <fo:static-content flow-name="Odd-Header">
    <xsl:call-template name="Odd-Header" />
  </fo:static-content>
  <fo:static-content flow-name="Even-Footer">
    <xsl:call-template name="Even-Footer" />
  </fo:static-content>
  <fo:static-content flow-name="First-Footer">
    <xsl:call-template name="First-Footer" />
  </fo:static-content>
  <fo:static-content flow-name="Odd-Footer">
    <xsl:call-template name="Odd-Footer" />
  </fo:static-content>
  <fo:static-content flow-name="xsl-footnote-separator">
    <xsl:call-template name="xsl-footnote-separator" />
  </fo:static-content>
</xsl:template>

<xsl:template name="Extracts-static-content">
  <fo:static-content flow-name="Even-Header">
    <xsl:call-template name="Even-Header" />
  </fo:static-content>
  <fo:static-content flow-name="Odd-Outside">
    <xsl:call-template name="Odd-Outside" />
  </fo:static-content>
  <fo:static-content flow-name="Odd-Header">
    <xsl:call-template name="Odd-Header" />
  </fo:static-content>
  <fo:static-content flow-name="Even-Footer">
    <xsl:call-template name="Even-Footer" />
  </fo:static-content>
  <fo:static-content flow-name="xsl-footnote-separator">
    <xsl:call-template name="xsl-footnote-separator" />
  </fo:static-content>
</xsl:template>

<xsl:template name="First-Footer">
  <fo:block
      keep-together.within-line="always"
      text-align="center"
      font-size="small">
    <fo:page-number/>
  </fo:block>
</xsl:template>

<xsl:template name="First-Outside" />

<xsl:template name="Odd-Footer" />

<xsl:template name="Odd-Outside" />

<xsl:template name="Even-Footer" />

<xsl:template name="Odd-Header">
  <fo:block
      keep-together.within-line="always"
      text-align="center"
      font-size="small"
      border-bottom="1pt solid black"
      axf:leader-expansion="force"
      padding-bottom="4pt"
      margin-bottom="4pt">
    <fo:page-number color="transparent"/>
    <fo:leader />
    <fo:inline letter-spacing="0.1em">
      <fo:retrieve-marker
          retrieve-class-name="Chapter-Title"
          retrieve-position="first-starting-within-page" />
    </fo:inline>
    <fo:leader />
    <fo:page-number />
  </fo:block>
</xsl:template>

<xsl:template name="Even-Header">
  <fo:block
      keep-together.within-line="always"
      font-size="small"
      border-bottom="1pt solid black"
      axf:leader-expansion="force"
      padding-bottom="4pt"
      margin-bottom="4pt">
    <fo:page-number />
    <fo:leader />
    <fo:inline letter-spacing="0.2em">
      <fo:retrieve-marker
          retrieve-class-name="Chapter-Title"
          retrieve-position="first-starting-within-page" />
    </fo:inline>
    <fo:leader />
    <fo:page-number color="transparent" />
  </fo:block>
</xsl:template>

<xsl:template name="xsl-footnote-separator">
  <fo:block>
    <fo:leader/>
  </fo:block>
</xsl:template>

</xsl:stylesheet>
