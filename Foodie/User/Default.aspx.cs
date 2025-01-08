using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Foodie.Admin;
using System.Drawing;
using System.Security.Cryptography;

namespace Foodie.User
{
    public partial class Default : System.Web.UI.Page
    {

        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                getCategories();
                getReviews();
            }
        }

        private void getCategories()
        {
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Category_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "ACTIVECAT");
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rCategory.DataSource = dt;
            rCategory.DataBind();

        }


        private void getReviews()
        {
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Review", con);
            cmd.Parameters.AddWithValue("@Action", "SELECT");
            //cmd.Parameters.AddWithValue("@ReviewId", Session["reviewId"]);
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rReview.DataSource = dt;
            rReview.DataBind();
            //if (dt.Rows.Count == 1)
            //{
            //    Session["review"] = dt.Rows[0]["Review"].ToString();
            //    Session["name"] = dt.Rows[0]["Name"].ToString();
            //    Session["address"] = dt.Rows[0]["Address"].ToString();
            //    Session["postedOn"] = dt.Rows[0]["PostedOn"].ToString();
            //    Session["imageUrl"] = dt.Rows[0]["ImageUrl"].ToString();
            //}
        }


    }

}