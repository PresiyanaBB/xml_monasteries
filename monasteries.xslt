<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" />

    <xsl:param name="sort-by" select="'name'" />
    <xsl:param name="data-type" select="'text'" />
    <xsl:param name="order" select="'ascending'" />

    <xsl:template match="/">
        <html>
            <head>
                <title>Monasteries</title>
                <link rel="stylesheet" type="text/css" href="monasteries.css" />
                <script src="monasteries.js" defer=""></script>
            </head>
            <body id="monasteries-container">
                <header>
                    <h1>Манастири</h1>
                </header>
                <div class="page-container">
                    <h3>Сортиране по:
                    </h3>
                </div>
                <div class="sort-buttons-container">
                    <button id="name-button">Име</button>
                    <button id="area-button">Площ</button>
                    <button id="properties-button">Брой имоти</button>
                    <button id="guest-rooms-button">Брой стаи за гости</button>
                </div>
                <div class="page-container">
                    <div class="container">
                        <xsl:apply-templates select="catalog/monasteries/monastery">
                            <xsl:sort select="*[name() = $sort-by]" data-type="{$data-type}"
                                order="{$order}" />
                        </xsl:apply-templates>
                    </div>
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
                <xsl:apply-templates select="picture" />
            </div>
            <div class="column">
                <xsl:apply-templates select="area-in-sq-meters" />
                <xsl:apply-templates select="properties-count" />
                <xsl:apply-templates select="rooms-for-guests" />
                <xsl:apply-templates select="monastery-region" />
                <ul>
                    <h4>Църкви:</h4>
                    <xsl:apply-templates select="monastery-churches" />
                </ul>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="monastery-churches">
        <xsl:for-each select="monastery-church">
            <li>
                <p>
                    <xsl:value-of
                        select="/catalog/churches/church[@id=current()/@church-id]/name" />
                </p>
            </li>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="monastery-region">
        <p> Намира се около: <xsl:value-of
                select="/catalog/regions/region[@id=current()/@region-id]/name" />
        </p>
    </xsl:template>

    <xsl:template match="picture">
        <img>
            <xsl:attribute name="src">
                <xsl:text>images/</xsl:text>
                <xsl:value-of select="@src" />
                <xsl:text>.jpg</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="alt">
                <xsl:value-of select="../name" />
            </xsl:attribute>
        </img>
    </xsl:template>


    <xsl:template match="area-in-sq-meters">
        <p>Площ: <xsl:value-of select="." /> кв.м.</p>
    </xsl:template>
    <xsl:template match="properties-count">
        <p>Брой имоти: <xsl:value-of select="." />
        </p>
    </xsl:template>
    <xsl:template match="rooms-for-guests">
        <p>Брой стаи за гости: <xsl:value-of select="." />
        </p>
    </xsl:template>
</xsl:stylesheet>