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
                    <xsl:apply-templates />
                </div>
            </body>
        </html>
    </xsl:template>

    <!-- Template to match the root element -->
    <xsl:template match="catalog">
        <xsl:apply-templates select="monastery" />
    </xsl:template>
    <!-- Template to match monastery elements -->
    <xsl:template match="monastery">
        <div class="container">
            <h2>
                <xsl:value-of select="name" />
            </h2>
        </div>
    </xsl:template>
</xsl:stylesheet>