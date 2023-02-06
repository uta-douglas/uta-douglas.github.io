<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
  <html>
  <body>
    <h2>ThreatFinder DB 100 Sample</h2>
    <table border="1">
      <tr bgcolor="#9acd32">
        <th>Tweet ID</th>
        <th>URL</th>
        <th>Registrar Name</th>
        <th>IP Address</th>
        <th>Alive</th>
        <th>Location</th>
        <th>Creation Time</th>
        <th>Image URL</th>

      </tr>
      <xsl:for-each select="data/tweet">
        <tr>
          <td><xsl:value-of select="tweet-id"/></td>
          <td><xsl:value-of select="url"/></td>
          <td><xsl:value-of select="registrar-name"/></td>
          <td><xsl:value-of select="ip-address"/></td>
          <td><xsl:value-of select="url-alive"/></td>
          <td><xsl:value-of select="location"/><br /><xsl:value-of select="geo-coordinates"/></td>
          <td><xsl:value-of select="creation-time"/></td>
          <td><img>
                <xsl:attribute name="src">
                  <xsl:value-of select="image-url"/>
                </xsl:attribute>
                <xsl:attribute name="width">
                 200
                </xsl:attribute >
              </img>
            </td>
        </tr>
      </xsl:for-each>
    </table>
  </body>
  </html>
</xsl:template>

</xsl:stylesheet>