using System;
using System.Data;
using System.Collections;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web.ASPxGridView;
using DevExpress.Web.ASPxPopupControl;
using DevExpress.Web.ASPxEditors;
using DevExpress.Data.Filtering;

public partial class _Default : Page {
    private bool IsRowVisible(string fieldName, object value) {
        string[] field = new string[] { fieldName };
        for (int i = 0; i < gridView.VisibleRowCount; i++) {
            if (Comparer.Default.Compare(gridView.GetRowValues(i, field), value) == 0)
                return true;
        }
        return false;
    }
    protected void popupControl_WindowCallback(object source, PopupWindowCallbackArgs e) {
        ASPxPopupControl pc = (ASPxPopupControl)source;

        string fieldName = e.Parameter;
        GridViewDataColumn column = (GridViewDataColumn)gridView.Columns[fieldName];

        AccessDataSource ds = new AccessDataSource();
        ds.DataFile = dataSource.DataFile;
        ds.SelectCommand = string.Format("SELECT DISTINCT {0} FROM [Categories]", fieldName);
        DataView dv = ds.Select(DataSourceSelectArguments.Empty) as DataView;

        for (int i = 0; i < dv.Count; i++) {
            ASPxCheckBox checkBox = new ASPxCheckBox();
            checkBox.ClientInstanceName = "cb_" + i.ToString();
            checkBox.Text = dv[i][0].ToString();
            checkBox.Checked = IsRowVisible(e.Parameter, dv[i][0]);
            CheckBoxPanel.Controls.Add(checkBox);
        }
        pc.JSProperties["cpCheckBoxCount"] = dv.Count;
    }
    protected void gridView_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e) {
        ASPxGridView gv = (ASPxGridView)sender;

        if (e.Parameters == "Clear") {
            gv.FilterExpression = string.Empty;
            return;
        }

        string[] filterString = e.Parameters.Split(new char[] { '|' });
        string fieldName = filterString[0];

        List<string> values = new List<string>();
        for (int i = 1; i < filterString.Length; i++)
            values.Add(filterString[i].Trim());

        gv.FilterExpression = new InOperator(fieldName, values).ToString();
    }
}