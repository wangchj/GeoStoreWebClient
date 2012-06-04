using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GeoStoreClient;
using GeoStoreCommon;

namespace GeoStoreWebClient
{
    public partial class QueryResultView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Result"] == null)
                Response.Redirect("Default.aspx");

            //Get the results
            QueryResult queryResult = (QueryResult)Session["Result"];
            string query = (string)Session["Query"];
            SparqlQuery sparql = new SparqlQuery(query);

            if (queryResult.Status == QueryResultStatus.Ok)
            {
                GridView1.DataSource = queryResult.DataTable;
                GridView1.DataBind();
            }
            else
            {
                ErrorLiteral.Text = queryResult.Message;
            }
        }
    }
}