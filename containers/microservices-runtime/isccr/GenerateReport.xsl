<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions">
	<xsl:output method="html" omit-xml-declaration="yes" indent="yes"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>Continuous Code Review Report</title>
				<style>
.linesLev1 {
    font-size: 20pt;
}

.linesLev2 {
    font-size: 16pt;
}
#complexityLegend {
    float: left;
    left: 550px;
    position: relative;
    top: 40px;
}

#statusHeader {
    display: block;
    font-weight: bold;
    left: 140px;
    position: relative;
    top: 10px;
}

#breakdownHeader {
    display: block;
    font-weight: bold;
    left: 650px;
    position: relative;
    top: -5px;
}
				
#breakdownChart {
    left: 150px;
    position: relative;
}

#statusChartLegend {
    left: 200px;
    position: relative;
    top: 10px;
}

#breakdownChartLegend {
    left: 690px;
    margin-top: 20px;
    position: relative;
    top: -103px;
}


h1 {
    color: #0899CC;
    font-size: 26pt;
}		

.sub
{
    color: #000000;
    font-size: 32pt;
    position: relative;
    top: -25px;
    text-transform: uppercase;
}		

h2 {
    color: #0899CC;
    font-size: 14pt;
    text-transform: uppercase;
}

h3 {
    font-size: 12pt;
    font-weight: bolder;
}


p {
    font-size: 10pt;
    font-weight: normal;
}

a:link {
    color: #000000;
    text-decoration: none;
}

a:visited {
    color: #000000;
    text-decoration: none;

}

a:hover {
    color: #000000;
    text-decoration: underline;
}

a:active {
    color: #000000;
    text-decoration: none;
}

a.white:link {
    color: #FFFFFF;
    text-decoration: none;
}

a.white:visited {
    color: #FFFFFF;
    text-decoration: none;

}

a.white:hover {
    color: #FFFFFF;
    text-decoration: underline;
}

a.white:active {
    color: #FFFFFF;
    text-decoration: none;
}
				

tr > td:first-child {
    background-color: #a6a6a6;
    color: white;
}

.trshade {
background-color: #f2f2f2;
}

				
BODY
{
	font-family:Arial;
	font-size: 10pt;
}

.ragStatus{
width:100%;
}

.RAGGREEN
{
	width:40px;
	border-radius: 27px;
	height: 40px;
	font-size:24pt;
	border: 4px solid #008800;
	background-color: #00ff00;
	outline: none;
	color:#004400;
	text-align: center;
	line-height: 50px;
}

.RAGRED
{
	width:40px;
	border-radius: 27px;
	height: 40px;
	font-size:24pt;
	border: 4px solid #880000;
	background-color: #ff0000;
	outline: none;
	color:#440000;
	text-align: center;
	line-height: 50px;
}

.RAGAMBER
{
	width:40px;
	border-radius: 27px;
	height: 40px;
	font-size:24pt;
	border: 4px solid #9E3F00;
	background-color: #FF6A00;
	outline: none;
	color:#440000;
	text-align: center;
	line-height: 50px;
}

.RAGREDTEXT
{
	color: #880000;
    left: 50px;
    position: relative;
    top: -5px;
}

.RAGAMBERTEXT
{
	color: #9E3F00;
    left: 50px;
    position: relative;
    top: -5px;
}

.RAGGREENTEXT
{
	color: #008800;
    left: 50px;
    position: relative;
    top: -5px;
}

.RED{
	background-color:red;
	color:white;
	width:100%;
	border: 3px solid #aa0000;
}

.GREEN{
	background-color:green;
	color:white;
	width:100%;
	border: 3px solid #00aa00;
}

.AMBER{
	border: 3px solid #9E3F00;
	background-color: #FF6A00;
	color:white;
	width:100%;
}

.check
{
	margin-bottom: 50px;
}

table, td, th {
    border: 1px solid #FFFFFF;
    border-spacing: 0;
    border-collapse: collapse;
    margin-bottom:20px;
}

table {
margin-bottom: 20px;
}

th {
    background-color: #0085ad;
    color: white;
    padding-bottom: 5px;
    padding-left: 10px;
    text-align: left;
	font-size:10pt;
	padding-right:10px;
}				

TD
{
	padding-bottom: 5px;
    padding-left: 10px;
	text-align: left;
	font-size:10pt;
	padding-right:10px;
}
	
				
.checkItem
{
	background-color: #dddddd;
	box-shadow: 8px 8px 5px #222222;
	border: 1px solid #111111;
	border-radius: 25px;
	padding-top: 10px;
	padding-left: 20px;
	padding-right: 20px; 		
	margin-bottom: 20px;		
}
				
.fullwidth
{
	width: 100%;
}

@media all {
	.page-break	{ display: none; }
}

@media print {
	.page-break	{ display: block; page-break-before: always; }
}


.summaryBar {
	width: 90%;
	border: 0px solid;
	padding: 0px;
	spacing: 0px;
	height: 15px;
}

.summaryBarPct {
	width: 90%;
	border: 1px #FFFFFF solid;
	padding: 0px;
	spacing: 0px;
	height: 15px;
}

.summaryBarNos {
	width: 98%;
	border: 1px #FFFFFF solid;
	padding: 0px;
	spacing: 0px;
	height: 15px;
}

.greenBar
{
		background-color: #00FF00 !important;
}

.yellowBar
{
		background-color: #FF6A00; ! important;
}

.redBar
{
		background-color: #FF0000 !important;
}

</style>
				<xsl:variable name="col1">#F7464A</xsl:variable>
				<xsl:variable name="col2">#46BFBD</xsl:variable>
				<xsl:variable name="col3">#FDB45C</xsl:variable>
				<xsl:variable name="col4">#949FB1</xsl:variable>
				<xsl:variable name="col5">#4D5360</xsl:variable>
				<xsl:variable name="col6">#FF0000</xsl:variable>
				<xsl:variable name="col7">#00FF00</xsl:variable>
				<xsl:variable name="col8">#0000FF</xsl:variable>
				<xsl:variable name="col9">#AA00AA</xsl:variable>
				<xsl:variable name="col10">#44FF44</xsl:variable>
				<xsl:variable name="col11">#AAAA00</xsl:variable>
				<xsl:variable name="col12">#00AAAA</xsl:variable>
				<xsl:variable name="col13">#AA9999</xsl:variable>
				<xsl:variable name="col14">#CCBBBB</xsl:variable>
				<xsl:variable name="col15">#AAAA88</xsl:variable>
				<xsl:variable name="col16">#FFaa22</xsl:variable>
				
				
				<script language="javascript">
					<xsl:text>
function doOnload()
{

var complexitySummary =
{

    labels: ["Very Simple", "Simple", "Average", "Complex", "Very Complex"],
    datasets: [
        {
            label: "flow complexity summary",
            //fillColor: "rgba(151,187,205,0.5)",
            fillColor: "rgba(247,70,74,0.5)",
            strokeColor: "rgba(247,70,74,1)",
            pointColor: "rgba(247,70,74,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(151,187,205,1)",
            data: [
</xsl:text>
					<xsl:value-of select="count(//sensor[definition/@sensorName='CodeLines']/results[@name='complexityFactor-flow' and @value=1]/@value)"/>,
<xsl:value-of select="count(//sensor[definition/@sensorName='CodeLines']/results[@name='complexityFactor-flow' and @value=2]/@value)"/>,
<xsl:value-of select="count(//sensor[definition/@sensorName='CodeLines']/results[@name='complexityFactor-flow' and @value=3]/@value)"/>,
<xsl:value-of select="count(//sensor[definition/@sensorName='CodeLines']/results[@name='complexityFactor-flow' and @value=4]/@value)"/>,
<xsl:value-of select="count(//sensor[definition/@sensorName='CodeLines']/results[@name='complexityFactor-flow' and @value=5]/@value)"/>
					<xsl:text>            
            ]
        },
        {
            label: "Java complexity summary",
			fillColor: "rgba(070,191,189,0.5)",
			strokeColor: "rgba(070,191,189,1)",
			pointColor: "rgba(070,191,189,1)",
			pointStrokeColor: "#fff",
			pointHighlightFill: "#fff",
			pointHighlightStroke: "rgba(220,220,220,1)",
            data: [
</xsl:text>
					<xsl:value-of select="count(//sensor[definition/@sensorName='CodeLines']/results[@name='complexityFactor-java' and @value=1]/@value)"/>,
<xsl:value-of select="count(//sensor[definition/@sensorName='CodeLines']/results[@name='complexityFactor-java' and @value=2]/@value)"/>,
<xsl:value-of select="count(//sensor[definition/@sensorName='CodeLines']/results[@name='complexityFactor-java' and @value=3]/@value)"/>,
<xsl:value-of select="count(//sensor[definition/@sensorName='CodeLines']/results[@name='complexityFactor-java' and @value=4]/@value)"/>,
<xsl:value-of select="count(//sensor[definition/@sensorName='CodeLines']/results[@name='complexityFactor-java' and @value=5]/@value)"/>
					<xsl:text>            
            ]
        

        }
    ]
    
};

/*
var complexityData =  {
</xsl:text>
labels: [<xsl:for-each select="//sensor[definition/@sensorName='CodeLines']/results[starts-with(@name,'complexityFactor')]">
						<xsl:text>"</xsl:text>
						<xsl:value-of select="@item"/>
						<xsl:text>"</xsl:text>
						<xsl:if test="position()!=last()">,</xsl:if>
					</xsl:for-each>
					<xsl:text>],
    datasets: [
        {
            label: "ComplexityFactor",
            fillColor: "rgba(151,187,205,0.5)",
            strokeColor: "rgba(151,187,205,0.8)",
            highlightFill: "rgba(151,187,205,0.75)",
            highlightStroke: "rgba(151,187,205,1)",
            data: [</xsl:text>
					<xsl:for-each select="//sensor[definition/@sensorName='CodeLines']/results[starts-with(@name,'complexityFactor')]">
						<xsl:value-of select="@value"/>
						<xsl:if test="position()!=last()">,</xsl:if>
					</xsl:for-each>
					<xsl:text>]
        }
    ]
};
*/

var data2 = [
</xsl:text>
					<xsl:for-each select="//sensors/sensor[definition/@sensorName='totals']/results[not(starts-with(@name,'Total')) and not(starts-with(@name,'overall')) and not(@name='Folders')]">
						<xsl:text>
{
value:</xsl:text>
						<xsl:value-of select="@value"/>
						<xsl:text>,
        color:"</xsl:text>
						<xsl:if test="position()=1">
							<xsl:value-of select="$col1"/>
						</xsl:if>
						<xsl:if test="position()=2">
							<xsl:value-of select="$col2"/>
						</xsl:if>
						<xsl:if test="position()=3">
							<xsl:value-of select="$col3"/>
						</xsl:if>
						<xsl:if test="position()=4">
							<xsl:value-of select="$col4"/>
						</xsl:if>
						<xsl:if test="position()=5">
							<xsl:value-of select="$col5"/>
						</xsl:if>
						<xsl:if test="position()=6">
							<xsl:value-of select="$col6"/>
						</xsl:if>
						<xsl:if test="position()=7">
							<xsl:value-of select="$col7"/>
						</xsl:if>
						<xsl:if test="position()=8">
							<xsl:value-of select="$col8"/>
						</xsl:if>
						<xsl:if test="position()=9">
							<xsl:value-of select="$col9"/>
						</xsl:if>
						<xsl:if test="position()=10">
							<xsl:value-of select="$col10"/>
						</xsl:if>
						<xsl:if test="position()=11">
							<xsl:value-of select="$col11"/>
						</xsl:if>
						<xsl:if test="position()=12">
							<xsl:value-of select="$col12"/>
						</xsl:if>
						<xsl:if test="position()=13">
							<xsl:value-of select="$col13"/>
						</xsl:if>
						<xsl:if test="position()=14">
							<xsl:value-of select="$col14"/>
						</xsl:if>
						<xsl:if test="position()=15">
							<xsl:value-of select="$col15"/>
						</xsl:if>
						<xsl:if test="position()=16">
							<xsl:value-of select="$col16"/>
						</xsl:if>
						<xsl:text>",
        highlight: "#FF0000",
        label: "</xsl:text>
						<xsl:value-of select="@name"/>
						<xsl:text>"
},
</xsl:text>
					</xsl:for-each>
					<xsl:text>
];
<![CDATA[
		var statusData = [
				{
					value: ]]></xsl:text>
					<xsl:value-of select="//sensors/sensor[definition/@sensorName='totals']/results[@name='TotalFailed']/@value"/>
					<xsl:text><![CDATA[,
					color:"#FF0000",
					highlight: "#FF5A5E",
					label: "Failed"
				},
				{
					value: ]]></xsl:text>
					<xsl:value-of select="//sensors/sensor[definition/@sensorName='totals']/results[@name='TotalPassed']/@value"/>
					<xsl:text><![CDATA[,
					color: "#00FF00",
					highlight: "#99FF99",
					label: "Passed"
				},
				{
					value: ]]></xsl:text>
					<xsl:value-of select="//sensors/sensor[definition/@sensorName='totals']/results[@name='TotalWarning']/@value"/>
					<xsl:text><![CDATA[,
					color: "#FF6A00",
					highlight: "#FFC870",
					label: "Warnings"
				}

			];
]]></xsl:text>

<xsl:text>
<![CDATA[
		var statusData = [
				{
					value: ]]></xsl:text>
					<xsl:value-of select="//sensors/sensor[definition/@sensorName='totals']/results[@name='TotalFailed']/@value"/>
					<xsl:text><![CDATA[,
					color:"#FF0000",
					highlight: "#FF5A5E",
					label: "Failed"
				},
				{
					value: ]]></xsl:text>
					<xsl:value-of select="//sensors/sensor[definition/@sensorName='totals']/results[@name='TotalPassed']/@value"/>
					<xsl:text><![CDATA[,
					color: "#00FF00",
					highlight: "#99FF99",
					label: "Passed"
				},
				{
					value: ]]></xsl:text>
					<xsl:value-of select="//sensors/sensor[definition/@sensorName='totals']/results[@name='TotalWarning']/@value"/>
					<xsl:text><![CDATA[,
					color: "#FF6A00",
					highlight: "#FFC870",
					label: "Warnings"
				}

			];
]]>


<![CDATA[
		var Data = [
				{
					value: ]]></xsl:text>
					<xsl:value-of select="//sensors/sensor[definition/@sensorName='totals']/results[@name='TotalFailed']/@value"/>
					<xsl:text><![CDATA[,
					color:"#FF0000",
					highlight: "#FF5A5E",
					label: "Failed"
				},
				{
					value: ]]></xsl:text>
					<xsl:value-of select="//sensors/sensor[definition/@sensorName='totals']/results[@name='TotalPassed']/@value"/>
					<xsl:text><![CDATA[,
					color: "#00FF00",
					highlight: "#99FF99",
					label: "Passed"
				},
				{
					value: ]]></xsl:text>
					<xsl:value-of select="//sensors/sensor[definition/@sensorName='totals']/results[@name='TotalWarning']/@value"/>
					<xsl:text><![CDATA[,
					color: "#FF6A00",
					highlight: "#FFC870",
					label: "Warnings"
				}

			];
]]>


</xsl:text>

					<xsl:text>


		var ctx = document.getElementById("chart-area").getContext("2d");
		window.myPie = new Chart(ctx).Doughnut(data2);

		//var ctx2 = document.getElementById("complexity-chart-area").getContext("2d");
		//myBarChart = new Chart(ctx2).Bar(complexityData);	
		
		var ctx3 = document.getElementById("complexity-chart-summary").getContext("2d");
		myRadar = new Chart(ctx3).Radar(complexitySummary, {
		pointDot: true,scaleShowLabels: false});	
		
		var ctx4 = document.getElementById("status-chart-area").getContext("2d");
		myDoughnut = new Chart(ctx4).Doughnut(statusData);
		
		var treedata;
}</xsl:text>
				</script>
				<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
				<xsl:comment>ISCCR.IMPORT(Chart.js)</xsl:comment>
				
				 <script type="text/javascript">
<![CDATA[
      google.charts.load('current', {'packages':['treemap']});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
        treedata = google.visualization.arrayToDataTable([

          ['Service',   'Parent',        'Size',                    'Complexity'],
          ['Services',   null,                0,                               0],
]]>
<xsl:for-each select="//sensor[definition/@sensorName='CodeLines']/results[starts-with(@name,'complexityFactor')]">
<xsl:variable name="serviceOn"><xsl:value-of select="@item"/></xsl:variable>
<xsl:text>['</xsl:text><xsl:value-of select="@item"/>
<xsl:text>','Services',</xsl:text>
<xsl:value-of select="//sensor[definition/@sensorName='CodeLines']/results[@name='totalLines' and @item=$serviceOn]/@value"/>
<xsl:text>,</xsl:text>
<xsl:value-of select="@value"/>
<xsl:text>]</xsl:text>
<xsl:if test="position() != last()"><xsl:text>,</xsl:text>
</xsl:if>

</xsl:for-each>
        ]);

        tree = new google.visualization.TreeMap(document.getElementById('chart_div'));

        tree.draw(treedata, {
          minColor: '#0d0',
          midColor: '#ddd',
          maxColor: '#f00',
          headerHeight: 15,
          fontColor: 'black',
          showScale: true,
          generateTooltip: showFullTooltip
        });

      }
<xsl:text>
<![CDATA[
  function showFullTooltip(row, size, value) {
    return '<div style="background:#fd9; padding:10px; border-style:solid">' +
           '<span style="font-family:Courier"><b>' + treedata.getValue(row, 0) +
           '</b>, ' + treedata.getValue(row, 1) + ', ' + treedata.getValue(row, 2) +
           ', ' + treedata.getValue(row, 3) + '</span><br>' +
           'Datatable row: ' + row + '<br>' +
	   treedata.getColumnLabel(2) +
           ' (total value of this cell and its children): ' + size + '<br>' +
	   treedata.getColumnLabel(3) + ': ' + value + ' </div>';
  }
]]></xsl:text>
    </script>
				
				
			</head>
			<body onload="doOnload();">
				<img src="data:image/png;base64,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" alt="logo"/>
				<h1>
					<xsl:value-of select="/CodeCheckConfiguration/properties/packageName"/>
				</h1>
				<div class="sub">Code Review Report</div>
				<div class="date">
					<xsl:value-of select="/CodeCheckConfiguration/properties/date"/>
				</div>
				<div class="page-break"/>
				<br/>
				<h2>Contents</h2>
				<ul>
					<li>
						<a href="#1.0">1.0 Scope of Report</a>
					</li>
					<li>
						<a href="#2.0">2.0 Summary</a>
						<ul>
							<li>
								<a href="#2.1">2.1 Status</a>
								<ul>
									<li>
										<a href="#2.1.1">2.1.1 Overall Status</a>
									</li>
									<li>
										<a href="#2.1.2">2.1.2 Check Summary</a>
									</li>
									<li>
										<a href="#2.1.3">2.1.2 Check Totals</a>
									</li>
								</ul>
							</li>
							<li>
								<a href="#2.2">2.2 Review Summary</a>
							</li>
							<ul>
								<li>
									<a href="#2.2.1">2.2.1 Review Summary</a>
								</li>
								<li>
									<a href="#2.2.2">2.2.2 Service Complexity Summary</a>
								</li>
								<li>
									<a href="#2.2.3">2.2.3 Service Complexity Breakdown</a>
								</li>
								<li>
									<a href="#2.2.4">2.2.4 Assets in Numbers</a>
								</li>
							</ul>
							<li>
								<a href="#2.3">2.3 Failed Checks</a>
							</li>
						</ul>
					</li>
					<li>
						<a href="#3.0">3.0 Check Results</a>
					</li>
					<ul>
						<xsl:for-each select="/CodeCheckConfiguration/checks/check[@enabled='true']">
							<li>
								<a href="#{@id}">3.<xsl:value-of select="@index"/>
									<xsl:text><![CDATA[ ]]></xsl:text>
									<xsl:value-of select="@name"/>
								</a>
							</li>
							<ul>
								<li>
									<a href="#{@id}.1">3.<xsl:value-of select="@index"/>.1<xsl:text><![CDATA[ ]]></xsl:text>RAG Status</a>
								</li>
								<li>
									<a href="#{@id}.2">3.<xsl:value-of select="@index"/>.2<xsl:text><![CDATA[ ]]></xsl:text>Summary</a>
								</li>
								<li>
									<a href="#{@id}.3">3.<xsl:value-of select="@index"/>.3<xsl:text><![CDATA[ ]]></xsl:text>Detail</a>
								</li>
							</ul>
						</xsl:for-each>
					</ul>
				</ul>
				<div class="page-break"/>
				<a name="1.0"/>
				<h2>1.0 Scope of Report</h2><![CDATA[This report documents the findings of an IS Flow code review performed on the package ]]><xsl:value-of select="/CodeCheckConfiguration/properties/packageName"/>
				<br/>
				<br/><![CDATA[
PRIME is Software AG's globally standardized solution deployment methodology to deliver better Time-to-Value for Business Process Excellence.  It contains best-practice recommendations and guidelines based on the large number of webMethods implentations delivered by the services team over a number of years in order to ensure implementations are repeatable, maintainable and to the highest standards possible.]]><br/>
				<br/><![CDATA[
The code review detail provided by this report uses the PRIMEstandards as
the bench mark to which the package was compared against. Any aspects of the code which did not conform to PRIME are
highlighted and a relevant recommendation for change is provided]]><br/>
				<br/><![CDATA[
For each section, there is an explanation of the standards applied and recommended implementation, and a traffic light RAG (Red, Amber, Green) indication of the status of each item,]]>
				<a name="2.0"/>
				<h2>2.0 Summary</h2>
				<a name="2.1"/>
				<h3>2.1 Status</h3>
				<a name="2.1.1"/>				
				<h4>2.1.1 Overall Status</h4>
				<div style="margin-bottom:20px;">
					<xsl:choose>
						<xsl:when test="/CodeCheckConfiguration/@ragStatus=1">
							<xsl:attribute name="class">RAGGREEN</xsl:attribute>
							<span class="RAGGREENTEXT">Passed</span>
						</xsl:when>
						<xsl:when test="CodeCheckConfiguration/@ragStatus=0">
							<xsl:attribute name="class">RAGAMBER</xsl:attribute>
							<span class="RAGAMBERTEXT">Warnings</span>
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="class">RAGRED</xsl:attribute>
							<span class="RAGREDTEXT">Failed</span>
						</xsl:otherwise>
					</xsl:choose>
				</div>
				<a name="2.1.2"/>
				<h4>2.1.2 Check Summary</h4>
				
				<div id="summaryBarArea">
					<table class="summaryBar" style="margin-bottom: 0 !important">
						<tr>
							<xsl:if test="//CodeCheckConfiguration/Summary/passPercent > 0">
								<td class="greenBar">
									<xsl:attribute name="width"><xsl:value-of select="//CodeCheckConfiguration/Summary/passPercent"/><![CDATA[%]]></xsl:attribute>
								</td>
							</xsl:if>
							<xsl:if test="//CodeCheckConfiguration/Summary/warnPercent > 0">
								<td class="yellowBar">
									<xsl:attribute name="width"><xsl:value-of select="//CodeCheckConfiguration/Summary/warnPercent"/><![CDATA[%]]></xsl:attribute>
								</td>
							</xsl:if>
							<xsl:if test="//CodeCheckConfiguration/Summary/failPercent > 0">
								<td class="redBar">
									<xsl:attribute name="width"><xsl:value-of select="//CodeCheckConfiguration/Summary/failPercent"/><![CDATA[%]]></xsl:attribute>
								</td>
							</xsl:if>
						</tr>
						</table>
						<table class="summaryBarPct" style="border-left: 2px #000000 solid;border-right: 2px #000000 solid">
						<tr>
							<td width="10%" style="padding-left: 0;border-left: 2px #AAAAAA solid;background-color: #ffffff !important"></td>
							<td width="10%" style="padding-left: 0;border-left: 2px #AAAAAA solid"></td>
							<td width="10%" style="padding-left: 0;border-left: 2px #AAAAAA solid"></td>
							<td width="10%" style="padding-left: 0;border-left: 2px #AAAAAA solid"></td>
							<td width="10%" style="padding-left: 0;border-left: 2px #AAAAAA solid"></td>
							<td width="10%" style="padding-left: 0;border-left: 2px #AAAAAA solid"></td>
							<td width="10%" style="padding-left: 0;border-left: 2px #AAAAAA solid"></td>
							<td width="10%" style="padding-left: 0;border-left: 2px #AAAAAA solid"></td>
							<td width="10%" style="padding-left: 0;border-left: 2px #AAAAAA solid"></td>
							<td width="10%" style="padding-left: 0;border-left: 2px #AAAAAA solid"></td>
						</tr>
						</table>
						
				</div>
				
				<a name="2.1.3"/>
				<h4>2.1.3 Check Totals</h4>
				
				<div id="checkSummary">
					<table>
						<tbody>
							<tr>
								<th>Test</th>
								<th>Total Tested</th>
								<th>Passed</th>
								<th>Warning</th>
								<th>Failed</th>
								<th>RAG</th>
							</tr>
							<xsl:for-each select="/CodeCheckConfiguration/checks/check[@enabled='true']">
								<tr>
									<td>
										<a class="white" href="#{@id}">3.<xsl:value-of select="@index"/><xsl:text> </xsl:text><xsl:value-of select="@name"/></a>
									</td>
									<td>
										<xsl:value-of select="results/Summary/total"/>
									</td>
									<td>
										<xsl:value-of select="results/Summary/pass"/>
									</td>
									<td>
										<xsl:value-of select="results/Summary/warn"/>
									</td>
									<td>
										<xsl:value-of select="results/Summary/fail"/>
									</td>
									<xsl:choose>
										<xsl:when test="results/Summary/ragStatus=-1">
											<td style="background-color:#FF0000">Failed</td>
										</xsl:when>
										<xsl:when test="results/Summary/ragStatus=0">
											<td style="background-color:#FF6A00">Warning</td>
										</xsl:when>
										<xsl:when test="results/Summary/ragStatus=1">
											<td style="background-color:#00FF00">Passed</td>
										</xsl:when>
									</xsl:choose>
								</tr>
							</xsl:for-each>
						</tbody>
					</table>
				</div>
				<!--
				<div id="qualityScore">
				<span>Quality Rating: </span>
				</div>
				-->
				<div class="page-break"/>
				<a name="2.2"/>
				<h3>2.2 Review Summary</h3>
				<a name="2.2.1"/>
				<h4>2.2.1 Review Summary</h4>
				<span id="statusCountsChart">
					<canvas id="status-chart-area" width="350" height="350"/>
				</span>
				<span id="breakdownChart">
					<canvas id="chart-area" width="350" height="350"/>
				</span>
				<span id="statusHeader">Review Status</span>
				<span id="breakdownHeader">Review Assets</span>
				<span id="statusChartLegend">
					<table>
						<tbody>
							<tr>
								<th>Item</th>
								<th>Value</th>
							</tr>
							<tr>
								<td style="background-color:#00FF00;color:black;">Passed</td>
								<td>
									<xsl:value-of select="//sensors/sensor[definition/@sensorName='totals']/results[@name='TotalPassed']/@value"/>
								</td>
							</tr>
							<tr>
								<td style="background-color:#FF6A00;;color:black;">Warning</td>
								<td>
									<xsl:value-of select="//sensors/sensor[definition/@sensorName='totals']/results[@name='TotalWarning']/@value"/>
								</td>
							</tr>
							<tr>
								<td style="background-color:#FF0000;;color:black;">Failed</td>
								<td>
									<xsl:value-of select="//sensors/sensor[definition/@sensorName='totals']/results[@name='TotalFailed']/@value"/>
								</td>
							</tr>
						</tbody>
					</table>
				</span>
				<span id="breakdownChartLegend">
					<xsl:variable name="col1">#F7464A</xsl:variable>
					<xsl:variable name="col2">#46BFBD</xsl:variable>
					<xsl:variable name="col3">#FDB45C</xsl:variable>
					<xsl:variable name="col4">#949FB1</xsl:variable>
					<xsl:variable name="col5">#4D5360</xsl:variable>
					<xsl:variable name="col6">#FF0000</xsl:variable>
					<xsl:variable name="col7">#00FF00</xsl:variable>
					<xsl:variable name="col8">#0000FF</xsl:variable>
					<xsl:variable name="col9">#AA00AA</xsl:variable>
					<xsl:variable name="col10">#44FF44</xsl:variable>
					<xsl:variable name="col11">#AAAA00</xsl:variable>
					<xsl:variable name="col12">#00AAAA</xsl:variable>
					<xsl:variable name="col13">#AA9999</xsl:variable>
					<xsl:variable name="col14">#CCBBBB</xsl:variable>	
					<xsl:variable name="col15">#AAAA88</xsl:variable>
					<xsl:variable name="col16">#FFaa22</xsl:variable>
					
					<table>
						<tbody class="fullwidthKey">
							<tr>
								<th>Item</th>
								<th>Value</th>
							</tr>
							<xsl:for-each select="//sensors/sensor[definition/@sensorName='totals']/results[not(starts-with(@name,'Total')) and not(starts-with(@name,'overall')) and not(@name='Folders')]">
								<xsl:if test="@value!=0">
									<tr>
										<xsl:choose>
											<xsl:when test="@name='Folders'"/>
											<xsl:otherwise>
												<td>
													<xsl:attribute name="style"><xsl:text>color:black;background-color:</xsl:text><xsl:if test="position()=1"><xsl:value-of select="$col1"/></xsl:if><xsl:if test="position()=2"><xsl:value-of select="$col2"/></xsl:if><xsl:if test="position()=3"><xsl:value-of select="$col3"/></xsl:if><xsl:if test="position()=4"><xsl:value-of select="$col4"/></xsl:if><xsl:if test="position()=5"><xsl:value-of select="$col5"/></xsl:if><xsl:if test="position()=6"><xsl:value-of select="$col6"/></xsl:if><xsl:if test="position()=7"><xsl:value-of select="$col7"/></xsl:if><xsl:if test="position()=8"><xsl:value-of select="$col8"/></xsl:if><xsl:if test="position()=9"><xsl:value-of select="$col9"/></xsl:if><xsl:if test="position()=10"><xsl:value-of select="$col10"/></xsl:if><xsl:if test="position()=11"><xsl:value-of select="$col11"/></xsl:if><xsl:if test="position()=12"><xsl:value-of select="$col12"/></xsl:if><xsl:if test="position()=13"><xsl:value-of select="$col13"/></xsl:if><xsl:if test="position()=14"><xsl:value-of select="$col14"/></xsl:if><xsl:if test="position()=15"><xsl:value-of select="$col15"/></xsl:if><xsl:if test="position()=16"><xsl:value-of select="$col16"/></xsl:if><xsl:text>;</xsl:text></xsl:attribute>
													<xsl:value-of select="@name"/>
												</td>
												<td>
													<xsl:value-of select="@value"/>
												</td>
											</xsl:otherwise>
										</xsl:choose>
									</tr>
								</xsl:if>
							</xsl:for-each>
						</tbody>
					</table>
				</span>
				<a name="2.2.2"/>
				<span id="complexityRadar">
					<h4>2.2.2 Service Complexity Summary</h4>
					<canvas id="complexity-chart-summary" width="400" height="400"/>
				</span>
				<span id="complexityLegend">
					<table>
						<tbody>
							<tr>
								<th>Key</th>
							</tr>
							<tr>
								<td style="background-color: #f7464a;color:black">Flow Services</td>
							</tr>
							<tr>
								<td style="background-color: #46bfbd;color:black;">Java Services</td>
							</tr>
						</tbody>
					</table>
				</span>
				<div class="page-break"/>
				<a name="2.2.3"/>
				<h4>2.2.3 Service Complexity Breakdown</h4>
				<div id="complexity">
					<div id="chart_div" style="width: 900px; height: 500px;"></div>
					<!--
					<canvas id="complexity-chart-area" width="1024" height="760"/>
					-->
					<table>
						<tbody>
							<tr>
								<th>Service</th>
								<th>Type</th>
								<th>Complexity Value</th>
							</tr>
							<xsl:for-each select="//sensor[definition/@sensorName='CodeLines']/results[starts-with(@name,'complexityFactor')]">
								<xsl:sort select="@value" data-type="number" order="descending"/>								
								<tr>
									<xsl:if test="(position() mod 2) = 0">
										<xsl:attribute name="class">trshade</xsl:attribute>
									</xsl:if>
									<td>
										<xsl:attribute name="style"><xsl:choose><xsl:when test="@name='complexityFactor-java'">background-color: #46bfbd;color:black;</xsl:when><xsl:otherwise>background-color: #f7464a;color:black</xsl:otherwise></xsl:choose></xsl:attribute>
										<xsl:value-of select="@item"/>
									</td>
									<td>
										<xsl:choose>
											<xsl:when test="@name='complexityFactor-java'">Java</xsl:when>
											<xsl:otherwise>Flow</xsl:otherwise>
										</xsl:choose>
									</td>
									<td>
										<xsl:choose>
											<xsl:when test="@value=1">Very Simple</xsl:when>
											<xsl:when test="@value=2">Simple</xsl:when>
											<xsl:when test="@value=3">Average</xsl:when>
											<xsl:when test="@value=4">Complex</xsl:when>
											<xsl:when test="@value=5">Very Complex</xsl:when>
											<xsl:otherwise>Unknown</xsl:otherwise>
										</xsl:choose>
									</td>
								</tr>
								
							</xsl:for-each>
						</tbody>
					</table>
				</div>
				<a name="2.2.4"/>
				<h4>2.2.4 Assets in numbers</h4>
				<div id="linesArea">
					<ul>
						<li class="linesLev1">Lines of Code: <xsl:value-of select="//sensor[definition/@sensorName='CodeLines']/resultsGroup[@name='FlowCodeTotals']/results[@item='Services']/@value"/>
						</li>
						<ul>
							<li class="linesLev2">Flow: <xsl:value-of select="//sensor[definition/@sensorName='CodeLines']/resultsGroup[@name='FlowCodeTotals']/results[@item='Flow']/@value"/>
							</li>
							<ul>
								<xsl:for-each select="//sensor[definition/@sensorName='CodeLines']/resultsGroup[@name='FlowCodeTotals']/results[@name='Flow-breakdown']">
									<li class="linesLev3">
										<xsl:value-of select="@item"/>: <xsl:value-of select="@value"/>
									</li>
								</xsl:for-each>
							</ul>
							<li class="linesLev2">Java: <xsl:value-of select="//sensor[definition/@sensorName='CodeLines']/resultsGroup[@name='FlowCodeTotals']/results[@item='Java']/@value"/>
							</li>
						</ul>
						<br/>
						<xsl:variable name="qualityScore" select="//sensor[definition/@sensorName='totals']/resultsGroup[@name='SummaryTotals']/results[@name='overallQualityPct']/@value"/>
						<li class="linesLev1">Overall Quality Score: 
<xsl:choose>
								<xsl:when test="$qualityScore&lt;20"> Very poor</xsl:when>
								<xsl:when test="$qualityScore&lt;40"> Poor</xsl:when>
								<xsl:when test="$qualityScore&lt;60"> Average</xsl:when>
								<xsl:when test="$qualityScore&lt;80"> Good</xsl:when>
								<xsl:when test="$qualityScore&lt;101"> Excellent</xsl:when>
							</xsl:choose><![CDATA[ (]]><xsl:value-of select="$qualityScore"/>/100)</li>
						<xsl:variable name="max">
							<xsl:for-each select="//sensor[definition/@sensorName='CodeLines']/results[starts-with(@name,'complexityFactor')]/@value">
								<xsl:sort select="." data-type="number" order="descending"/>
								<xsl:if test="position() = 1">
									<xsl:value-of select="."/>
								</xsl:if>
							</xsl:for-each>
						</xsl:variable>
						<li class="linesLev1">Overall Complexity: 
							<xsl:choose>
								<xsl:when test="$max=1">Very Simple</xsl:when>
								<xsl:when test="$max=2">Simple</xsl:when>
								<xsl:when test="$max=3">Average</xsl:when>
								<xsl:when test="$max=4">Complex</xsl:when>
								<xsl:when test="$max=5">Very Complex</xsl:when>
								<xsl:otherwise>Unknown</xsl:otherwise>
							</xsl:choose><![CDATA[ (]]><xsl:value-of select="$max"/><![CDATA[/5) ]]></li>
					</ul>
				</div>
				<div class="page-break"/>
				<a name="2.3"/>
				<h3>2.3 Failed Checks</h3>
				<table class="fullwidth">
					<xsl:choose>
						<xsl:when test="count(//Report/Test[@passed='false'])=0">
							<p>No Failed Checks</p>
						</xsl:when>
						<xsl:otherwise>
							<tbody class="fullwidth">
								<tr>
									<th>ID</th>
									<th>Rule Name</th>
									<th>Service/Item</th>
								</tr>
								<xsl:for-each select="//Report/Test[@passed='false']">
									<tr>
										<xsl:choose>
											<xsl:when test="@ragStatus=1">
												<!--  Do nothing - test passed  -->
											</xsl:when>
											<xsl:when test="@ragStatus=0">
												<xsl:attribute name="class">AMBER</xsl:attribute>
											</xsl:when>
											<xsl:otherwise>
												<xsl:attribute name="class">RED</xsl:attribute>
											</xsl:otherwise>
										</xsl:choose>
										<td>
											<a class="white" href="#{substring-before(@check-id,'.')}">
												<xsl:value-of select="substring-before(@check-id,'.')"/>
											</a>
										</td>
										<td>
											<xsl:value-of select="../../../@name"/>
										</td>
										<td>
											<xsl:value-of select="Service"/>
										</td>
									</tr>
								</xsl:for-each>
							</tbody>
						</xsl:otherwise>
					</xsl:choose>
				</table>
				<div class="page-break"/>
				<a name="3.0"/>
				<h2>3.0 Individual Check Results</h2>
				<xsl:apply-templates select="/CodeCheckConfiguration/checks/check[@enabled='true']"/>
			</body>
		</html>
		<!-- Show only the enabled checks -->
	</xsl:template>
	<xsl:template match="check">
		<a name="{@id}"/>
		<div class="check">
			<h3>3.<xsl:value-of select="position()"/>
				<xsl:text><![CDATA[ ]]></xsl:text>
				<xsl:value-of select="@name"/>
			</h3>
			<p>
				<xsl:value-of select="description" disable-output-escaping="yes"/>
			</p>
			<xsl:apply-templates select="results/Summary"/>
			<xsl:apply-templates select="results/Report"/>
		</div>
	</xsl:template>
	<xsl:template match="Summary">
		<a name="{../../@id}.1"/>
		<h4>3.<xsl:value-of select="../../@index"/>.1 RAG Status</h4>
		<div>
			<xsl:choose>
				<xsl:when test="ragStatus=1">
					<xsl:attribute name="class">RAGGREEN</xsl:attribute>
					<span class="RAGGREENTEXT">Passed</span>
				</xsl:when>
				<xsl:when test="ragStatus=0">
					<xsl:attribute name="class">RAGAMBER</xsl:attribute>
					<span class="RAGAMBERTEXT">Warnings</span>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="class">RAGRED</xsl:attribute>
					<span class="RAGREDTEXT">Failed</span>
				</xsl:otherwise>
			</xsl:choose>
		</div>
		<a name="{../../@id}.2"/>
		<h4>3.<xsl:value-of select="../../@index"/>.2 Summary</h4>
		<div>
			<table>
				<tbody>
					<tr>
						<th>Total Tests</th>
						<td>
							<span class="value">
								<xsl:value-of select="total"/>
							</span>
						</td>
					</tr>
					<tr>
						<th>Passed</th>
						<td class="trshade">
							<span class="value">
								<xsl:value-of select="pass"/>
							</span>
						</td>
					</tr>
					<tr>
						<th>Warning</th>
						<td>
							<span class="value">
								<xsl:value-of select="warn"/>
							</span>
						</td>
					</tr>
					<tr>
						<th>Failed</th>
						<td class="trshade">
							<span class="value">
								<xsl:value-of select="fail"/>
							</span>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</xsl:template>
	<xsl:template match="Report">
		<a name="{substring-before(./Test[1]/@check-id,'.')}"/>
		<a name="{../../@id}.3"/>
		<h4>3.<xsl:value-of select="../../@index"/>.3 Detail</h4>
		<xsl:choose>
			<xsl:when test="../Summary/total &gt; 0">
				<table class="fullwidth">
					<tbody class="fullwidth">
						<tr>
							<th>ID</th>
							<th>Item to be checked</th>
							<th>Value/Check</th>
							<th>Passed</th>
						</tr>
						<xsl:apply-templates select=".//Test"/>
					</tbody>
				</table>
			</xsl:when>
			<xsl:otherwise>
				<p>No assets to be tested were discovered</p>
			</xsl:otherwise>
		</xsl:choose>
		<div class="page-break"/>
	</xsl:template>
	<xsl:template match="Test">
		<tr>
			<xsl:choose>
				<xsl:when test="@ragStatus=1">
					<!--  Do nothing - test passed  -->
					<xsl:if test="(position() mod 2) = 0">
						<xsl:attribute name="class">trshade</xsl:attribute>
					</xsl:if>
				</xsl:when>
				<xsl:when test="@ragStatus=0">
					<xsl:attribute name="class">AMBER</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="class">RED</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<td>
				<xsl:value-of select="@check-id"/>
			</td>
			<td>
				<xsl:value-of select="Service"/>
			</td>
			<td>
				<xsl:value-of select="Value"/>
			</td>
			<td>
				<xsl:value-of select="@passed"/>
			</td>
		</tr>
	</xsl:template>
</xsl:stylesheet>
