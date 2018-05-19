<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxTreeView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v11.1, Version=11.1.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1, Version=11.1.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <style type="text/css">
        .popupControlContentControl { padding: 0px; }
    </style>

    <script type="text/javascript">
        var popupElement = null;
        var field = "";

        function OnColumnClick(element, fieldName) {
            popupElement = element;
            field = fieldName;

            popup.PerformCallback(fieldName);
        }
        function OnPopupEndCallback(s, e) {
            s.ShowAtElement(popupElement);
        }
        function FilterGrid() {
            var filterString = field + "|";
            for (var i = 0; i < popup.cpCheckBoxCount; i++) {
                var name = "cb_" + i.toString();
                try {
                    var editor = eval(name);
                    if (editor && editor.GetChecked())
                        filterString += editor.GetText() + "|";
                }
                catch (e) { break; }
            }
            grid.PerformCallback(filterString);
        }
    </script>

</head>
<body>
    <form id="mainForm" runat="server">
    <div>
        <dx:ASPxGridView ID="gridView" runat="server" AutoGenerateColumns="False" ClientInstanceName="grid"
            DataSourceID="dataSource" KeyFieldName="CategoryID" OnCustomCallback="gridView_CustomCallback">
            <Columns>
                <dx:GridViewDataTextColumn FieldName="CategoryID" VisibleIndex="0">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="CategoryName" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Description" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
            </Columns>
            <Templates>
                <HeaderCaption>
                    <div style="float: left;">
                        <%#Eval("FieldName")%>
                    </div>
                    <div style="float: right;">
                        <img alt="" src="Images/Key.bmp" onclick="OnColumnClick(this, '<%#Eval("FieldName")%>');" />
                    </div>
                </HeaderCaption>
            </Templates>
        </dx:ASPxGridView>
    </div>
    <dx:ASPxPopupControl ID="popupControl" runat="server" AllowResize="true" ClientInstanceName="popup"
        FooterText="" Height="350px" MinHeight="280px" MinWidth="270px" PopupVerticalAlign="Below"
        RenderMode="Lightweight" ShowFooter="true" ShowHeader="false" ScrollBars="Vertical"
        Width="350px" OnWindowCallback="popupControl_WindowCallback">
        <ContentCollection>
            <dx:PopupControlContentControl ID="MainPopupControlContentControlMain" runat="server"
                CssClass="popupControlContentControl">
                <dx:ASPxPanel ID="CheckBoxPanel" runat="server">
                </dx:ASPxPanel>
                <br />
                <table width="100%">
                    <tr>
                        <td width="33%">
                            <dx:ASPxButton ID="btnOK" runat="server" Text="OK" AutoPostBack="False" Width="100%">
                                <ClientSideEvents Click="function(s, e) { 
                                    FilterGrid();
                                    popup.Hide();
                                }" />
                            </dx:ASPxButton>
                        </td>
                        <td width="33%">
                            <dx:ASPxButton ID="btnCancel" runat="server" Text="Cancel" AutoPostBack="False" Width="100%">
                                <ClientSideEvents Click="function(s, e) { 
                                    popup.Hide(); 
                                }" />
                            </dx:ASPxButton>
                        </td>
                        <td width="34%">
                            <dx:ASPxButton ID="btnClear" runat="server" Text="Clear" AutoPostBack="False" Width="100%">
                                <ClientSideEvents Click="function(s, e) { 
                                    grid.PerformCallback('Clear');
                                    popup.Hide(); 
                                }" />
                            </dx:ASPxButton>
                        </td>
                    </tr>
                </table>
            </dx:PopupControlContentControl>
        </ContentCollection>
        <ClientSideEvents EndCallback="OnPopupEndCallback" />
    </dx:ASPxPopupControl>
    <asp:AccessDataSource ID="dataSource" runat="server" DataFile="~/App_Data/nwind.mdb"
        SelectCommand="SELECT [CategoryID], [CategoryName], [Description] FROM [Categories]">
    </asp:AccessDataSource>
    </form>
</body>
</html>