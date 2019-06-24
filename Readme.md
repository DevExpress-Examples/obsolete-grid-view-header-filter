<!-- default file list -->
*Files to look at*:

* [Default.aspx](./CS/PivotGridFiltering/Default.aspx) (VB: [Default.aspx](./VB/PivotGridFiltering/Default.aspx))
* [Default.aspx.cs](./CS/PivotGridFiltering/Default.aspx.cs) (VB: [Default.aspx.vb](./VB/PivotGridFiltering/Default.aspx.vb))
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

<p>The external ASPxPopupControl is used as an emulator of the built-in Header Filter. The popup hosts &ldquo;filter items&rdquo; represented by checkboxes.</p>
<p>ASPxPopupControl is populated on the server side via its built-in callback (v2011 vol 1) with the checkbox' displayed values. These values are unique for every DataColumn (unique values are retrieved programmatically from the same datasource via the SELECT DISTINCT command).</p>
<p>The popup control is customized as a built-in Header Filter via newest features (Scrolling, Min Max dimensions 11.1):<br> <a href="http://community.devexpress.com/blogs/aspnet/archive/2011/03/30/asp-net-popup-control-lightweight-rendering-scroll-bars-css3-and-more-coming-soon-in-v2011-vol-1.aspx"><u>ASP.NET Popup Control - Lightweight Render, Scroll Bars, CSS3, MVC and more (available now in v2011.1)</u></a></p>
<p>Clicking the &ldquo;OK&rdquo; button collects values of all selected checkboxes and passes this data within the ASPxGridView&rsquo;s CustomCallback. The combined filter expression is applied to the ASPxGridView on the server side.</p>

<br/>


