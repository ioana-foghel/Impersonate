
var Facets = function () { }
var _listContainerId = "";
var _catalogPageId = "";
var _requestQuery = "";


Facets.prototype.Init = function (listContainerId, catalogPageId, requestQuery) {
    _listContainerId = listContainerId;
    _catalogPageId = catalogPageId;
    _requestQuery = requestQuery == null ? "" : requestQuery;
}

Facets.prototype.UpdateFacets = function (facet) {
    var url = window.location.search;
    var path = window.location.pathname;
    url = url.replace(/\bID=[^&#]+/g, "");
    url = url.replace("?debug=true", "");
    url = url.replace("&debug=true", "");
    var catalogPage = "/Default.aspx?ID=" + _catalogPageId;
    var groupID = _requestQuery.split('groupid=')[1] ? "&" + _requestQuery.match(/(GroupID=)[0-9A-Za-z-]+/ig)[0] : '';
    groupID = groupID.replace("?", "&");

    url = url.replace(/\bPageNum=[^&#]+/g, "PageNum=1");
    url = url.replace(/\bpagesize=[^&#]+/g, "pagesize=30");
    url = url.replace(/\bScrollPos=[^&#]+/g, "ScrollPos=0");

    if (facet.tagName == 'SELECT') {
        facet = facet.options[facet.selectedIndex];
    }

    var name = facet.getAttribute("name");
    var value = facet.getAttribute("value");

    if (facet.checked || facet.getAttribute("data-check") == "") {
        url = Facets.AddFacetToUrl(url, name, value);

        facet.setAttribute("data-check", "checked");
        facet.classList.add("checked");
    } else {
        url = Facets.RemoveFacetFromUrl(url, name, value);

        facet.setAttribute("data-check", "");
        facet.classList.remove("checked");
    }

    url = url.replace(/#/g, "%23");

    var browserUrl = path + url;
    history.pushState(null, null, browserUrl);

    //Remember the groupID
    url = url.indexOf("groupid") == -1 ? url += groupID : url.replace(/\b&groupid=[^&#]+/g, groupID);

    var jsonUrl = catalogPage + url.replace("?", "&");
    jsonUrl = Facets.UrlParametersParse(jsonUrl);

    Dynamo.UpdateContent(_listContainerId, jsonUrl);
}

Facets.prototype.AddFacetToUrl = function (url, name, value) {
    var selectedCommand = "";
    var seperator = "?";

    if (url.indexOf("?") != -1) {
        seperator = "&";
    }

    name = encodeURIComponent(name);
    value = encodeURIComponent(value);

    //If the parameter already exists, add value to comma seperated array. Else add parameter and value to url
    if (url.indexOf(name) != -1) {
        selectedCommand = Facets.GetParameterByName(name) + "," + value;
        selectedCommand = selectedCommand.replace(/ /g, "+");
        url = Facets.ReplaceUrlParam(url, name, selectedCommand);
    } else {
        selectedCommand = name + "=" + value;
        selectedCommand = selectedCommand.replace(/ /g, "+");
        url += seperator + selectedCommand;
    }

    return url;
}

Facets.prototype.RemoveFacetFromUrl = function (url, name, value) {
    name = encodeURIComponent(name);

    var valuesArray = Facets.GetParameterByName(name);
    valuesArray = valuesArray.split(',');

    //If the existing values is an array, remove the selected value from the array. Else remove both the parameter name and value from the url.
    if (Facets.GetParameterByName(name).indexOf(",") != -1) {
        var index = valuesArray.indexOf(value);
        valuesArray.splice(index, 1);
        valuesArray = valuesArray.toString();
        url = Facets.ReplaceUrlParam(url, name, valuesArray);
    } else {
        var selectedCommand = name + "=" + encodeURIComponent(value);

        url = url.replace("?" + selectedCommand, "");
        url = url.replace("&" + selectedCommand, "");
    }

    url = Facets.UrlParametersParse(url);

    return url;
}

Facets.prototype.ResetFacets = function (facet) {
    var url = window.location.search;
    var path = window.location.pathname;
    var catalogPage = "/Default.aspx?ID=" + _catalogPageId;
    var groupID = _requestQuery.split('groupid=')[1] ? "&" + _requestQuery.match(/(GroupID=)[0-9A-Za-z-]+/ig)[0] : '';
    groupID = groupID.replace("?", "&");

    url = url.split('?')[0];

    url += "?PageNum=1";
    url += "&pagesize=30";
    url = url.indexOf("groupid") == -1 ? url += groupID : url.replace(/\b&groupid=[^&#]+/g, groupID);

    var browserUrl = path + url;
    history.pushState(null, null, browserUrl);

    var jsonUrl = catalogPage + url.replace("?", "&");
    jsonUrl = Facets.UrlParametersParse(jsonUrl);

    Dynamo.UpdateContent(_listContainerId, jsonUrl);
}

Facets.prototype.GetParameterByName = function (name) {
    var match = RegExp('[?&]' + name + '=([^&]*)').exec(window.location.search);
    return match && decodeURIComponent(match[1].replace(/\+/g, ' '));
}

Facets.prototype.ReplaceUrlParam = function(url, name, newValue){
    if (newValue == null)
        newValue = '';
    var pattern = new RegExp('\\b(' + name + '=).*?(&|$)');
    if (url.search(pattern) >= 0) {
        return url.replace(pattern, '$1' + newValue + '$2');
    }

    return url + (url.indexOf('?') > 0 ? '&' : '?') + name + '=' + newValue
}

Facets.prototype.UrlParametersParse = function (url) {
    if (url.indexOf("?") == -1 && url.indexOf("&") != -1) {
        var index = url.indexOf("&");
        url = url.substr(0, index) + '?' + url.substr(index + 1);
    }

    return url;
}

var Facets = new Facets();