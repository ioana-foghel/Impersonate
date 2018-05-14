<%@ Page Language="vb" AutoEventWireup="false" ValidateRequest="false" CodeBehind="EditTags.aspx.vb" Inherits="Dynamicweb.Admin.EditTags" %>

<%@ Import Namespace="Dynamicweb.SystemTools" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="Dynamicweb" %>



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
		<title>EditTags</title>
		<meta content="True" name="vs_snapToGrid">
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="../../Stylesheet.css" type="text/css" rel="STYLESHEET">
</head>
<body onload="GridScroll()">
		<form id="Form1" method="post" runat="server">
			&nbsp;
			<table id="Table1" cellspacing="1" cellpadding="1" border="0">
                <tr>
                    <td>
                        <asp:Button ID="btnSearchAndEdit" runat="server" Text="Tags"></asp:Button></td>
                    <td>
                        <asp:Button ID="btnCreateSystem" runat="server" Text="Systems"></asp:Button></td>
                    <td>
                        <asp:Button ID="btnCreateFunction" runat="server" Text="Functions"></asp:Button></td>
                </tr>
                <tr>
                    <td colspan="3">
                        <asp:Panel ID="panSearchAndEdit" runat="server" BorderWidth="0" Visible="False">
                            <br>
                            <br>
							<%=Dynamicweb.SystemTools.Gui.GroupboxStart("Search")%>
                            <table id="Table3" cellspacing="1" cellpadding="1" width="576" border="0">
                                <tr>
                                    <td style="width: 107px">
                                        <asp:Label ID="Label1" runat="server">Function</asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="txtxSFunction" runat="server" Width="150px"></asp:TextBox></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td style="width: 107px">
                                        <asp:Label ID="Label2" runat="server">Page</asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="txtxSPage" runat="server" Width="150px"></asp:TextBox>&nbsp;or
										<asp:DropDownList ID="ddlSearchPages" runat="server" Width="150px"></asp:DropDownList></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td style="width: 107px">
                                        <asp:Label ID="Label3" runat="server">TemplateFile</asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="txtxSTemplateFile" runat="server" Width="150px"></asp:TextBox></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td style="width: 107px">
                                        <asp:Label ID="Label4" runat="server">TagName</asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="txtxSTagName" runat="server" Width="150px"></asp:TextBox></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td style="width: 107px">
                                        <asp:Label ID="Label5" runat="server">Hide published</asp:Label></td>
                                    <td>
                                        <asp:CheckBox ID="chkShowPublish" runat="server"></asp:CheckBox></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td style="width: 107px">
                                        <asp:Label ID="Label6" runat="server">Hide unpublished</asp:Label></td>
                                    <td>
                                        <asp:CheckBox ID="chkShowUnPublish" runat="server"></asp:CheckBox></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td style="width: 107px">
                                        <asp:Label ID="Label7" runat="server">Hide Dismissed</asp:Label></td>
                                    <td>
                                        <asp:CheckBox ID="chkDismissed" runat="server"></asp:CheckBox></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td style="width: 107px"></td>
                                    <td>
                                        <asp:Button ID="btnSearchbtn" runat="server" Text="Search"></asp:Button></td>
                                    <td></td>
                                </tr>
                            </table>
							<%=Dynamicweb.SystemTools.Gui.GroupboxEnd()%>
                            <p></p>
                            <p>
                                <%=Dynamicweb.SystemTools.Gui.GroupboxStart("Search Result")%>
                                <asp:DataGrid ID="dtgSearch" Width="100%" runat="server" Visible="False" BorderWidth="0px" AutoGenerateColumns="False"
									OnEditCommand="dtgSearch_Edit" OnCancelCommand="dtgSearch_Cancel" OnUpdateCommand="dtgSearch_Update"
									OnDeleteCommand="dtgSearch_Delete" BorderColor="#E7E7FF" BorderStyle="None" BackColor="White"
									CellPadding="3" GridLines="Horizontal" HorizontalAlign="Left">
									<SelectedItemStyle Font-Bold="True" HorizontalAlign="Left" ForeColor="#3399CC" VerticalAlign="Top"
										BackColor="#738A9C"></SelectedItemStyle>
									<EditItemStyle HorizontalAlign="Left" ForeColor="#3399CC" VerticalAlign="Top"></EditItemStyle>
									<AlternatingItemStyle HorizontalAlign="Left" ForeColor="#3399CC" VerticalAlign="Top" BackColor="#F9F8F3"></AlternatingItemStyle>
									<ItemStyle HorizontalAlign="Left" ForeColor="#3399CC" VerticalAlign="Top" BackColor="#ECE9D8"></ItemStyle>
									<HeaderStyle Font-Bold="True" ForeColor="#000000" BackColor="#ECE9D8"></HeaderStyle>
									<FooterStyle ForeColor="#4A3C8C" BackColor="#B5C7DE"></FooterStyle>
									<Columns>
										<asp:EditCommandColumn ButtonType="LinkButton" EditText="Edit">
											<HeaderStyle Font-Bold="True"></HeaderStyle>
										</asp:EditCommandColumn>
										<asp:EditCommandColumn ButtonType="LinkButton" UpdateText="Update" CancelText="Cancel">
											<HeaderStyle Font-Bold="True"></HeaderStyle>
										</asp:EditCommandColumn>
										
										<asp:BoundColumn DataField="TagID" ReadOnly="True" HeaderText="TagID">
											<HeaderStyle Font-Bold="True"></HeaderStyle>
										</asp:BoundColumn>
										<asp:BoundColumn DataField="TagPage" ReadOnly="True" HeaderText="TagPage">
											<HeaderStyle Font-Bold="True"></HeaderStyle>
										</asp:BoundColumn>
										<asp:BoundColumn DataField="TagName" ReadOnly="True" HeaderText="TagName">
											<HeaderStyle Font-Bold="True"></HeaderStyle>
										</asp:BoundColumn>
										<asp:TemplateColumn HeaderText="Editor">
											<HeaderStyle Font-Bold="True"></HeaderStyle>
											<EditItemTemplate>
                                                <table id="Table4" style="width: 552px; height: 266px" cellspacing="1" cellpadding="1"
													width="552" border="0">
                                                    <tr>
                                                        <td style="width: 134px">TagPath</td>
                                                        <td style="width: 160px">
                                                            <asp:TextBox ID="txtTagPath" runat="server" Width="150px"></asp:TextBox></td>
                                                        <td valign="top" align="left" rowspan="10">
                                                            <table style="width: 247px; height: 62px" cellspacing="1" cellpadding="1" width="247" border="0">
                                                                <tr>
                                                                    <td>Settings</td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:TextBox ID="txtFileRef" runat="server" TextMode="MultiLine" Width="232px" Height="80px"></asp:TextBox></td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <br>
                                                                        Summary</td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Width="232px" Height="80px"></asp:TextBox></td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <br>
                                                                        Remarks</td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:TextBox ID="txtComments" runat="server" TextMode="MultiLine" Width="232px" Height="80px"></asp:TextBox></td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 134px">TagPage</td>
                                                        <td style="width: 160px">
                                                            <asp:TextBox ID="txtTagPage" runat="server" Width="150px"></asp:TextBox></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 134px">TagName</td>
                                                        <td style="width: 160px">
                                                            <asp:TextBox ID="txtTagName" runat="server" Width="150px">3</asp:TextBox></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 134px; height: 27px">TagValue</td>
                                                        <td style="width: 160px">
                                                            <asp:TextBox ID="txtTagValue" runat="server" Width="150px"></asp:TextBox></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 134px; height: 25px">TagTemplateFile</td>
                                                        <td style="width: 160px; height: 25px">
                                                            <asp:TextBox ID="txtTagTemplateFile" runat="server" Width="150px"></asp:TextBox></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 134px">TagFunction</td>
                                                        <td style="width: 160px">
                                                            <asp:TextBox ID="txtTagFunction" runat="server" Width="150px"></asp:TextBox></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 134px">Publish</td>
                                                        <td style="width: 160px">
                                                            <asp:RadioButtonList ID="chkTagActive" runat="server"></asp:RadioButtonList></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 134px">TagCategory</td>
                                                        <td style="width: 160px">
                                                            <asp:DropDownList ID="ddlTagFunction" Width="150px" runat="server"></asp:DropDownList></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 134px">DefaultTemplateName</td>
                                                        <td style="width: 160px">
                                                            <asp:TextBox ID="txtDefaultTemplateName" Width="150px" runat="server"></asp:TextBox></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 134px">VersionNumber</td>
                                                        <td style="width: 160px">
                                                            <asp:TextBox ID="txtVersionNumber" Width="150px" runat="server"></asp:TextBox></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 134px"></td>
                                                        <td style="width: 160px"></td>
                                                        <td>References<br>
                                                            <asp:DataGrid BorderWidth="1" BorderColor="#000000" ID="dtgEditRef" CellPadding="2" runat="server" Visible="False" AutoGenerateColumns="False" OnDeleteCommand="dtgEditRef_Delete">

																									<SelectedItemStyle Font-Bold="True" HorizontalAlign="Left" ForeColor="#3399CC" VerticalAlign="Top" BackColor="#738A9C"></SelectedItemStyle>
									<EditItemStyle HorizontalAlign="Left" ForeColor="#3399CC" VerticalAlign="Top"></EditItemStyle>
									<AlternatingItemStyle HorizontalAlign="Left" ForeColor="#3399CC" VerticalAlign="Top" BackColor="#F9F8F3"></AlternatingItemStyle>
									<ItemStyle HorizontalAlign="Left" ForeColor="#3399CC" VerticalAlign="Top" BackColor="#ECE9D8"></ItemStyle>
									<HeaderStyle Font-Bold="True" ForeColor="#000000" BackColor="#ECE9D8"></HeaderStyle>
									<FooterStyle ForeColor="#4A3C8C" BackColor="#B5C7DE"></FooterStyle>
<Columns>
																	<asp:ButtonColumn Text="Delete" CommandName="Delete"></asp:ButtonColumn>
																	<asp:BoundColumn Visible="False" DataField="TagRelatedID" HeaderText="RefTagID">
																		<HeaderStyle Font-Bold="True"></HeaderStyle>
																	</asp:BoundColumn>
																	<asp:BoundColumn Visible="False" DataField="TagRelatedMasterID" HeaderText="RefTagID">
																		<HeaderStyle Font-Bold="True"></HeaderStyle>
																	</asp:BoundColumn>
																	<asp:BoundColumn DataField="TagID" HeaderText="RefTagID">
																		<HeaderStyle Font-Bold="True"></HeaderStyle>
																	</asp:BoundColumn>
																	<asp:BoundColumn DataField="TagName" HeaderText="RefTagName">
																		<HeaderStyle Font-Bold="True"></HeaderStyle>
																	</asp:BoundColumn>
																</Columns>
															</asp:DataGrid><br>
                                                            <a style="color: #3399CC; cursor: hand;" onclick="JavaScript:window.open('EditTagAddRef.aspx?ID=<%#Container.DataItem("TagID")%>');">Add reference</a><br>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <br>
											</EditItemTemplate>
										</asp:TemplateColumn>
										<asp:ButtonColumn Text="Delete" CommandName="Delete">
											<HeaderStyle Font-Bold="True"></HeaderStyle>
										</asp:ButtonColumn>
										<asp:ButtonColumn Text="" CommandName="xDelete">
											<HeaderStyle Font-Bold="True"></HeaderStyle>
										</asp:ButtonColumn>
                                        <asp:HyperLinkColumn Text="Show" Target="_blank" DataNavigateUrlField="TagID" DataTextField="TagID" HeaderText="Showtest" DataNavigateUrlFormatString="ShowTag.aspx?TagID={0}"></asp:HyperLinkColumn>

									</Columns>
									<PagerStyle HorizontalAlign="Right" ForeColor="#4A3C8C" BackColor="#E7E7FF" Mode="NumericPages"></PagerStyle>
                                </asp:DataGrid>
                            </p>
							<%=Dynamicweb.SystemTools.Gui.GroupboxEnd()%>
                            <br>
							<%=Dynamicweb.SystemTools.Gui.GroupboxStart("Add Tag")%>
                            <table id="Table4" style="width: 552px; height: 266px" cellspacing="1" cellpadding="1"
								width="552" border="0">
                                <tr>
                                    <td style="width: 134px">TagPath</td>
                                    <td style="width: 160px">
                                        <asp:TextBox ID="txtTagPathNew" runat="server" Width="150px"></asp:TextBox></td>
                                    <td valign="top" align="left" rowspan="11">
                                        <table style="width: 247px; height: 62px" cellspacing="1" cellpadding="1" width="247" border="0">
                                            <tr>
                                                <td>Settings</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txtFileRefNew" runat="server" Width="232px" Height="80px"></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <br>
                                                    Summary</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txtDescriptionNew" runat="server" Width="232px" Height="80px"></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <br>
                                                    Remarks</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txtCommentsNew" runat="server" Width="232px" Height="80px"></asp:TextBox></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 134px">TagPage</td>
                                    <td style="width: 160px">
                                        <asp:TextBox ID="txtTagPageNew" runat="server" Width="150px"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td style="width: 134px">TagName</td>
                                    <td style="width: 160px">
                                        <asp:TextBox ID="txtTagNameNew" runat="server" Width="150px">3</asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td style="width: 134px; height: 27px">TagValue</td>
                                    <td style="width: 160px">
                                        <asp:TextBox ID="txtTagValueNew" runat="server" Width="150px"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td style="width: 134px; height: 25px">TagTemplateFile</td>
                                    <td style="width: 160px; height: 25px">
                                        <asp:TextBox ID="txtTagTemplateFileNew" runat="server" Width="150px"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td style="width: 134px">TagFunction</td>
                                    <td style="width: 160px">
                                        <asp:TextBox ID="txtTagFunctionNew" runat="server" Width="150px"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td style="width: 134px">Publish</td>
                                    <td style="width: 160px">
                                        <asp:CheckBox ID="chkTagActiveNew" runat="server"></asp:CheckBox></td>
                                </tr>
                                <tr>
                                    <td style="width: 134px">TagCategory</td>
                                    <td style="width: 160px">
                                        <asp:DropDownList ID="ddlTagFunctionNew" Width="150px" runat="server"></asp:DropDownList></td>
                                </tr>
                                <tr>
                                    <td style="width: 134px">DefaultTemplateName</td>
                                    <td style="width: 160px">
                                        <asp:TextBox ID="txtDefaultTemplateNameNew" Width="150px" runat="server"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td style="width: 134px">VersionNumber</td>
                                    <td style="width: 160px">
                                        <asp:TextBox ID="txtVersionNumberNew" Width="150px" runat="server"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td style="width: 134px"></td>
                                    <td style="width: 160px">
                                        <asp:Button ID="btnCreateTag" runat="server" Text="Add"></asp:Button></td>
                                </tr>
                            </table>
							<%=Dynamicweb.SystemTools.Gui.GroupboxEnd()%>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td colspan="3"></td>
                </tr>
                <tr>
                    <td colspan="3">
                        <asp:Panel ID="panCreateSystem" runat="server" BorderWidth="0" Visible="False">
                            <p>
									<%=Dynamicweb.SystemTools.Gui.GroupboxStart("Systems")%>
                                <p></p>

                                <asp:DataGrid ID="dtgCreateSystem" Width="100%" runat="server" Visible="False" BorderWidth="0px" AutoGenerateColumns="False" OnEditCommand="dtgCreateSystem_Edit" OnCancelCommand="dtgCreateSystem_Cancel"
									OnUpdateCommand="dtgCreateSystem_Update" OnDeleteCommand="dtgCreateSystem_Delete" BorderColor="#E7E7FF"
									BorderStyle="None" BackColor="White" CellPadding="3" GridLines="Horizontal">
									<SelectedItemStyle Font-Bold="True" HorizontalAlign="Left" ForeColor="#3399CC" VerticalAlign="Top" BackColor="#738A9C"></SelectedItemStyle>
									<EditItemStyle HorizontalAlign="Left" ForeColor="#3399CC" VerticalAlign="Top"></EditItemStyle>
									<AlternatingItemStyle HorizontalAlign="Left" ForeColor="#3399CC" VerticalAlign="Top" BackColor="#F9F8F3"></AlternatingItemStyle>
									<ItemStyle HorizontalAlign="Left" ForeColor="#3399CC" VerticalAlign="Top" BackColor="#ECE9D8"></ItemStyle>
									<HeaderStyle Font-Bold="True" ForeColor="#000000" BackColor="#ECE9D8"></HeaderStyle>
									<FooterStyle ForeColor="#4A3C8C" BackColor="#B5C7DE"></FooterStyle>
									<Columns>
										<asp:EditCommandColumn ButtonType="LinkButton" EditText="Edit">
											<HeaderStyle Font-Bold="True"></HeaderStyle>
										</asp:EditCommandColumn>
										<asp:EditCommandColumn ButtonType="LinkButton" UpdateText="Update" CancelText="Cancel">
											<HeaderStyle Font-Bold="True"></HeaderStyle>
										</asp:EditCommandColumn>
										<asp:BoundColumn DataField="TagSystemID" ReadOnly="True" HeaderText="TagSystemID">
											<HeaderStyle Font-Bold="True"></HeaderStyle>
										</asp:BoundColumn>
										<asp:BoundColumn DataField="TagSystemName" HeaderText="TagSystemName">
											<HeaderStyle Font-Bold="True"></HeaderStyle>
										</asp:BoundColumn>
										<asp:ButtonColumn Text="Delete" CommandName="Delete">
											<HeaderStyle Font-Bold="True"></HeaderStyle>
										</asp:ButtonColumn>
									</Columns>
									<PagerStyle HorizontalAlign="Right" ForeColor="#4A3C8C" BackColor="#E7E7FF" Mode="NumericPages"></PagerStyle>
								</asp:DataGrid>
                            </p>
							<%=Dynamicweb.SystemTools.Gui.GroupboxEnd()%>
                            <p>
                            </p>
							<%=Dynamicweb.SystemTools.Gui.GroupboxStart("Add System")%>
							TagSystems: 
							<asp:TextBox ID="txtCreateSystemSystemName" runat="server" Width="150px"></asp:TextBox>&nbsp; 
							<asp:Button ID="btnCreateCreateSystem" runat="server" Text="Add"></asp:Button>
                        </asp:Panel>
                    </td>
							<%=Dynamicweb.SystemTools.Gui.GroupboxEnd()%>
                </tr>
                <tr>
                    <td colspan="3">
                        <asp:Panel ID="panCreateFunction" runat="server" BorderWidth="0" Visible="False">
                            <p>
							<%=Dynamicweb.SystemTools.Gui.GroupboxStart("Functions")%>

                                <p></p>
                                <asp:DataGrid ID="dtgCreateFunction" Width="100%" runat="server" Visible="False" BorderWidth="0px" AutoGenerateColumns="False"
									OnEditCommand="dtgCreateFunction_Edit" OnCancelCommand="dtgCreateFunction_Cancel" OnUpdateCommand="dtgCreateFunction_Update"
									OnDeleteCommand="dtgCreateFunction_Delete" BorderColor="#E7E7FF" BorderStyle="None" BackColor="White"
									CellPadding="3" GridLines="Horizontal" Font-Names="Verdana">
									<SelectedItemStyle Font-Bold="True" HorizontalAlign="Left" ForeColor="#3399CC" VerticalAlign="Top"
										BackColor="#738A9C"></SelectedItemStyle>
									<EditItemStyle HorizontalAlign="Left" ForeColor="#3399CC" VerticalAlign="Top"></EditItemStyle>
									<AlternatingItemStyle HorizontalAlign="Left" ForeColor="#3399CC" VerticalAlign="Top" BackColor="#F9F8F3"></AlternatingItemStyle>
									<ItemStyle HorizontalAlign="Left" ForeColor="#3399CC" VerticalAlign="Top" BackColor="#ECE9D8"></ItemStyle>
									<HeaderStyle Font-Bold="True" ForeColor="#000000" BackColor="#ECE9D8"></HeaderStyle>
									<FooterStyle ForeColor="#4A3C8C" BackColor="#B5C7DE"></FooterStyle>
									<Columns>
										<asp:EditCommandColumn ButtonType="LinkButton" EditText="Edit">
											<HeaderStyle Font-Bold="True"></HeaderStyle>
										</asp:EditCommandColumn>
										<asp:EditCommandColumn ButtonType="LinkButton" UpdateText="Update" CancelText="Cancel">
											<HeaderStyle Font-Bold="True"></HeaderStyle>
										</asp:EditCommandColumn>
										<asp:BoundColumn DataField="TagFunctionID" ReadOnly="True" HeaderText="ID">
											<HeaderStyle Font-Bold="True"></HeaderStyle>
										</asp:BoundColumn>
										<asp:BoundColumn DataField="TagFunctionName" HeaderText="TagFunctionName">
											<HeaderStyle Font-Bold="True"></HeaderStyle>
										</asp:BoundColumn>
										<asp:TemplateColumn HeaderText="SystemID">
											<HeaderStyle Font-Bold="True"></HeaderStyle>
											<ItemTemplate>
												<%#Container.DataItem("SystemName")%>
											</ItemTemplate>
											<EditItemTemplate>
                                                <asp:DropDownList ID="Dropdownlist2" runat="server"></asp:DropDownList>
											</EditItemTemplate>
										</asp:TemplateColumn>
										<asp:ButtonColumn Text="Delete" CommandName="Delete">
											<HeaderStyle Font-Bold="True"></HeaderStyle>
										</asp:ButtonColumn>
									</Columns>
									<PagerStyle HorizontalAlign="Right" ForeColor="#4A3C8C" BackColor="#E7E7FF" Mode="NumericPages"></PagerStyle>
                                </asp:DataGrid>
                            </p>
						<%=Dynamicweb.SystemTools.Gui.GroupboxEnd()%>
                            <p>
                            </p>
						<%=Dynamicweb.SystemTools.Gui.GroupboxStart("Add Function")%>

                            <table id="Table2" cellspacing="1" cellpadding="1" width="300" border="0">
                                <tr>
                                    <td>TagFunctionName:</td>
                                    <td>
                                        <asp:TextBox ID="txtCreateFunctionFunctionName" runat="server" Width="150px"></asp:TextBox></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>TagFunctionSystemID:</td>
                                    <td>
                                        <asp:DropDownList ID="ddlTagFunctionSystemID" runat="server" Width="150px"></asp:DropDownList></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>
                                        <asp:Button ID="btnCreateCreateFunction" runat="server" Text="Add"></asp:Button></td>
                                    <td></td>
                                </tr>
                            </table>
						<%=Dynamicweb.SystemTools.Gui.GroupboxEnd()%>
                        </asp:Panel>
                        <br>
                        <p>
                            &nbsp;&nbsp;<br>
                        </p>
                    </td>
                </tr>
            </table>
		</form>
	</body>
</html>
<script language="JScript">
	function GridScroll() {
        if (document.all.ScrollHere != null) {
		document.all.ScrollHere.scrollIntoView();
		}
	}
</script>