using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Data;
using GeoStoreClient;

namespace GeoStoreWebClient
{
    public partial class Query : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void queryButton_Click(object sender, EventArgs e)
        {
            IPAddress ipAddr = IPAddress.Parse("131.204.27.102");
            IPEndPoint endPoint = new IPEndPoint(ipAddr, 2700);
            GSClient client = new GSClient(endPoint);
            QueryResult result = client.RunQuery(TextQueryInput.Text);
            client.Close();

            Session["Query"] = TextQueryInput.Text;
            Session["Result"] = result;
            Response.Redirect("QueryResultView.aspx");
        }
    }
}
