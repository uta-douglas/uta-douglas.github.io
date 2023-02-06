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
          <td><a href="<xsl:value-of select="image-url"/>" target="_blank"><img width="200" src="<xsl:value-of select="image-url"/>" alt="screenshot of <xsl:value-of select="tweet-id"/>"/></a></td>
        </tr>
      </xsl:for-each>
    </table>
  </body>
  </html>
</xsl:template>

</xsl:stylesheet>