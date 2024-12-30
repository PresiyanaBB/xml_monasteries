<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" />
    <xsl:template match="/">
        <html>
            <head>
                <title>Monasteries</title>
                <link rel="stylesheet" type="text/css" href="monasteries.css" />
            </head>
            <body>
                <div class="container">
                    <h1>List of Monasteries</h1>
                    <xsl:apply-templates select="catalog/monasteries/monastery" />
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="monastery">
        <div class="two-column-container">
            <div class="column">
                <h4>
                    <xsl:value-of select="name" />
                </h4>
            </div>
            <div class="column">
                <ul>
                    <h4>Църкви:</h4>
                    <xsl:for-each select="monastery-churches/monastery-church">
                        <li>
                            <p>
                                <xsl:value-of
                                    select="/catalog/churches/church[@id=current()/@church-id]/name" />
                            </p>
                        </li>
                    </xsl:for-each>
                </ul>
            </div>
        </div>
    </xsl:template>
</xsl:stylesheet>