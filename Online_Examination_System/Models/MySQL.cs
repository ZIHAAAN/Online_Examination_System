using System;
using System.Collections.Generic;
using MySql.Data.MySqlClient;
using System.Linq;
using System.Web;
using System.Diagnostics;

namespace Online_Examination_System.Models
{
    public class MySQL
    {
        private string connectionString;

        public MySQL()
        {
            this.connectionString =  $"server=localhost;user=root;password=123456;database=examsystem";
        }

        public int ExecuteNonQuery(string query)
        {
            int rowsAffected = 0;   //I changed here, make it return how many rows affected.
            using (var connection = new MySqlConnection(connectionString))
            {
                connection.Open();
                using (var command = new MySqlCommand(query, connection))
                {
                    rowsAffected = command.ExecuteNonQuery();
                }
            }
            return rowsAffected;
        }

        public object ExecuteScalar(string query)   //用于执行查询并返回结果集的第一行第一列的值，比如返回一个聚合函数的结果。
        {
            using (var connection = new MySqlConnection(connectionString))
            {
                connection.Open();
                using (var command = new MySqlCommand(query, connection))
                {
                    return command.ExecuteScalar();
                }
            }
        }

        public MySqlDataReader ExecuteReader(string query)  //return a MySqlDataReader object, use for multiple result query
        {
            var connection = new MySqlConnection(connectionString);
            connection.Open();
            var command = new MySqlCommand(query, connection);
            return command.ExecuteReader();
        }
    }
}