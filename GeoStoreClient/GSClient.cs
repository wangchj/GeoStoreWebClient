using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.IO;
using System.Net;
using System.Net.Sockets;
using System.Data;
using GeoStoreCommon;

namespace GeoStoreClient
{
    public class GSClient : TcpClient
    {
        private StreamReader reader;
        //private StreamWriter writer;

        public GSClient(IPEndPoint server)
            : base()
        {
            Connect(server);
            reader = new StreamReader(GetStream());
            //writer = new StreamWriter(GetStream());
        }

        public void Close()
        {
            //Send Disconnect command to server.
            SendLine(NetCmd.Disconnect);
        }

        public QueryResult RunQuery(string query)
        {
            query = CleanQueryStr(query);

            if (string.IsNullOrEmpty(query))
                return new QueryResult(QueryResultStatus.Error, null, "Empty query.");

            SendQuery(query);

            string status = reader.ReadLine();
            if (status == QueryResultStr.Ok)
            {
                //Read results and create data table.
                DataTable table = ReadResults(query);
                return new QueryResult(QueryResultStatus.Ok, table, null);
            }
            else
            {
                //Read error messages.
                StringBuilder errorMsg = new StringBuilder();
                for (string s = reader.ReadLine(); s != string.Empty;
                    s = reader.ReadLine())
                {
                    if (errorMsg.Length != 0)
                        errorMsg.AppendLine();
                    errorMsg.Append(s);
                }
                return new QueryResult(QueryResultStatus.Error, null,
                    errorMsg.ToString());
            }
        }

        private void Send(string s)
        {
            // Translate the passed message into ASCII and store it as a Byte array.
            byte[] data = Encoding.ASCII.GetBytes(s);
            // Get a client stream for reading and writing.
            //  Stream stream = client.GetStream();
            NetworkStream stream = GetStream();
            stream.Write(data, 0, data.Length);
        }

        private void SendLine(string s)
        {
            s += Environment.NewLine;
            Send(s);
        }

        private void SendQuery(string query)
        {
            query = query.Trim();
            query += Environment.NewLine + Environment.NewLine;
            Send(query);
        }

        /// <summary>
        /// Reads query result records from the network stream.
        /// </summary>
        /// <param name="query">The original query. Used to populate table columns
        /// headers.</param>
        /// <returns>Records in DataTable.</returns>
        private DataTable ReadResults(string query)
        {
            SparqlQuery sparql = new SparqlQuery(query);
            //Get the projection column names and make table that hold result.
            SelectionTermCollection selectTerms = sparql.SelectionTerms;
            DataTable table = new DataTable();
            foreach (SelectionTerm term in selectTerms)
                table.Columns.Add(term.Name, typeof(string));
            
            //Read the result into table.
            for (string result = reader.ReadLine(); result != string.Empty;
                result = reader.ReadLine())
            {
                string[] fields = ResultRowParser.GetAllFields(result);

                DataRow row = table.NewRow();
                for (int i = 0; i < fields.Length; i++)
                    row[i] = fields[i];
                table.Rows.Add(row);
            }

            return table;
        }

        /// <summary>
        /// Remove new lines and consolidate multiple spaces into one.
        /// </summary>
        /// <param name="queryStr">Original query string.</param>
        /// <returns>Result query string.</returns>
        private static string CleanQueryStr(string queryStr)
        {
            queryStr = queryStr.Replace(Environment.NewLine, " ");
            queryStr = Regex.Replace(queryStr, @"\s{2,}", " ");
            return queryStr.Trim();
        }
    }
}
