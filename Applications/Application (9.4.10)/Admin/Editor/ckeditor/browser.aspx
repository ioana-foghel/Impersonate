<%@ Page Language="vb" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="Dynamicweb.SystemTools" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE html>

<html>
	<head>
		<meta charset="utf-8"/>
		<title>Link Browser</title>
    <dw:ControlResources ID="ControlResources1" IncludePrototype="true" runat="server" />
		<script src="/Admin/Editor/ckeditor/ckeditor/ckeditor.js"></script>
    <script src="/Admin/Link.js"></script>
<style>
.browser {  
    white-space: nowrap;
    padding:30px;
}

a {
text-decoration: none;
}

.buttons {
	margin: 1em 0;
	text-align: right;
}
</style>
	</head>
	<body>
    <div class="browser">
        <label class="control-label" for="Link_url"><%=Translate.Translate("Link")%></label>
        <%= Dynamicweb.SystemTools.Gui.LinkManager("", "url", "", "0", Dynamicweb.Core.Converter.ToInt32(HttpContext.Current.Session("DW_Area")), False, True, True, "", True, True) %>        
    </div>
<script>
    function setLink(url, data, filebrowserFunctionID) {
		if (typeof parent.CKEDITOR.tools.callFunction != 'undefined') {
		    parent.CKEDITOR.tools.callFunction(filebrowserFunctionID, url, function () {
				var element,
		        dialog = this.getDialog();				
				if (dialog.getName() == 'link') {
					var tabId, attribute;
					if (data.attributes) {
						for (tabId in data.attributes) {
							for (attribute in data.attributes[tabId]) {
								element = dialog.getContentElement(tabId, attribute);
								if (element) {
									element.setValue(data.attributes[tabId][attribute]);
								}
							}
						}
					}
				}
			});
		}
    }

    function finishBrowse(dialogID, filebrowserFunctionID) {
        var url = document.getElementById('url').value,
		type, rel,
		title = document.getElementById('Link_url').value,
		data = { url: url, attributes: {} };

        if (/Default.aspx.*#/i.test(url)) {
            type = 'internal link';
            url = '/' + url;
        } else if (/Default.aspx/i.test(url)) {
            type = 'link';
            url = '/' + url;
        } else if (url) {
            type = 'file';
        }

        setLink(url, data, filebrowserFunctionID);
    }

    function clearSelection() {
        document.getElementById('url').value = '';
        document.getElementById('Link_url').value = '';
    }
</script>

</body>
</html>
