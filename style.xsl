<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
  <html lang="ru">
  <head>
    <style>
      body{
        padding:0;
        margin:0;
      }
      .wrapper{
        width:800px;
        margin:20px auto;
      }
      table{
        width:100%;
        margin-bottom:10px;
        border-collapse: collapse;
      }
      table th,
      table td{
        border: 1px solid #ccc;
        padding:2px 5px;
      }
      table td{
        width:50%;
      }
      table th{
        background:#eee;
      }
    </style>
    <!-- Стили в коде что бы не плодить много файлов в тестовом задании -->
  </head>  
  <body>
    <div class="wrapper">
      <xsl:apply-templates/>    
    </div>
  </body>
  </html>
</xsl:template>
<xsl:template match="items/*">
   <table>
     <xsl:apply-templates select="property"/>
   </table>
</xsl:template>
<xsl:template match="property[@title = 'Эмитент']">
   <tr>
       <th colspan="2"><xsl:value-of select="@title"/><xsl:text>: </xsl:text><xsl:value-of select="."/></th>
   </tr>
</xsl:template>
<xsl:template match="property">
   <tr>
       <td><xsl:value-of select="@title"/><xsl:text>:</xsl:text></td>
       <td><xsl:value-of select="."/></td>
   </tr>
</xsl:template>
</xsl:stylesheet>