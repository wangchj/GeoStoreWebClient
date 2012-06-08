<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Query.aspx.cs" Inherits="GeoStoreWebClient.Query" %>

<script runat="server">
    public const string EidSpSelectField = "spatial_tool_select_field";
    public const string EidSpTextField = "spatial_tool_text_field_";
    public const string EidSpTextField1 = EidSpTextField + "1";
    public const string EidSpTextField2 = EidSpTextField + "2";
    public const string EidSpTextField3 = EidSpTextField + "3";

    public const string EidSpTextFieldLabel = "spatial_tool_text_field_label_";
    public const string EidSpTextFieldLabel1 = EidSpTextFieldLabel + "1";
    public const string EidSpTextFieldLabel2 = EidSpTextFieldLabel + "2";
    public const string EidSpTextFieldLabel3 = EidSpTextFieldLabel + "3";
    
    public const string ClSpTextField = "spatial_tool_field";
</script>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
<style type="text/css">
input[type="submit"], input[type="button"]
{
   background-color:#EEEEEE;
   border-top-style:solid;
   border-top-color:#DDDDDD;
   border-top-width:1px;
   border-bottom-style:solid;
   border-bottom-color:#AAAAAA;
   border-bottom-width:1px;
   border-left-style:solid;
   border-left-color:#DDDDDD;
   border-left-width:1px;
   border-right-style:solid;
   border-right-color:#AAAAAA;
   border-right-width:1px;
}

.sample_query
{
    text-shadow: 1px 1px 0px #fff;
	background: #F3F3F3;

    margin:5px 5px 5px 5px;
    
	border: 1px solid #E6E6E6;
	border-radius: 3px;

	padding:4px 4px 4px 4px;

	-moz-box-shadow:    1px 1px 0px 0px #ccc;
	-webkit-box-shadow: 1px 1px 0px 0px #ccc;
	box-shadow:         1px 1px 0px 0px #ccc;
}

.tag
{
    background-color: #C3E0F5;
    font-size:x-small;
    margin:0px 0px 0px 5px;
    padding:1px 3px 3px 3px;
	border: 1px solid #A2D3F7;
	border-radius: 3px;
}

pre
{
    font-size:1.2em;
}

.query_title_box
{
    width:100%;
}

.query_code
{
    display:none;
}

.query_option_box
{
    float:right;
    text-align:right;
    white-space:nowrap;
}

.CodeMirror
{
    font-size:1.4em;
    border:1px solid #334;
    /*width:730px;*/
}
    
#map
{
    height:350px;
    width:500px;
}

.tool_field
{
    margin-bottom:10px;
}

.tool_field_label
{
    margin-bottom:5px;
}

input.<%=ClSpTextField%>
{
    width:190px;
}

</style>

<script type="text/javascript" src="/Scripts/CodeMirror-2.24/lib/codemirror.js"></script>
<link rel="stylesheet" href="/Scripts/CodeMirror-2.24/lib/codemirror.css" />
<script type="text/javascript" src="/Scripts/CodeMirror-2.24/mode/sparql/sparql.js"></script>
<script type="text/javascript"
      src="http://maps.googleapis.com/maps/api/js?key=AIzaSyCPBfmojGyNxx_egxYm1uNr_Lb7Vu5Yvgs&libraries=geometry&sensor=false"></script>

<script type="text/javascript" language="javascript">

    var myCodeMirror = null;

    $(document).ready(doc_ready);

    function doc_ready() {
        $(".query_option_expand").click(function () {
            if ($(this).text() == "More") {
                $(this).parents("div.sample_query").find(".query_code").css("display", "block");
                $(this).text("Less");
            }
            else {
                $(this).parents("div.sample_query").find(".query_code").css("display", "none");
                $(this).text("More");
            }
        });

        //When the "Use" of a query is clicked
        $(".query_option_use").click(function () {
            //$("#<%= TextQueryInput.ClientID %>").val($(this).parents("div.sample_query").find("pre").text());
            var val = $(this).parents("div.sample_query").find("pre").text();
            myCodeMirror.setValue($.trim(val));
        });

        //Insert pattern clicked event
        $("#insert_pattern_btn").click(function () {
            $("#tool_box").css("display", "block");
            $("#pattern_tool_box").css("display", "block");
            $("#spatial_tool_box").css("display", "none");
        });

        //Insert spatial filter clicked event
        $("#insert_spatial_btn").click(function () {
            $("#tool_box").css("display", "block");
            $("#spatial_tool_box").css("display", "block");
            $("#pattern_tool_box").css("display", "none");
            if(MapToolContext.map == null)
                initMap();
        });

        //Tool box close event
        $("#tool_box_close").click(function () {
            $("#spatial_tool_box").css("display", "block");
            $("#tool_box").css("display", "none");
        });

        $("#patternToolInsertBtn").click(function () { PatternTool.insertClicked(); });

        $("#<%=EidSpSelectField %>").change(function () {

            //Reset field labels
            if ($(this).val() == "Window") {
                $("#<%=EidSpTextFieldLabel2 %>").text("Lower Bound");
                $("#<%=EidSpTextFieldLabel3 %>").text("Upper Bound");
            }
            else if ($(this).val() == "Range") {
                $("#<%=EidSpTextFieldLabel2 %>").text("Center");
                $("#<%=EidSpTextFieldLabel3 %>").text("Radius (Meters)");
            }
            else if ($(this).val() == "Range Variable Center") {
                $("#<%=EidSpTextFieldLabel2 %>").text("Center (Variable Name)");
                $("#<%=EidSpTextFieldLabel3 %>").text("Radius (Meters)");
            }
            else if ($(this).val() == "Nearby") {
                $("#<%=EidSpTextFieldLabel2 %>").text("Center");
                $("#<%=EidSpTextFieldLabel3 %>").text("Limit");
            }

            MapToolContext.clearInputFields();
            MapToolContext.removeEditOverlay();
        });

        $(".<%=ClSpTextField %>").click(function () {
            ///<summary>
            ///Event handler for spatial tool text fields. The purpose is to determine
            ///which field was clicked last so the map click handler knows which field
            ///to insert coodinates
            ///</summary>

            var fieldIdStr = $(this).attr("id");
            if (fieldIdStr == "spatial_tool_text_field_2")
                MapToolContext.lastClickedField.id = 2;
            else if (fieldIdStr == "spatial_tool_text_field_3")
                MapToolContext.lastClickedField.id = 3;
            else
                MapToolContext.lastClickedField.id = 1;

            MapToolContext.lastClickedField.idStr = fieldIdStr;
        });

        $("#<%=EidSpTextField3 %>").change(function () {
            if (MapToolContext.filterType() == FilterTypes.Range) {
                //TODO: Validate input value

                checkDrawRangeCircleOverlay();
            }
        });

        $("#spatial_tool_insert_btn").click(spatialToolInsertClicked);
        $("#spatial_tool_clear").click(spatialToolClearClicked);
        init_codemirror();
    }

    
    function initMap() {
        ///<summary>Initializes spatial tool Google map.</summary>

        var myOptions = {
            center: new google.maps.LatLng(32.606, -85.481),
            zoom: 15,
            mapTypeId: google.maps.MapTypeId.ROADMAP,
            mapTypeControl: false,
            panControl: false,
            streetViewControl: false,
            zoomControl: false
        };
        MapToolContext.map = new google.maps.Map(document.getElementById("map"),
            myOptions);

        //Assign event handler for map click event.
        google.maps.event.addListener(MapToolContext.map, 'click', mapClicked);
    }

    var PatternTool = {
        insertClicked: function () {
            //alert(this.toString());
            if (!this.validateInput()) {
                alert("Invalid inputs.");
                return;
            }

            //Add SELECT and WHERE clause if not exist.
            this.checkQueryStruct();
            this.insertTriple();
            this.insertSelectVars();
        },
        checkQueryStruct: function () {
            var queryStr = myCodeMirror.getValue();

            //Check SELECT clause
            var pos = queryStr.search(/^SELECT/i);
            if (pos == -1)
                myCodeMirror.setLine(0, "SELECT\n");
            //Check WHERE clause
            pos = queryStr.search(/WHERE/i);
            if (pos == -1)
                myCodeMirror.setLine(myCodeMirror.lineCount() - 1, "WHERE\n{\n}");
        },
        insertTriple: function () {
            var index = this.findInsertIndex();
            if (index == -1) {
                alert("Query syntax error. Unable to insert new query pattern.");
                return;
            }
            var triple = "    " + this.getSubjectField().val() + " " +
                this.getPredicateField().val() + " " +
                this.getObjectField().val() + ".\n";
            myCodeMirror.replaceRange(triple, myCodeMirror.posFromIndex(index));
        },
        findInsertIndex: function () {

            var queryStr = myCodeMirror.getValue();

            //Find the index of first filter function.
            //Currently only considering spatial functions; we should also consider
            //generic filters.
            var index = queryStr.search(/(WITHIN|NEARBY)\(/i);
            if (index == -1)
                index = queryStr.lastIndexOf("}");
            return index;
        },
        insertSelectVars: function () {
            if ($("#showSubject").val("checked")) {
                this.insertSelectVar(this.getSubjectField().val());
            }
            if ($("#showObject").val("checked")) {
                this.insertSelectVar(this.getObjectField().val());
            }
        },
        insertSelectVar: function (str) {

            str = $.trim(str);

            if (str.charAt(0) != "?")
                return;

            //Get tokenized list of select variables
            var qstr = myCodeMirror.getValue();
            var toIndex = qstr.search(/(WHERE|&)/i);
            var select = $.trim(qstr.substring(0, toIndex));
            var tokens = select.split(" ");
            if (tokens[0].toUpperCase() == "SELECT")
                tokens = tokens.slice(1);

            //Check and insert new variable into SELECT
            if (tokens.indexOf(str) == -1) {
                myCodeMirror.replaceRange(" " + str,
                    myCodeMirror.posFromIndex(select.length));
            }
        },
        getSubjectField: function () {
            return $("#pattern_tool_sub_input");
        },
        getPredicateField: function () {
            return $("#pattern_tool_pred_select");
        },
        getObjectField: function () {
            return $("#pattern_tool_obj_input");
        },
        validateInput: function () {
            return this.getSubjectField().val() != "" &&
                this.getObjectField().val() != "";
        }
    }

    

    var FilterTypes = { Window: 0, Range: 1, RangeVar: 2, Nearby: 3 }

    var MapToolContext = {
        map: null,
        lastClickedField: {
            id: 0,      //Integer
            idStr: ""   //String: element id
        },
        editOverlay: null,
        overlays: [],
        windowContext: {
            upperBound: null,
            lowerBound: null
        },
        rangeContext: {
            center: null,   //LatLng
            radius: null    //float, in meters
        },
        filterType: function () {
            ///<summary>
            ///Gets the current select query filter type of the spatial tool.
            ///</summary>

            var type = $("#<%=EidSpSelectField %>").val();
            if (type == "Window")
                return FilterTypes.Window;
            else if (type == "Range")
                return FilterTypes.Range;
            else if (type == "Range Variable Center")
                return FilterTypes.RangeVar;
            else if (type == "Nearby")
                return FilterTypes.Nearby;
            else
                return null;
        },
        clearInputFields: function () {
            ///Clear text field values, last clicked values.
            $(".<%=ClSpTextField%>").val("");
            this.lastClickedField.id = 0;
            this.lastClickedField.idStr = null;
        },
        removeEditOverlay: function () {
            ///Remove the temporary editing overlay from the map.
            if (this.editOverlay != null) {
                this.editOverlay.setMap(null);
                this.editOverlay = null;
            }
        },
        getTextField1: function () {
            //returns jQuery object of text input field 1
            return $("#<%=EidSpTextField1 %>");
        },
        getTextField2: function () {
            //returns jQuery object of text input field 2
            return $("#<%=EidSpTextField2 %>");
        },
        getTextField3: function () {
            //returns jQuery object of text input field 3
            return $("#<%=EidSpTextField3 %>");
        }
    }

    var OverlayColorContext = {
        colors: ["#000000", "#FF0000", "#00FF00", "#0000FF", "#FFFF00", "#FF00FF"],
        colorIndex: 0,
        getNextColor: function () {
            if (this.colorIndex >= this.colors.length - 1)
                this.colorIndex = 0;
            else
                this.colorIndex++;
            return this.colors[this.colorIndex];
        },
        getCurrentColor: function() {
            return this.colors[this.colorIndex];
        }
    }

    function mapClicked(event) {
        ///<summary>
        ///Event handler for map click event. Inserts geospatial information from
        ///the map to the appropriate tool input box.
        ///</summary>

        var queryType = $("#<%=EidSpSelectField %>").val();
        if (queryType == "Window")
            mapClickedWindow(event);
        else if (queryType == "Range")
            mapClickRange(event);
        else if (queryType == "Nearby")
            mapClickNearby(event);
    }

    function mapClickedWindow(event) {
        var lastClickId = MapToolContext.lastClickedField.id;

        if (lastClickId < 2)
            return;
        else if (lastClickId == 2)
            MapToolContext.windowContext.lowerBound = event.latLng;
        else
            MapToolContext.windowContext.upperBound = event.latLng;

        $("#" + MapToolContext.lastClickedField.idStr).val(event.latLng.toUrlValue());

        //Draw the rectangle, if both fields are specified.
        if ($("#<%=EidSpTextField2 %>").val() != "" &&
            $("#<%=EidSpTextField3 %>").val() != "") {

            var color;
            if (MapToolContext.editOverlay == null)
                color = OverlayColorContext.getNextColor();
            else {
                color = OverlayColorContext.getCurrentColor();
                MapToolContext.editOverlay.setMap(null);
            }

            MapToolContext.editOverlay = new google.maps.Rectangle({
                clickable:false,
                strokeColor: color,
                strokeOpacity: 0.2,
                strokeWeight: 1,
                fillColor: color,
                fillOpacity: 0.1,
                map: MapToolContext.map,
                bounds: new google.maps.LatLngBounds(MapToolContext.windowContext.lowerBound,
                MapToolContext.windowContext.upperBound)
            });
        }
    }

    function mapClickRange(event) {
        
        if (MapToolContext.lastClickedField.id != 2)
            return;

        MapToolContext.rangeContext.center = event.latLng;
        $("#" + MapToolContext.lastClickedField.idStr).val(event.latLng.toUrlValue());
        checkDrawRangeCircleOverlay();
    }

    function mapClickNearby(event) {
        if (MapToolContext.lastClickedField.id != 2)
            return;

        MapToolContext.rangeContext.center = event.latLng;
        $("#" + MapToolContext.lastClickedField.idStr).val(event.latLng.toUrlValue());
    }

    function checkDrawRangeCircleOverlay() {
        ///<summary>
        ///Check if all the necessary information to draw the circle overlay for a
        ///range query filter is present. If so, draw the overlay.
        ///</summary>

        if (MapToolContext.getTextField2().val() != "" &&
            MapToolContext.getTextField3().val() != "") {
            var color;
            if (MapToolContext.editOverlay == null)
                color = OverlayColorContext.getNextColor();
            else {
                color = OverlayColorContext.getCurrentColor();
                MapToolContext.editOverlay.setMap(null);
            }

            MapToolContext.editOverlay = new google.maps.Circle({
                clickable: false,
                strokeColor: color,
                strokeOpacity: 0.2,
                strokeWeight: 1,
                fillColor: color,
                fillOpacity: 0.1,
                map: MapToolContext.map,
                center: MapToolContext.rangeContext.center,
                radius: parseFloat(MapToolContext.getTextField3().val())
            });
        }
    }

    function spatialToolInsertClicked() {
        if (!spatialToolInsertValidateInput()) {
            alert("Invalid inputs");
            return;
        }

        insertSpatialFilterIntoEditor();

        //Adds the current overlay to a list of map overlays
        MapToolContext.overlays.push(MapToolContext.editOverlay);
        MapToolContext.editOverlay = null;
        
        //Clear input fields
        MapToolContext.clearInputFields();
    }

    function insertSpatialFilterIntoEditor() {
        var insert = myCodeMirror.getValue().lastIndexOf("}");
        if (insert == -1)
            return;

        var input1 = MapToolContext.getTextField1().val();
        var input2 = MapToolContext.getTextField2().val();
        var input3 = MapToolContext.getTextField3().val();
        var filterStr = "    ";

        var filterType = MapToolContext.filterType();
        if (filterType == FilterTypes.Nearby)
            filterStr += "NEARBY";
        else
            filterStr += "WITHIN";

        filterStr += "(" + input1 + ", " + input2 + ", " + input3 + ")" + "\n}";
        myCodeMirror.setLine(myCodeMirror.lineCount()-1, filterStr);
        
    }

    function spatialToolInsertValidateInput() {
        if (MapToolContext.filterType() == FilterTypes.Window)
            return spatialToolInsertValidateInputWindow();
        else if (MapToolContext.filterType() == FilterTypes.Range)
            return spatialToolInsertValidateInputRange();
        else if (MapToolContext.filterType() == FilterTypes.RangeVar)
            return spatialToolInsertValidateInputRangeVar();
        else if (MapToolContext.filterType() == FilterTypes.Nearby)
            return spatialToolInsertValidateInputNearby();
        else return false;
    }

    function spatialToolInsertValidateInputWindow() {
        return (spatialToolInsertValidateTextField1() &&
            MapToolContext.getTextField2().val() != "" &&
            MapToolContext.getTextField3().val() != "");
    }

    function spatialToolInsertValidateInputRange() {
        return (spatialToolInsertValidateTextField1() &&
            MapToolContext.getTextField2().val() != "" &&
            MapToolContext.getTextField3().val() != "");
    }

    function spatialToolInsertValidateInputRangeVar() {
        return (spatialToolInsertValidateTextField1() &&
            MapToolContext.getTextField2().val().charAt(0) == "?" &&
            MapToolContext.getTextField3().val() != "");
    }

    function spatialToolInsertValidateInputNearby() {
        return (spatialToolInsertValidateTextField1() &&
            MapToolContext.getTextField2().val() != "" &&
            MapToolContext.getTextField3().val() != "");
    }
    
    function spatialToolInsertValidateTextField1() {
        var val = MapToolContext.getTextField1().val();
        if (!val)
            return false;
        return val.charAt(0) == "?";
    }

    function init_codemirror() {
        var myTextArea = document.getElementById("<%=TextQueryInput.ClientID %>");
        myCodeMirror = CodeMirror.fromTextArea(myTextArea, {
            lineWrapping: true,
            lineNumbers: true,
            indentUnit: 4,
            onChange: editorContentChanged    
        });
    }

    function editorContentChanged()
    {
        //alert("editorContentChanged");
    }

    function spatialToolClearClicked() {
        MapToolContext.clearInputFields();
        MapToolContext.removeEditOverlay();
    }
</script>

</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

    <p>
    Enter a geospatial enabled SPARQL query below to query the triple store.
    </p>
    <p>
    <asp:TextBox ID="TextQueryInput" runat="server" 
        TextMode="MultiLine" Width="725px">SELECT ?name ?location 
WHERE
{
	?e &lt;name&gt; ?name.
	?e &lt;gml:pos&gt; ?location.
}</asp:TextBox>
     </p>
    <p>
    <asp:Button ID="queryButton" runat="server" Text="Run Query" 
            onclick="queryButton_Click" /> <span id="insert_pattern_btn" class="sample_query">Insert Pattern</span>
            <span id="insert_spatial_btn" class="sample_query">Insert Spatial Filter</span>
    </p>

    <!-- tool_box -->
    <div id="tool_box" class="sample_query" style="display:none">
    <div style="text-align:right;margin:0px 2px 4px 0px"><span id="tool_box_close">Close</span></div>
    
    <!-- Pattern Tool Box -->
    <table id="pattern_tool_box" cellspacing="10"><tr>
    <td><div class="tool_field_label">Subject</div><input id="pattern_tool_sub_input" type="text" /></td>
    <td><div class="tool_field_label">Predicate</div>
        <select id="pattern_tool_pred_select">
            <option>gml:pos</option>
            <option>gn:countryCode</option>
            <option>gn:featureClass</option>
            <option>gn:featureCode</option>
            <option>gn:parentADM1</option>
            <option>gpw:address</option>
            <option>gpw:dieselPrice</option>
            <option>gpw:premiumPrice</option>
            <option>gpw:regularPrice</option>
            <option>gpw:website</option>
            <option>gstore:pos</option>
            <option>name</option>
            <option>rdf:type</option>
            <option>wgs84_pos:lat</option>
            <option>wgs84_pos:lat_long</option>
            <option>wgs84_pos:long</option>
        </select></td>
        <td><div class="tool_field_label">Object</div><input id="pattern_tool_obj_input" type="text" /></td>
        <td valign="bottom"><input id="patternToolInsertBtn" type="button" value="Insert"/></td>
        </tr>
        <tr>
        <td>
            <input id="showSubject" type="checkbox"/>Show subject</td>
        <td></td>
        <td><input id="showObject" type="checkbox" />Show object</td>
        </tr>
    </table>
    <!-- End Pattern Tool Box -->
    
    <!-- Spatial Tool Box -->
    <table id="spatial_tool_box" width="100%" style="display:none"><tr><td valign="top">
    <div class="tool_field">
    <div class="spatial_tool_field_label_1">Spatial Filter Type</div>
        <select id="<%=EidSpSelectField %>">
            <option>Window</option>
            <option>Range</option>
            <option>Range Variable Center</option>
            <option>Nearby</option>
        </select>
     </div>
     <div class="tool_field">
     <div class="tool_field_label" id="<%=EidSpTextFieldLabel1 %>">Variable Name</div>
         <input class="<%=ClSpTextField %>" id="<%=EidSpTextField1 %>" type="text" />
     </div>
     <div class="tool_field">
     <div class="tool_field_label" id="<%=EidSpTextFieldLabel2 %>">Lower Bound</div>
     <input class="<%=ClSpTextField %>" id="<%=EidSpTextField2 %>" type="text" />
     </div>
     <div class="tool_field">
     <div class="tool_field_label" id="<%=EidSpTextFieldLabel3 %>">Upper Bound</div>
     <input class="<%=ClSpTextField %>" id="<%=EidSpTextField3 %>" type="text" />
     </div>
        <input id="spatial_tool_insert_btn" type="button" value="Insert" />
        <input id="spatial_tool_clear" type="button" value="Clear" />
    </td>
    <td><div id="map"></div></td></tr></table>
    <!-- End Spatial Tool Box -->

    </div>
    

    <div class="sample_query"><table class="query_title_box"><tr><td>Show name, prices, address and coordinates of gas stations</td>
<td class="query_option_box">
            <span class="query_option_use">Use</span> | <span class="query_option_expand">More</span>
        </td></tr></table>    <div class="query_code">
<blockquote><pre>
SELECT ?name ?regPrice ?midPrice ?premPrice ?address ?coords
WHERE
{
    ?e &lt;name&gt; ?name.
    ?e &lt;gpw:regularPrice&gt; ?regPrice.
    ?e &lt;gpw:midegradePrice&gt; ?midPrice.
    ?e &lt;gpw:premiumPrice&gt; ?premPrice.
    ?e &lt;gml:pos&gt; ?coords.
}
</pre></blockquote>
        </div>
    </div>

    <div class="sample_query"><table class="query_title_box"><tr><td>Show prices, address and coordinates of gas stations named Chevron</td>
<td class="query_option_box">
            <span class="query_option_use">Use</span> | <span class="query_option_expand">More</span>
        </td></tr></table>    <div class="query_code">
<blockquote><pre>
SELECT ?name ?regPrice ?midPrice ?premPrice ?address ?coords
WHERE
{
    ?e &lt;name&gt; "Chevron".
    ?e &lt;gpw:regularPrice&gt; ?regPrice.
    ?e &lt;gpw:midegradePrice&gt; ?midPrice.
    ?e &lt;gpw:premiumPrice&gt; ?premPrice.
    ?e &lt;gml:pos&gt; ?coords.
}
</pre></blockquote>
    </div>
    </div>

    <div class="sample_query"><table class="query_title_box"><tr><td>Show prices, address and coordinates of gas stations named Exxon</td>
<td class="query_option_box">
            <span class="query_option_use">Use</span> | <span class="query_option_expand">More</span>
        </td></tr></table>
        <div class="query_code">
<blockquote><pre>
SELECT ?name ?regPrice ?midPrice ?premPrice ?address ?coords
WHERE
{
    ?e &lt;name&gt; "Exxon".
    ?e &lt;gpw:regularPrice&gt; ?regPrice.
    ?e &lt;gpw:midegradePrice&gt; ?midPrice.
    ?e &lt;gpw:premiumPrice&gt; ?premPrice.
    ?e &lt;gml:pos&gt; ?coords.
}
</pre></blockquote>
    </div></div>

    <div class="sample_query"><table class="query_title_box"><tr><td>Show prices, address and coordinates of gas stations within {(32.59, -85.49), (32.61, -85.47)}
    <span class="tag">Window</span></td>
<td class="query_option_box">
            <span class="query_option_use">Use</span> | <span class="query_option_expand">More</span>
        </td></tr></table>
        <div class="query_code">
<blockquote><pre>
SELECT ?name ?regPrice ?midPrice ?premPrice ?address ?coords
WHERE
{
    ?e &lt;name&gt; ?name.
    ?e &lt;gpw:regularPrice&gt; ?regPrice.
    ?e &lt;gpw:midegradePrice&gt; ?midPrice.
    ?e &lt;gpw:premiumPrice&gt; ?premPrice.
    ?e &lt;gml:pos&gt; ?coords.
    within(?coords, 32.59558544320275, -85.49098796728858, 32.61227040779389, -85.47391829113052)
}
</pre></blockquote>
    </div></div>


    <div class="sample_query"><table class="query_title_box"><tr><td>
        Show prices, address and coordinates of gas stations within adfasdf asdfasdfsadfa
        dafdad adfasdfa asdfa adf adfa sdf {(32.59, -85.49), (32.61, -85.47)}</td>
        <td class="query_option_box">
            <span class="query_option_use">Use</span> | <span class="query_option_expand">More</span>
        </td></tr></table>
        <div class="query_code">
            <blockquote>
                <pre>
SELECT ?name ?regPrice ?midPrice ?premPrice ?address ?coords
WHERE
{
    ?e &lt;name&gt; ?name.
    ?e &lt;gpw:regularPrice&gt; ?regPrice.
    ?e &lt;gpw:midegradePrice&gt; ?midPrice.
    ?e &lt;gpw:premiumPrice&gt; ?premPrice.
    ?e &lt;gml:pos&gt; ?coords.
    within(?coords, 32.59558544320275, -85.49098796728858, 32.61227040779389, -85.47391829113052)
}
</pre>
            </blockquote>
        </div>
    </div>

</asp:Content>
