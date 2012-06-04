<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Ontologies.aspx.cs" Inherits="GeoStoreWebClient.Ontologies" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<style type="text/css">
td
{
    background-color: Whitesmoke;
    padding:4px;
    border-color:#FFFFFF;
    border-width:2px;
    
}
    .style1
    {
        width: 30px;
        background-color:#ffffff;
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<h1>Ontologies</h1>

<h2>Namespaces</h2>
<table>
<tr><td><b>Prefix</b></td><td><b>Namespace</b></td><td><b>Description</b></td></tr>
<tr><td>&nbsp;</td><td>http://ilab.auburn.edu/geostore/ontology#</td><td>GeoStore System 
    namespace</td></tr>
<tr><td>gstore</td><td>http://ilab.auburn.edu/geostore/ontology#</td><td>GeoStore System 
    namespace</td></tr>
<tr><td>gpw</td><td>http://www.gaspricewatch.com/</td><td>Ontology of Gas Price Watch Dataset</td></tr>
<tr><td>gn</td><td>http://www.geonames.org/ontology#</td><td>Ontology of GeoNames Dataset v3 
    description obtained from http://www.geonames.org/ontology/ontology_v3.01.rdf</td></tr>
<tr><td>rdf</td><td>http://www.w3.org/1999/02/22-rdf-syntax-ns#</td>
    <td>RDF ontology namespace</td></tr>
<tr><td>gml</td><td>http://www.opengis.net/gml</td><td>OpenGIS GML namespace</td></tr>
<tr><td>wgs84_pos</td><td>http://www.w3.org/2003/01/geo/wgs84_pos#</td><td>A 
    vocabulary for representing latitude, longitude and altitude information in the 
    WGS84 geodetic reference datum.</td></tr>
</table>

<h2>GeoStore</h2>

<h3>Resources</h3>
<table>
<tr><td><b>Name</b></td><td><b>Description</b></td></tr>
<tr><td>gstore:HilbertEncoding</td><td>Reserved</td></tr>
</table>

<h3>Classes</h3>
<table>
<tr><td><b>Name</b></td><td><b>Description</b></td></tr>
<tr><td>gstore:PointFeature</td><td>A point of interest</td></tr>
<tr><td>gstore:GasStation</td><td>Geospatial features that are gas stations</td></tr>
<tr><td>gstore:School</td><td>Geospatial features that are schools obtained from 
    GeoName. This class include high schhool and some universities.</td></tr>
</table>

<h3>Properties</h3>
<table>
<tr><td><b>Name</b></td><td><b>Description</b></td><td><b>Domain</b></td><td><b>Range</b></td></tr>
<tr><td>gstore:pos</td><td>HCH hash value of a geographic point</td><td>rdfs:Resource</td><td>
    rdfs:Literal, integer </td></tr>
<tr><td>gstore:CurveType</td><td>Parameter of the HCH index specifying the curve 
    orientation of the space filling curve</td><td>gstore:HilbertEncoding</td><td>
    rdfs:Literal, CurveType</td></tr>
<tr><td>gstore:Order</td><td>Parameter of the HCH index specifying the order of the 
    space filling curve</td><td>gstore:HilbertEncoding</td><td>rdfs:Literal, integer</td></tr>
<tr><td>gstore:LowerBound</td><td>Parameter of the HCH index specifying the &quot;lower 
    left&quot; corner of data bound</td><td>gstore:HilbertEncoding</td><td>Point</td></tr>
<tr><td>gstore:UpperBound</td><td>Parameter of the HCH index specifying the &quot;upper 
    right&quot; corner of data bound</td><td>gstore:HilbertEncoding</td><td>Point</td></tr>
<tr><td>name</td><td>Name of a resource</td><td>rdfs:Resource</td><td>rdfs:Literal, 
    string</td></tr>
</table>

<h2>GeoName</h2>

<h3>Classes</h3>
<table>
<tr><td><b>Name</b></td><td><b>Description</b></td></tr>
<tr><td>gn:Feature</td><td>A geospatial features</td></tr>
</table>

<h3>Properties</h3>
<table>
<tr><td><b>Name</b></td><td><b>Description</b></td><td><b>Domain</b></td><td><b>Range</b></td></tr>
<tr><td>gn:featureClass</td><td>One letter feature category code</td><td>gn:Feature</td><td>
    rdfs:Literal, string</td></tr>
<tr><td>gn:featureCode</td><td>Feature code</td><td>gn:Feature</td><td>
    rdfs:Literal, string</td></tr>
<tr><td>gn:countryCode</td><td>Two letter country code denoting the country of 
    feature</td><td>gn:Feature</td><td>rdfs:Literal, string</td></tr>
<tr><td>gn:parentADM1</td><td>First administrative division (US State)</td><td>
    gn:Feature</td><td>rdfs:Literal, string</td></tr>
</table>

<h3>Common Feature Code</h3>
<table>
<tr><td><b>Code</b></td><td><b>Description</b></td><td class="style1">&nbsp;</td><td><b>Code</b></td><td><b>Description</b></td></tr>
<tr><td>AIRP</td><td>Airport</td><td class="style1">&nbsp;</td><td>LIBR</td><td>Library</td></tr>
<tr><td>BANK</td><td>Bank</td><td class="style1">&nbsp;</td><td>MALL</td><td>Mall</td></tr>
<tr><td>CH</td><td>Church</td><td class="style1">&nbsp;</td><td>SCH</td><td>School</td></tr>
<tr><td>HSP</td><td>Hospital</td><td class="style1">&nbsp;</td><td>UNI</td><td>University</td></tr>
<tr><td>HTL</td><td>Hotel</td><td class="style1">&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
</table>

<h2>GasPriceWatch</h2>

<h3>Properties</h3>
<table>
<tr><td><b>Name</b></td><td><b>Description</b></td><td><b>Domain</b></td><td><b>Range</b></td></tr>
<tr><td>gpw:address</td><td>The street address of a gas station</td><td>
    gstore:GasStation</td><td>
        rdfs:Literal, string </td></tr>
<tr><td>gpw:regularPrice</td><td>The regular price of a gas station</td><td>
    gstore:GasStation</td><td>
        rdfs:Literal, string </td></tr>
<tr><td>gpw:premiumPrice</td><td>The premium price of a gas station</td><td>
    gstore:GasStation</td><td>rdfs:Literal, string </td></tr>
<tr><td>gpw:dieselPrice</td><td>The diesel price of a gas station</td><td>
    gstore:GasStation</td><td>rdfs:Literal, 
    string </td></tr>
<tr><td>gpw:website</td><td>URL of the page where the price info can be found</td><td>
    gstore:GasStation</td><td>rdfs:Literal, 
    string </td></tr>
</table>

<h2>GML</h2>

<h3>Properties</h3>
<table>
<tr><td><b>Name</b></td><td><b>Description</b></td><td><b>Domain</b></td><td><b>Range</b></td></tr>
<tr><td>gml:pos</td><td>Latitude and longitude of a point separated by a space in WKT format</td><td>
    gstore:PointFeature, gn:Feature</td><td>rdfs:Literal</td></tr>
</table>

<h2>WGS84</h2>

<h3>Properties</h3>
<table>
<tr><td><b>Name</b></td><td><b>Description</b></td><td><b>Domain</b></td><td><b>Range</b></td></tr>
<tr><td>wgs84_pos:lat</td><td>The latitude of a geographic point</td><td>
    gstore:PointFeature, gn:Feature</td><td>rdfs:Literal</td></tr>
<tr><td>wgs84_pos:long</td><td>The longitude of a geographic point</td><td>
    gstore:PointFeature, gn:Feature</td><td>rdfs:Literal</td></tr>
<tr><td>wgs84_pos:lat_long</td><td>Latitude and longitude of a geogrpahic point</td><td>
    gstore:PointFeature, gn:Feature</td><td>rdfs:Literal</td></tr>
</table>

<h2>RDF</h2>

<h3>Properties</h3>
<table>
<tr><td><b>Name</b></td><td><b>Description</b></td><td><b>Domain</b></td><td><b>Range</b></td></tr>
<tr><td>rdf:type</td><td>The subject is an instance of a class.</td><td>
    rdfs:Resource</td><td>rdfs:Class</td></tr>
</table>

</asp:Content>
