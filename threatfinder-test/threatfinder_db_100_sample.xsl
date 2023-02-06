<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
  <html>
  <body>
    <h2>ThreatFinder DB 100 Sample</h2>
    <table border="1">
      <tr bgcolor="#9acd32">
        <th>Screenshot</th>
        <th>URL</th>
        <th>IP Address</th>
        <th>Alive</th>
        <th>Location</th>
        <th>Creation Time</th>


      </tr>
      <xsl:for-each select="data/tweet">
        <tr>
          <td>
          <a>
              <xsl:attribute name="src">
                 <xsl:value-of select="image-url"/>
            </xsl:attribute>
            <xsl:attribute name="target">
                 _blank
            </xsl:attribute >
  			<xsl:attribute name="title">
                 <xsl:value-of select="tweet-id"/></td>
            </xsl:attribute >
            <img>
                <xsl:attribute name="src">
                  <xsl:value-of select="image-url"/>
                </xsl:attribute>
                <xsl:attribute name="alt">
                 <xsl:value-of select="tweet-id"/></td>
                </xsl:attribute >
                <xsl:attribute name="width">
                 200
                </xsl:attribute >
              </img>
              </a>
            </td>
          <td><xsl:value-of select="url"/><br />
          Tweet ID: <xsl:value-of select="tweet-id"/></td>
          <td><xsl:value-of select="ip-address"/><br />
          <xsl:value-of select="registrar-name"/></td>
          <td><xsl:value-of select="url-alive"/></td>
          <td><xsl:value-of select="location"/><br /><xsl:value-of select="geo-coordinates"/></td>
          <td><xsl:value-of select="creation-time"/></td>

        </tr>
      </xsl:for-each>
    </table>
  </body>
  </html>
</xsl:template>

</xsl:stylesheet>