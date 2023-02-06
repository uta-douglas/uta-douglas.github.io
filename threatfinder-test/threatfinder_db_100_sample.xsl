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
        <th>URL is alive</th>
        <th>Geo co-ordinates</th>
        <th>Location</th>
        <th>Creation Time</th>
        <th>Image URL</th>

      </tr>
      <xsl:for-each select="data/tweet">
        <tr>
          <td><xsl:value-of select="tweet_id"/></td>
          <td><xsl:value-of select="url"/></td>
          <td><xsl:value-of select="registrar_name"/></td>
          <td><xsl:value-of select="ip_address"/></td>
          <td><xsl:value-of select="url-alive"/></td>
          <td><xsl:value-of select="geo-coordinates"/></td>
          <td><xsl:value-of select="location"/></td>
          <td><xsl:value-of select="creation_time"/></td>
          <td><xsl:value-of select="image_url"/></td>
        </tr>
      </xsl:for-each>
    </table>
  </body>
  </html>
</xsl:template>

</xsl:stylesheet>