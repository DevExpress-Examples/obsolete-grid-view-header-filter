<!-- default file list -->
*Files to look at*:

* [Default.aspx](./CS/PivotGridFiltering/Default.aspx)
* [Default.aspx.cs](./CS/PivotGridFiltering/Default.aspx.cs)
* [MasterPage.master](./CS/PivotGridFiltering/MasterPage.master)
* [MasterPage.master.cs](./CS/PivotGridFiltering/MasterPage.master.cs)
<!-- default file list end -->
# OBSOLETE - Implementing Pivot Grid like filtration style
<!-- run online -->
**[[Run Online]](https://codecentral.devexpress.com/e214)**
<!-- run online end -->


<p>This example illustrates how to implement a custom popup filter with muti-select capabilities (like the ASPxPivotGrid provides).</p><p><strong>N</strong><strong>ote:</strong> Starting with version v12.1, this feature is available out-of-the-box:<br />
<a href="http://www.devexpress.com/Subscriptions/DXperience/WhatsNew2012v1/index.xml?page=45"><u>New Multi-Select Mode for Header Filter</u></a><br />
Set the <a href="http://documentation.devexpress.com/#AspNet/DevExpressWebASPxGridViewHeaderFilterModeEnumtopic"><u>GridViewDataColumn.Settings.HeaderFilterMode</u></a> property to <strong>CheckedList</strong> for the required data column to enable the required Header Filter Mode.<br />
The online <a href="http://demos.devexpress.com/ASPxGridViewDemos/Filtering/HeaderFilter.aspx"><u>Filtering - Header Filter</u></a> demo illustrates this feature in action.</p>


<h3>Description</h3>

<p><strong>Note:</strong> This approach is now <strong>obsolete</strong>.</p><p>To implement this filtration mode use the following workaround:</p><p>add an &lt;img&gt; tag to the column&#39;s CaptionTemplate Container, then handle its click event and show the PopupControl containing all required items.  It is possible to populate the ASPxPopupControl with items using the ASPxCallback control.  You should send a callback to the server, add all the required items and finally return the rendering result to the client.  When the end-user selects several items and clicks the OK button, send a GridView&#39;s callback to the server and filter it just as you need.</p>

<br/>


