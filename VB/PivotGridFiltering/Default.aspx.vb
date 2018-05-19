Imports System
Imports System.Data
Imports System.Collections
Imports System.Collections.Generic
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports DevExpress.Web.ASPxGridView
Imports DevExpress.Web.ASPxPopupControl
Imports DevExpress.Web.ASPxEditors
Imports DevExpress.Data.Filtering

Partial Public Class _Default
    Inherits Page

    Private Function IsRowVisible(ByVal fieldName As String, ByVal value As Object) As Boolean
        Dim field() As String = { fieldName }
        For i As Integer = 0 To gridView.VisibleRowCount - 1
            If Comparer.Default.Compare(gridView.GetRowValues(i, field), value) = 0 Then
                Return True
            End If
        Next i
        Return False
    End Function
    Protected Sub popupControl_WindowCallback(ByVal source As Object, ByVal e As PopupWindowCallbackArgs)
        Dim pc As ASPxPopupControl = DirectCast(source, ASPxPopupControl)

        Dim fieldName As String = e.Parameter
        Dim column As GridViewDataColumn = CType(gridView.Columns(fieldName), GridViewDataColumn)

        Dim ds As New AccessDataSource()
        ds.DataFile = dataSource.DataFile
        ds.SelectCommand = String.Format("SELECT DISTINCT {0} FROM [Categories]", fieldName)
        Dim dv As DataView = TryCast(ds.Select(DataSourceSelectArguments.Empty), DataView)

        For i As Integer = 0 To dv.Count - 1
            Dim checkBox As New ASPxCheckBox()
            checkBox.ClientInstanceName = "cb_" & i.ToString()
            checkBox.Text = dv(i)(0).ToString()
            checkBox.Checked = IsRowVisible(e.Parameter, dv(i)(0))
            CheckBoxPanel.Controls.Add(checkBox)
        Next i
        pc.JSProperties("cpCheckBoxCount") = dv.Count
    End Sub
    Protected Sub gridView_CustomCallback(ByVal sender As Object, ByVal e As ASPxGridViewCustomCallbackEventArgs)
        Dim gv As ASPxGridView = DirectCast(sender, ASPxGridView)

        If e.Parameters = "Clear" Then
            gv.FilterExpression = String.Empty
            Return
        End If

        Dim filterString() As String = e.Parameters.Split(New Char() { "|"c })
        Dim fieldName As String = filterString(0)

        Dim values As New List(Of String)()
        For i As Integer = 1 To filterString.Length - 1
            values.Add(filterString(i).Trim())
        Next i

        gv.FilterExpression = (New InOperator(fieldName, values)).ToString()
    End Sub
End Class