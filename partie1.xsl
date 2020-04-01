<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

    <xsl:template match="countries">
        <html>
            <head>
                <title>Partie 1</title>
                <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
                      integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
                      crossorigin="anonymous"/>
            </head>
            <body>
                <div class="dropdown show">
                    <a class="btn btn-secondary dropdown-toggle" href="#country" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Nom
                    </a>
                    <a class="btn btn-secondary dropdown-toggle" href="#population" role="button" id="dropdownMenuLink2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Popu
                    </a>
                    <a class="btn btn-secondary dropdown-toggle" href="#area" role="button" id="dropdownMenuLink3" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Area
                    </a>

                    <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                            <a class="dropdown-item" href="#country">
                                <xsl:apply-templates select="country" mode="nav">
                                    <xsl:sort select="@country" order="descending"/>
                                </xsl:apply-templates>
                            </a>
                    </div>

                <div class="dropdown-menu" aria-labelledby="dropdownMenuLink2">
                    <a class="dropdown-item" href="#population">
                        <xsl:apply-templates select="country" mode="pop" id="population">
                            <xsl:sort select="@population" data-type="number"
                                      order="descending"/>
                        </xsl:apply-templates>
                    </a>
                </div>

                    <div class="dropdown-menu" aria-labelledby="dropdownMenuLink3">
                        <a class="dropdown-item" href="#area">
                            <xsl:apply-templates select="country" mode="area" id="area">
                                <xsl:sort select="@area" data-type="number"
                                          order="descending"/>
                            </xsl:apply-templates>
                        </a>
                    </div>

                </div>

<!--                <div id="navigation">
                    <div id="country">
                        <p>Pays</p>
                        <xsl:apply-templates mode="nav">
                            <xsl:sort select="@country" order="descending"/>
                        </xsl:apply-templates>
                    </div>
                    <div id="country">
                        <p>Population</p>
                        <xsl:apply-templates select="country" mode="pop">
                            <xsl:sort select="@population" data-type="number"
                                      order="descending"/>
                        </xsl:apply-templates>
                    </div>
                    <div id="country">
                        <p>Area</p>
                        <xsl:apply-templates select="country" mode="area">
                            <xsl:sort select="@area" data-type="number"
                                      order="descending"/>
                        </xsl:apply-templates>
                    </div>
                </div>-->

                <xsl:apply-templates select="country" mode="detail"/>

            </body>
            <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
                    integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
                    crossorigin="anonymous"/>
            <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
                    integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
                    crossorigin="anonymous"/>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
                    integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
                    crossorigin="anonymous"/>
        </html>
    </xsl:template>

    <!--  Nav  -->
    <xsl:template match="country" mode="nav">
        <xsl:if test="position() &lt;= 10">
            <li>
               <a href="#{@name}">
                   <xsl:value-of select="@name"/>
               </a>
            </li>
        </xsl:if>
    </xsl:template>

    <xsl:template match="country" mode="pop">
        <xsl:if test="position() &lt;= 10">
        <li>
            <a href="#{@name}">
                <b><xsl:value-of select="@name"/></b> :
                <xsl:value-of select="@population"/>
            </a>
        </li>
        </xsl:if>
    </xsl:template>

    <xsl:template match="country" mode="area">
        <xsl:if test="position() &lt;= 10">
            <li>
                <a href="#{@name}">
                    <b><xsl:value-of select="@name"/></b> :
                    <xsl:value-of select="@area"/>
                </a>
            </li>
        </xsl:if>
    </xsl:template>
    <!-- end Nav  -->

<!--  Card  -->
    <xsl:template match="country" mode="detail">
        <div class="card" style="width: 25rem;">
            <div class="card-body">
                <h3 class="card-title">Pays :  <xsl:value-of select="@name" /></h3>
                <table class="table">
                    <tr>
                        <th scope="col">Population</th>
                        <th scope="col">Superficie</th>
                    </tr>
                    <tr>
                        <td class="card-text">
                            <xsl:value-of select="@population"></xsl:value-of> habitants
                        </td>
                        <td class="card-text">
                            <xsl:value-of select="@area"></xsl:value-of> km2
                        </td>
                    </tr>
                </table>
                <br />
                <xsl:choose>
                    <xsl:when test="count(child::city) > 1">
                        <p>Villes :</p>
                        <xsl:apply-templates select="city" mode="ville"/>
                    </xsl:when>
                    <xsl:when test="count(child::city) = 1">
                        <p>Ville: </p>
                        <xsl:apply-templates select="city" mode="ville"/>
                    </xsl:when>
                </xsl:choose>
            </div>
            <br />
        </div>
        <br />
    </xsl:template>

    <xsl:template match="city" mode="ville">
        <li>
            <xsl:value-of select="name" />:
            <xsl:value-of select="population"/> personnes
            <br />
           <p style="font-size: 10px;">
               soit environ <b>
               <xsl:value-of select="round((population div ancestor::country/@population)* 100)"/> % </b>de la population totale du pays
           </p>
        </li>
    </xsl:template>


</xsl:stylesheet>



<!--
<xsl:apply-templates
select="country[city][position()&lt; 10]">
<xsl:sort select="@name" order="ascending" /> &lt;!&ndash; //descending &ndash;&gt;
</xsl:apply-templates>-->
