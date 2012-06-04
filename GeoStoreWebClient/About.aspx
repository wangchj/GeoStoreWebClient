<%@ Page Title="About Us" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="About.aspx.cs" Inherits="GeoStoreWebClient.About" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>What is GeoStore?</h2>
    <p>
        GeoStore is the backend of this website that evaluates semantic web queries and 
        returns the results.</p>
    <p>
        GeoStore is a semantic web data management system with geospatial 
        capabilities. Semantic web data are expressed using the resource description 
        framework and store in the data store of our system. GeoStore allows the user to 
        query graph pattern of the data using triple pattern and using standardized 
        SPARQL language.</p>
    <p>
        In addition to evaluation of standard SPARQL queries using triple graph 
        patterns, GeoStore emphasize on being able to understand and perform operations 
        on geospatial semantic data. GeoStore is able to parse and understand spatial 
        data in the system and add meaning to these data instead of treating them as 
        meaningless RDF literal. Adding meaning to geospatial data allows the user to 
        construct graph patterns involving geospatil and geographic constraints. 
        [GeoStore query capabilities]</p>
    <h2>
        What is GeoStore Portal</h2>
    <p>
        GeoStore Portal is the front-end of our GeoStore system where geo-enabled SPARQL 
        queries can be constructed and submitted to the system for query processing. The 
        Portal displays results return by the server. For geo-tagged data, the results 
        are shown on the map as a convenient way to visualize the results.</p>
    <p>
        &nbsp;</p>
</asp:Content>
