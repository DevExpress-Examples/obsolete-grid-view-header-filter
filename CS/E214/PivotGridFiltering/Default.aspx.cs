using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using DevExpress.Web.ASPxGridView;
using System.Collections.Generic;
using DevExpress.Web.ASPxEditors;
using DevExpress.Web.ASPxUploadControl;
using DevExpress.Web.ASPxMenu;
using System.Drawing;
using System.Globalization;
using System.IO;
using System.Drawing.Imaging;
using DevExpress.Data.Filtering;

public partial class _Default : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e) {
    }

    bool IsRowVisible(string fieldName, object value) {
        string[] field = new string[] {fieldName};
        for(int i = 0;i < ASPxGridView1.VisibleRowCount;i++) {
            if(Comparer.Default.Compare(ASPxGridView1.GetRowValues(i, field), value) == 0)
                return true;
        }
        return false;
    }

    protected void ASPxCallback1_Callback(object source, DevExpress.Web.ASPxCallback.CallbackEventArgs e) {
        GridViewDataColumn column = ASPxGridView1.Columns[e.Parameter] as GridViewDataColumn;
        AccessDataSource ds = new AccessDataSource();
        ds.DataFile = AccessDataSource1.DataFile;
        ds.SelectCommand = "Select Distinct " + e.Parameter + " from Categories";
        DataView dv = ds.Select(DataSourceSelectArguments.Empty) as DataView;
        for(int i = 0;i < dv.Count;i++) {
            ASPxCheckBox checkBox = new ASPxCheckBox();
            checkBox.ClientInstanceName = "cb_" + i.ToString();
            checkBox.Text = dv[i][0].ToString();
            checkBox.Attributes["caption"] = checkBox.Text;
            if(IsRowVisible(e.Parameter, dv[i][0]))
                checkBox.Checked = true;
            ASPxPanel2.Controls.Add(checkBox);
        }
        e.Result = DevExpress.Web.ASPxClasses.Internal.RenderUtils.GetRenderResult(ASPxPanel1);
    }
    protected void ASPxGridView1_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e) {
        ASPxGridView gridView = (sender as ASPxGridView);
        if(e.Parameters == "Clear") {
            gridView.FilterExpression = string.Empty;
            return;
        }
        string[] filterString = e.Parameters.Split(new char[] {'|'});
        string fieldName = filterString[0];
        List<string> values = new List<string>();
        for(int i = 1;i < filterString.Length;i++)
            values.Add(filterString[i].Trim());
        gridView.FilterExpression = new InOperator(fieldName, values).ToString();
    }
}
