<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="QueryResultView.aspx.cs" Inherits="GeoStoreWebClient.QueryResultView" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

<script type="text/javascript"
      src="http://maps.googleapis.com/maps/api/js?key=AIzaSyCPBfmojGyNxx_egxYm1uNr_Lb7Vu5Yvgs&sensor=false">
    </script>
    <script type="text/javascript">
        function initialize() {
            var myOptions = {
                center: new google.maps.LatLng(32.606, -85.481),
                zoom: 15,
                mapTypeId: google.maps.MapTypeId.ROADMAP,
                mapTypeControl: false,
                panControl: false,
                streetViewControl: false,
                zoomControl: false
            };
            var map = new google.maps.Map(document.getElementById("map_canvas"),
            myOptions);

            //Add a few markers
            //var pos1 = new google.maps.LatLng(32.621024,-85.455878);
            var m1 = new google.maps.Marker({
                position: new google.maps.LatLng(32.621024, -85.455878),
                title: "Hello World!"
            });
            var m2 = new google.maps.Marker({
                position: new google.maps.LatLng(32.569734, -85.438549),
                title: "Hello World!"
            });
            var m3 = new google.maps.Marker({
                position: new google.maps.LatLng(32.608747, -85.43214),
                title: "Hello World!"
            });
            var m3 = new google.maps.Marker({
                position: new google.maps.LatLng(32.626041, -85.443672),
                title: "Hello World!"
            });
            var m4 = new google.maps.Marker({
                position: new google.maps.LatLng(32.61629, -85.465492),
                title: "Hello World!"
            });
            var m5 = new google.maps.Marker({
                position: new google.maps.LatLng(32.608677, -85.479906),
                title: "Hello World!"
            });
            m1.setMap(map);
            m2.setMap(map);
            m3.setMap(map);
            m4.setMap(map);
            m5.setMap(map);
        }
    </script>

    <script type="text/javascript">
        window.onload = initialize;
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Query Result</h2>
    <asp:Literal ID="ErrorLiteral" runat="server"></asp:Literal>
    <asp:GridView ID="GridView1" runat="server" CellPadding="10" ForeColor="#333333" 
        GridLines="None">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" HorizontalAlign="Left" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>

    <h2>Map View</h2>
    <div id="map_canvas" style="width:650px; height:600px"></div>
</asp:Content>
