<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text" encoding="UTF-8" />

<!--
OpenVAS Manager
$Id$
Description: Stylesheet for generating python code that creates a pie plot.

Authors:
Jan-Oliver Wagner <jan-oliver.wagner@greenbone.net>

Copyright:
Copyright (C) 2010 Greenbone Networks GmbH

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License version 2,
or, at your option, any later version as published by the Free
Software Foundation

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
-->

<xsl:template match="/">
from pychart import *

theme.use_color = True
theme.output_format="png"
theme.reinitialize()

data = [("High (<xsl:value-of select="count (report/results/result[threat='High'])"/>)",
         <xsl:value-of select="count (report/results/result[threat='High'])"/>),
        ("Medium (<xsl:value-of select="count (report/results/result[threat='Medium'])"/>)",
         <xsl:value-of select="count (report/results/result[threat='Medium'])"/>),
        ("Low (<xsl:value-of select="count (report/results/result[threat='Low'])"/>)",
         <xsl:value-of select="count (report/results/result[threat='Low'])"/>)]

ar = area.T(size=(<xsl:value-of select="report/report_format/param[name='Width']/value"/>,<xsl:value-of select="report/report_format/param[name='Height']/value"/>), legend=None,
            x_grid_style = None, y_grid_style = None)

# The "High" element is pulled out of the pie with offset=10
plot = pie_plot.T(data=data, arc_offsets=[10,0,0],
                  shadow = None, label_offset = 25,
                  fill_styles = [ fill_style.red, fill_style.yellow,
                                  fill_style.blue ],
                  arrow_style = arrow.a3)

ar.add_plot(plot)
ar.draw()
</xsl:template>

</xsl:stylesheet>
