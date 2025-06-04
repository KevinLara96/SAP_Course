<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="xml" indent="yes" />

    <!-- Root Template -->
    <xsl:template match="/MT_Contacto">
        <agenda>
            <xsl:for-each select="Contactos/Contacto">
                <person>
                    <xsl:attribute name="id">
                        <xsl:value-of select="InformacionPersonal/id" />
                    </xsl:attribute>
                    <xsl:attribute name="alias">
                        <xsl:value-of select="InformacionPersonal/alias" />
                    </xsl:attribute>
                    <xsl:attribute name="email">
                        <xsl:value-of select="InformacionPersonal/CorreoElectronico" />
                    </xsl:attribute>
                    <xsl:attribute name="birthdate">
                        <xsl:value-of select="InformacionPersonal/FechaNacimiento" />
                    </xsl:attribute>

                    <full_name>
                        <xsl:value-of
                            select="concat(InformacionPersonal/Nombre, ' ', InformacionPersonal/Apellidos)" />
                    </full_name>

                    <!-- Phone List -->
                    <phone_list>
                        <xsl:for-each select="InformacionContacto/Telefonos/Telefono">
                            <item>
                                <xsl:attribute name="type">
                                    <xsl:value-of select="@tipo" />
                                </xsl:attribute>
                                <xsl:attribute name="number">
                                    <xsl:value-of select="." />
                                </xsl:attribute>
                            </item>
                        </xsl:for-each>
                    </phone_list>

                    <!-- Address List -->
                    <address_list>
                        <xsl:for-each select="InformacionContacto/Direcciones/Direccion">
                            <item>
                                <xsl:attribute name="type">
                                    <xsl:value-of select="@tipo" />
                                </xsl:attribute>
                                <xsl:value-of select="normalize-space(.)" />
                            </item>
                        </xsl:for-each>
                    </address_list>

                </person>
            </xsl:for-each>
        </agenda>
    </xsl:template>

</xsl:stylesheet>