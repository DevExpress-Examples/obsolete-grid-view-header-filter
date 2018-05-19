<%@ Page Language="vb" AutoEventWireup="true" CodeFile="Default.aspx.vb" Inherits="_Default"  MasterPageFile="~/MasterPage.master"%>

<%@ Register Assembly="DevExpress.Web.v8.1, Version=8.1.6.0, Culture=neutral, PublicKeyToken=9B171C9FD64DA1D1"
	Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dxcb" %>

<%@ Register Assembly="DevExpress.Web.v8.1, Version=8.1.6.0, Culture=neutral, PublicKeyToken=9B171C9FD64DA1D1"
	Namespace="DevExpress.Web.ASPxNewsControl" TagPrefix="dxnc" %>
<%@ Register Assembly="DevExpress.Web.v8.1, Version=8.1.6.0, Culture=neutral, PublicKeyToken=9B171C9FD64DA1D1"
	Namespace="DevExpress.Web.ASPxDataView" TagPrefix="dxdv" %>

<%@ Register Assembly="DevExpress.Web.v8.1, Version=8.1.6.0, Culture=neutral, PublicKeyToken=9B171C9FD64DA1D1"
	Namespace="DevExpress.Web.ASPxRoundPanel" TagPrefix="dxrp" %>

<%@ Register Assembly="DevExpress.Web.v8.1, Version=8.1.6.0, Culture=neutral, PublicKeyToken=9B171C9FD64DA1D1"
	Namespace="DevExpress.Web.ASPxTimer" TagPrefix="dxt" %>

<%@ Register Assembly="DevExpress.Web.v8.1, Version=8.1.6.0, Culture=neutral, PublicKeyToken=9B171C9FD64DA1D1"
	Namespace="DevExpress.Web.ASPxCloudControl" TagPrefix="dxcc" %>

<%@ Register Assembly="DevExpress.Web.v8.1, Version=8.1.6.0, Culture=neutral, PublicKeyToken=9B171C9FD64DA1D1"
	Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dxtc" %>
<%@ Register Assembly="DevExpress.Web.v8.1, Version=8.1.6.0, Culture=neutral, PublicKeyToken=9B171C9FD64DA1D1"
	Namespace="DevExpress.Web.ASPxClasses" TagPrefix="dxw" %>

<%@ Register Assembly="DevExpress.Web.ASPxGridView.v8.1.Export, Version=8.1.6.0, Culture=neutral, PublicKeyToken=9B171C9FD64DA1D1"
	Namespace="DevExpress.Web.ASPxGridView.Export" TagPrefix="dxwgv" %>

<%@ Register Assembly="DevExpress.Web.ASPxTreeList.v8.1, Version=8.1.6.0, Culture=neutral, PublicKeyToken=9B171C9FD64DA1D1"
	Namespace="DevExpress.Web.ASPxTreeList" TagPrefix="dxwtl" %>

<%@ Register Assembly="DevExpress.Web.v8.1, Version=8.1.6.0, Culture=neutral, PublicKeyToken=9B171C9FD64DA1D1"
	Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dxm" %>
<%@ Register Assembly="DevExpress.Web.v8.1, Version=8.1.6.0, Culture=neutral, PublicKeyToken=9B171C9FD64DA1D1"
	Namespace="DevExpress.Web.ASPxSiteMapControl" TagPrefix="dxsm" %>
<%@ Register Assembly="DevExpress.Web.v8.1, Version=8.1.6.0, Culture=neutral, PublicKeyToken=9B171C9FD64DA1D1"
	Namespace="DevExpress.Web.ASPxNavBar" TagPrefix="dxnb" %>

<%@ Register Assembly="DevExpress.Web.v8.1, Version=8.1.6.0, Culture=neutral, PublicKeyToken=9B171C9FD64DA1D1"
	Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dxpc" %>

<%@ Register Assembly="DevExpress.Web.v8.1, Version=8.1.6.0, Culture=neutral, PublicKeyToken=9B171C9FD64DA1D1"
	Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>

<%@ Register Assembly="DevExpress.Web.v8.1, Version=8.1.6.0, Culture=neutral, PublicKeyToken=9B171C9FD64DA1D1"
	Namespace="DevExpress.Web.ASPxCallbackPanel" TagPrefix="dxcp" %>

<%@ Register Assembly="DevExpress.Web.ASPxGridView.v8.1, Version=8.1.6.0, Culture=neutral, PublicKeyToken=9B171C9FD64DA1D1"
	Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dxwgv" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v8.1, Version=8.1.6.0, Culture=neutral, PublicKeyToken=9B171C9FD64DA1D1"
	Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>


<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" ID="CC" runat="Server">

<script type="text/javascript">
	var popupElement = null;
	var field = "";
	function OnColumnClick(element, fieldName) {
		field = fieldName; 
		popupElement = element;
		callback.SendCallback(fieldName);
	}

	function FilterGrid() { 
		var filterString = field + "|";
		for(var i = 0; i < 100; i++) {
			var name = "cb_" + i.toString();
			try {
				var editor = eval("window." + name);
				if(editor && editor.GetChecked())
					if(!__aspxIE)
						filterString += editor.GetMainElement().textContent + "|";
					else
						filterString += editor.GetMainElement().caption + "|";
			}
			catch (e){ break;}
		}
		grid.PerformCallback(filterString);
	}
</script>

	&nbsp;&nbsp;<asp:AccessDataSource ID="AccessDataSource1" runat="server" DataFile="~/App_Data/nwind.mdb"
		SelectCommand="SELECT [CategoryID], [CategoryName], [Description], [Picture] FROM [Categories]">
	</asp:AccessDataSource>
	<dxcb:ASPxCallback ID="ASPxCallback1" runat="server" ClientInstanceName="callback"
		OnCallback="ASPxCallback1_Callback">
		<ClientSideEvents CallbackComplete="function(s,e) {
			popup.SetContentHtml(e.result);
			popup.ShowAtElement(popupElement);
		}"/>
	</dxcb:ASPxCallback>
	<br />
	&nbsp;<dxwgv:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False"
		DataSourceID="AccessDataSource1" KeyFieldName="CategoryID" ClientInstanceName="grid" OnCustomCallback="ASPxGridView1_CustomCallback">
		<Templates>
				<HeaderCaption>
					<%#Eval("Caption")%> <img src="images/Key.bmp" onclick="OnColumnClick(this, '<%#Eval("FieldName")%>')"/>
				</HeaderCaption>
		</Templates>
		<Columns>
			<dxwgv:GridViewDataTextColumn FieldName="CategoryID" ReadOnly="True" VisibleIndex="1" Name="col1" Caption="Category ID">
				<EditFormSettings Visible="False" />
			</dxwgv:GridViewDataTextColumn>
			<dxwgv:GridViewDataTextColumn FieldName="CategoryName" VisibleIndex="2" Name="col2" Caption="Category Name">
			</dxwgv:GridViewDataTextColumn>
			<dxwgv:GridViewDataTextColumn FieldName="Description" VisibleIndex="3" Name="col3" Caption="Description">
			</dxwgv:GridViewDataTextColumn>
		</Columns>
	</dxwgv:ASPxGridView>
	<dxpc:ASPxPopupControl ID="ASPxPopupControl1" runat="server" ClientInstanceName="popup" HeaderText="Filter">
		<ContentCollection>
			<dxpc:PopupControlContentControl runat="server">
	<dxp:ASPxPanel ID="ASPxPanel1" runat="server" Width="200px">
		<PanelCollection>
			<dxp:PanelContent runat="server" _designerRegion="0">
				<dxp:ASPxPanel ID="ASPxPanel2" runat="server" Width="200px">
					<PanelCollection>
						<dxp:PanelContent runat="server">
						</dxp:PanelContent>
					</PanelCollection>
				</dxp:ASPxPanel>
				<br />
				<table width="100%">
					<tr>
						<td width="33%">
							<dxe:ASPxButton ID="ASPxButton1" runat="server" Text="OK" AutoPostBack="False" Width="100%">
								<ClientSideEvents Click="function(s,e) {FilterGrid(); popup.Hide();}"/>
							</dxe:ASPxButton>
						</td>
						<td width="33%">
							<dxe:ASPxButton ID="ASPxButton2" runat="server" Text="Cancel" AutoPostBack="False" Width="100%">
								<ClientSideEvents Click="function(s,e) {popup.Hide();}"/>
							</dxe:ASPxButton>
						</td>                
						<td width="34%">
							<dxe:ASPxButton ID="ASPxButton3" runat="server" Text="Clear" AutoPostBack="False" Width="100%">
								<ClientSideEvents Click="function(s,e) {grid.PerformCallback('Clear');popup.Hide();}"/>
							</dxe:ASPxButton>
						</td>                        

					</tr>
				</table>
			</dxp:PanelContent>
		</PanelCollection>
	</dxp:ASPxPanel>
			</dxpc:PopupControlContentControl>
		</ContentCollection>
	</dxpc:ASPxPopupControl>

</asp:Content>
