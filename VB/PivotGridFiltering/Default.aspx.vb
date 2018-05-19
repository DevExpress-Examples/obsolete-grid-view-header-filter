Imports Microsoft.VisualBasic
Imports System
Imports System.Data
Imports System.Configuration
Imports System.Collections
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Web.UI.HtmlControls
Imports DevExpress.Web.ASPxGridView
Imports System.Collections.Generic
Imports DevExpress.Web.ASPxEditors
Imports DevExpress.Web.ASPxUploadControl
Imports DevExpress.Web.ASPxMenu
Imports System.Drawing
Imports System.Globalization
Imports System.IO
Imports System.Drawing.Imaging
Imports DevExpress.Data.Filtering

Partial Public Class _Default
	Inherits System.Web.UI.Page

	Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
	End Sub

	Private Function IsRowVisible(ByVal fieldName As String, ByVal value As Object) As Boolean
		Dim field() As String = {fieldName}
		For i As Integer = 0 To ASPxGridView1.VisibleRowCount - 1
			If Comparer.Default.Compare(ASPxGridView1.GetRowValues(i, field), value) = 0 Then
				Return True
			End If
		Next i
		Return False
	End Function

	Protected Sub ASPxCallback1_Callback(ByVal source As Object, ByVal e As DevExpress.Web.ASPxCallback.CallbackEventArgs)
		Dim column As GridViewDataColumn = TryCast(ASPxGridView1.Columns(e.Parameter), GridViewDataColumn)
		Dim ds As New AccessDataSource()
		ds.DataFile = AccessDataSource1.DataFile
		ds.SelectCommand = "Select Distinct " & e.Parameter & " from Categories"
		Dim dv As DataView = TryCast(ds.Select(DataSourceSelectArguments.Empty), DataView)
		For i As Integer = 0 To dv.Count - 1
			Dim checkBox As New ASPxCheckBox()
			checkBox.ClientInstanceName = "cb_" & i.ToString()
			checkBox.Text = dv(i)(0).ToString()
			checkBox.Attributes("caption") = checkBox.Text
			If IsRowVisible(e.Parameter, dv(i)(0)) Then
				checkBox.Checked = True
			End If
			ASPxPanel2.Controls.Add(checkBox)
		Next i
		e.Result = DevExpress.Web.ASPxClasses.Internal.RenderUtils.GetRenderResult(ASPxPanel1)
	End Sub
	Protected Sub ASPxGridView1_CustomCallback(ByVal sender As Object, ByVal e As ASPxGridViewCustomCallbackEventArgs)
		Dim gridView As ASPxGridView = (TryCast(sender, ASPxGridView))
		If e.Parameters = "Clear" Then
			gridView.FilterExpression = String.Empty
			Return
		End If
		Dim filterString() As String = e.Parameters.Split(New Char() {"|"c})
		Dim fieldName As String = filterString(0)
		Dim values As List(Of String) = New List(Of String)()
		For i As Integer = 1 To filterString.Length - 1
			values.Add(filterString(i).Trim())
		Next i
		gridView.FilterExpression = New InOperator(fieldName, values).ToString()
	End Sub
End Class
