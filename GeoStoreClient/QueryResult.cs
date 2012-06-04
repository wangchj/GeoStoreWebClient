using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using GeoStoreCommon;

namespace GeoStoreClient
{
    public class QueryResult
    {
        public QueryResultStatus Status { get; private set; }
        public DataTable DataTable { get; private set; }
        public string Message { get; private set; }

        public QueryResult(QueryResultStatus status, DataTable table, string message)
        {
            Status = status;
            DataTable = table;
            Message = message;
        }
    }
}
