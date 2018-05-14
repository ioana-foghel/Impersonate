﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PageList.aspx.vb" Inherits="Dynamicweb.Admin.PageList" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Register Assembly="Dynamicweb.UI.Controls" Namespace="Dynamicweb.UI.Controls" TagPrefix="dwc" %>
<%@ Import Namespace="Dynamicweb.SystemTools" %>
<%@ Import Namespace="Dynamicweb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <dw:ControlResources ID="ctrlResources" runat="server" >
        <Items>
            <dw:GenericResource Url="/Admin/Resources/js/layout/dwglobal.js" />
            <dw:GenericResource Url="/Admin/Content/Page/PageList.js" />
        </Items>
    </dw:ControlResources>

    <style>
        #PageListContent {
            margin-bottom: 60px;
            overflow-x: auto;
        }

        .listRow .icon {
            padding-left: 18px;
            padding-right: 11px;
            width: 14px;
        }
    </style>
    <script type="text/javascript">
        <% If Core.Converter.ToString(Dynamicweb.Context.Current.Request("NavigatorSync")).ToLower() = "refreshparentandselectpage" Then
                Dim ancestors As IEnumerable(Of String) = GetPageAncestorsNodeIds()
                Dim ancestorsToForceReload As IEnumerable(Of String) = ancestors.Skip(Math.Max(0, ancestors.Count - 2)).Take(1)
            %>
        dwGlobal.getContentNavigator().expandAncestors(<%= Newtonsoft.Json.JsonConvert.SerializeObject(ancestors) %>, <%= Newtonsoft.Json.JsonConvert.SerializeObject(ancestorsToForceReload) %>);            
        <% ElseIf Core.Converter.ToString(Dynamicweb.Context.Current.Request("NavigatorSync")).ToLower() = "refreshandselectpage" Then
                Dim ancestors As IEnumerable(Of String) = GetPageAncestorsNodeIds()
                Dim ancestorsToForceReload As IEnumerable(Of String) = ancestors.Take(1)
            %>
        dwGlobal.getContentNavigator().expandAncestors(<%= Newtonsoft.Json.JsonConvert.SerializeObject(ancestors) %>, <%= Newtonsoft.Json.JsonConvert.SerializeObject(ancestorsToForceReload) %>);
        <% End If %>
    </script>
</head>
<body class="screen-container">
    <form id="form1" runat="server">
        <input type="hidden" id="cmd" />
        <dw:Overlay ID="PleaseWait" runat="server" />

        <div class="card">
            <dw:RibbonBar runat="server" ID="myribbon">
                <dw:RibbonBarTab Active="true" Name="Indhold" runat="server" ID="tabContent">
                    <dw:RibbonBarGroup runat="server" Name="Indsæt">
                        <dw:RibbonBarButton ID="NewPage" runat="server" Size="Large" Text="New page" Icon="PlusSquare" OnClientClick="pageList.createPage();"></dw:RibbonBarButton>
                    </dw:RibbonBarGroup>
				    <dw:RibbonbarGroup ID="groupView" Name="Content" runat="server">
				        <dw:RibbonbarRadioButton ID="cmdViewItem" Group="GroupView" Size="Large" Icon="Cube" Text="Page"  runat="server" OnClientClick="pageList.switchToItem();" />
				        <dw:RibbonbarRadioButton ID="cmdViewParagraphs" Group="GroupView" Size="Large" Icon="FileTexto" Text="Paragraphs" runat="server" OnClientClick="pageList.switchToParagraphs();" />                                
				        <dw:RibbonbarRadioButton ID="cmdViewList" Group="GroupView" Size="Large" Icon="ViewList" Text="List" Checked="true" runat="server" />
				    </dw:RibbonbarGroup>
                    <dw:RibbonBarGroup runat="server" Name="Side">
                        <dw:RibbonBarButton runat="server" Size="Large" Text="Egenskaber" Icon="InfoOutline" OnClientClick="pageList.showProperties();"></dw:RibbonBarButton>
                    </dw:RibbonBarGroup>
                </dw:RibbonBarTab>
            </dw:RibbonBar>
            
            <dw:PageBreadcrumb ID="breadcrumbControl" runat="server" />

            <div id="PageListContent">
                <dw:List ID="List1" runat="server" Title="" ShowTitle="false" ShowPaging="true" Personalize="true">
                    <Filters>
                        <dw:ListAutomatedSearchFilter  runat="server" ID="TextFilter" />
                        <dw:ListDropDownListFilter ID="PageSizeFilter" Width="150" Label="Page size" AutoPostBack="true" Priority="3" runat="server">
                            <Items>
                                <dw:ListFilterOption Text="25" Value="25" DoTranslate="false" />
                                <dw:ListFilterOption Text="50" Value="50" DoTranslate="false" />
                                <dw:ListFilterOption Text="75" Value="75" DoTranslate="false" />
                                <dw:ListFilterOption Text="100" Value="100" DoTranslate="false" />
                                <dw:ListFilterOption Text="200" Value="200" Selected="true" DoTranslate="false" />
                                <dw:ListFilterOption Text="All" Value="10000" DoTranslate="false" />
                            </Items>
                        </dw:ListDropDownListFilter>
                    </Filters>
                </dw:List>
            </div>

           <dwc:ActionBar runat="server">
                <dw:ToolbarButton runat="server" Text="Annuller" Size="Small" Image="NoImage" OnClientClick="pageList.cancel();" ID="cmdCancel" ShowWait="true" WaitTimeout="500">
                </dw:ToolbarButton>
            </dwc:ActionBar>
        </div>


    </form>

<script type="text/javascript">

    pageList.initialize(<%= PageId %>, <%= AreaId %>, <%= ParentPageId %>);

</script>

</body>
</html>

<%Dynamicweb.SystemTools.Translate.GetEditOnlineScript()%>