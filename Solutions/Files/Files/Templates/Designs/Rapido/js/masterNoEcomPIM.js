var cartId;
var productsCount = -1;

var Cart = function () { }

Cart.prototype.InitMiniCart = function () {
    var miniCart = document.getElementsByClassName('js-mini-cart')[0];

    if (miniCart) {
        cartId = miniCart.getAttribute('data-cart-id');
    }

    window.onscroll = function () { Cart.toggleFloatingVisibility() };
}

document.addEventListener("DOMContentLoaded", function (event) {
    Cart.InitMiniCart();
});

Cart.prototype.toggleFloatingVisibility = function (e) {
    if (document.getElementById("FloatingMiniCart")) {
        var topHeight = document.getElementById("Top").clientHeight;
        var floatingMiniCart = document.getElementById("FloatingMiniCart");

        if (document.body.scrollTop > topHeight || document.documentElement.scrollTop > topHeight) {
            floatingMiniCart.classList.remove("u-hidden");
        } else {
            floatingMiniCart.classList.add("u-hidden");
        }
    }
}

Cart.prototype.EmptyCart = function(e) {
    e.preventDefault();

    var url = "/Default.aspx?ID=" + cartId;
    Cart.UpdateCart('miniCart', url, "&cartcmd=emptycart", true);
    
    var miniCartDropdowns = document.getElementsByClassName("js-mini-cart");
    for (var i = 0; i < miniCartDropdowns.length; i++) {
        miniCartDropdowns[i].innerHTML = "";
    }
}

Cart.prototype.AddToCart = function(e, productId, quantity, unitElement, variantElement) {
    e.preventDefault();

    if (quantity > 0) {
        var clickedButton = e.currentTarget;
        var clickedButtonText = clickedButton.innerHTML;
        var clickedButtonWidth = clickedButton.clientWidth;
        clickedButton.classList.add("disabled");
        clickedButton.disabled = true;
        clickedButton.innerHTML = "";
        clickedButton.innerHTML = "<i class=\"fa fa-circle-o-notch fa-spin\"></i>";
        clickedButton.style.width = clickedButtonWidth + "px";

        setTimeout(function () {
            clickedButton.innerHTML = clickedButtonText;
            clickedButton.classList.remove("disabled");
            clickedButton.disabled = false;
            clickedButton.style = "";
        },
        1400);

        var url = "/Default.aspx?ID=" + cartId;
        url += "&Quantity=" + quantity;
        url += "&Redirect=false";

        if (document.getElementById(unitElement)) {
            var unit = document.getElementById(unitElement).value;
            url += "&UnitID=" + unit;
        }

        if (productId.toLowerCase().indexOf("prod") != -1) {
            url += "&ProductID=" + productId;

            if (window.location.search.indexOf("VariantID") != -1) {
                url += "&VariantID=" + location.search.split('VariantID=')[1];
            } else if (variantElement) {
                var variantIdElement = document.getElementById(variantElement);
                if (variantIdElement) {
                    var variantId = variantIdElement.value;
                    url += "&VariantID=" + variantId;
                }
            }
        } else {
            url += "&ProductNumber=" + productId;
        }

        Cart.UpdateCart('miniCart', url, "&cartcmd=add", false);
    }
}

Cart.prototype.UpdateCart = function (containerId, url, command, preloader) {
    if (preloader == true) {
        var overlayElement = document.createElement('div');
        overlayElement.className = "preloader-overlay";
        overlayElement.setAttribute('id', "CartOverlay");
        var overlayElementIcon = document.createElement('div');
        overlayElementIcon.className = "preloader-overlay__icon";
        overlayElementIcon.style.top = window.pageYOffset + "px";
        overlayElement.appendChild(overlayElementIcon);

        document.getElementById('content').parentNode.insertBefore(overlayElement, document.getElementById('content'));
    }

    var miniCartButtons = document.getElementsByClassName("js-mini-cart-button");
    for (var i = 0; i < miniCartButtons.length; i++) {
        var cartButton = document.getElementsByClassName("js-mini-cart-button")[i];
        cartButton.classList.add("mini-cart-update");
        setCartAnimationDelay(cartButton);
    }

    function setCartAnimationDelay(cartButton) {
        setTimeout(function () {
            cartButton.classList.remove("mini-cart-update");
        }, 2800);
    }

    var xhr = new XMLHttpRequest();
    xhr.open('POST', url + command + "&feedtype=Counter");
    xhr.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            if (preloader == true) {
                var overlayNode = document.getElementById('CartOverlay');
                overlayNode.parentNode.removeChild(overlayNode);
            }

            if (document.getElementById(containerId) && containerId != "miniCart") {
                Dynamo.UpdateContent(containerId, url);
            }

            var miniCartCounters = document.getElementsByClassName("js-mini-cart-counter");
            for (var i = 0; i < miniCartCounters.length; i++) {
                var cartCounter = document.getElementsByClassName("js-mini-cart-counter")[i];

                if (cartCounter && Dynamo.IsJsonString(this.response)) {
                    cartCounter.innerHTML = "";
                    Dynamo.CreateItemsFromJson(JSON.parse(this.response), cartCounter);
                }
            }
        }
        if (this.readyState == 4 && this.status == 200 && Dynamo.IsJsonString(this.response) == false) {
            location.reload();
        }
    };
    xhr.send();
}

var updateDelay;

Cart.prototype.UpdateQuantity = function (containerId, url, action, preloader) {
    clearTimeout(updateDelay);

    updateDelay = setTimeout(function () {
        Cart.UpdateCart(containerId, url, action, preloader);
    }, 800);
}

var hideTimeOut;

Cart.prototype.UpdateMiniCart = function (e, containerId, url) {
    clearTimeout(hideTimeOut);
    var miniCartCounter = e.currentTarget.getElementsByClassName("js-mini-cart-counter-content")[0];

    if (document.getElementById(containerId) && document.getElementById(containerId).style.display != "block") {
        if (miniCartCounter.innerText > 0) {
            Dynamo.UpdateContent(containerId, url);
        }

        document.getElementById(containerId).style.display = "block";

        document.getElementById(containerId).onmouseleave = function (e) {
            if (e.relatedTarget.id == "miniCartCounterWrap") {
                return;
            }
            var miniCartDropdown = e.currentTarget;
            hideTimeOut = setTimeout(function () {
                miniCartDropdown.style.display = "none";
            }, 1000);
        }

        e.currentTarget.onmouseleave = function (e) {
            clearTimeout(hideTimeOut);

            if (e.relatedTarget.id == "miniCartCounterWrap") {
                return;
            }

            var miniCartDropdown = document.getElementById(containerId);
            hideTimeOut = setTimeout(function () {
                miniCartDropdown.style.display = "none";
            }, 1000);
        }

        document.getElementById(containerId).onmouseenter = function (e) {
            clearTimeout(hideTimeOut);
        }
    }
}

Cart.prototype.EnableCheckoutButton = function() {
    if (document.getElementById("EcomOrderCustomerAccepted").checked) {
        document.getElementById("CartV2.GotoStep1").disabled = false;
        document.getElementById("CartV2.GotoStep1").classList.remove('disabled');
    } else {
        document.getElementById("CartV2.GotoStep1").disabled = true;
        document.getElementById("CartV2.GotoStep1").classList.add('disabled');
    }
}

Cart.prototype.DeselectRadioGroup = function (radioGroupName) {
    var radioList = document.getElementsByName(radioGroupName);
    for (var i = 0; i < radioList.length; i++) {
        if (radioList[i].checked) radioList[i].checked = false;
    }
}

var Cart = new Cart();

var Dynamo = function () { }
var cache = {};

var dynamoConfig = {
    hiddenClass: "u-hidden",
    preloaderClass: "fa fa-circle-o-notch fa-spin preloader",
    preloaderOverlayClass: "preloader-overlay",
    preloaderOverlayIconClass: "preloader-overlay__icon",
    preloaderOverlayLocationID: "content"
};

Dynamo.prototype.GetConfiguration = function () {
    if (typeof DynamoConfig == 'object') {
        dynamoConfig = DynamoConfig.Configuration();
    }
}

//Update the template on the chosen element
Dynamo.prototype.UpdateTemplate = function (id, tmpl) {
    var data = Dynamo.FindDataInCache(id);
    var ajaxContainerElement = document.getElementById(id);

    ajaxContainerElement.setAttribute("data-template", tmpl);

    if (ajaxContainerElement.hasAttribute('data-save-cookie')) {
        var expiryTime = new Date();
        expiryTime.setTime(expiryTime.getTime() + (24 * 3600 * 1000));
        document.cookie = id + "Template=" + tmpl + "; expires=" + expiryTime;
    }

    Dynamo.CreateItemsFromJson(data, ajaxContainerElement, false);
}

//Find the temporaily saved data for the selected element
Dynamo.prototype.FindDataInCache = function (id) {
    for (var property in cache) {
        if (property == id) {
            return cache[property];
        }
    }
}

//Create data in the cache object (Must be validated Json)
Dynamo.prototype.SetDataInCache = function (id, data) {
    cache[id] = data;
}

//Update the content on the chosen element + subelements (New data request by url)
Dynamo.prototype.UpdateContent = function (containerId, url, updateUrl) {
    var ajaxContainerElement = document.getElementById(containerId);

    if (ajaxContainerElement) {
        if (url) {
            ajaxContainerElement.setAttribute('data-json-feed', url);
        } else {
            url = ajaxContainerElement.getAttribute('data-json-feed');
        }

        //Update the browser url
        if (updateUrl == true) {
            history.pushState(null, null, url);
        }

        Dynamo.GetContentFromJson(ajaxContainerElement);
    } else {
        console.log("There may be missing an Ajax container element: " + containerId);
    }
}

//Add content to the chosen element + subelements (New data request by url)
Dynamo.prototype.AddContent = function (containerId, url) {
    var ajaxContainerElement = document.getElementById(containerId);
    ajaxContainerElement.setAttribute('data-json-feed', url);

    Dynamo.GetContentFromJson(ajaxContainerElement, true);
}

//Call the Json provider, and show a preloader if it is chosen
Dynamo.prototype.GetContentFromJson = function (container, addToExisting) {
    var feed = container.getAttribute('data-json-feed');
    feed = feed.replace("?debug=true", "");
    feed = feed.replace("&debug=true", "");

    if (container.getAttribute('data-preloader') == "minimal") {
        if (!addToExisting) {
            while (container.firstChild) container.removeChild(container.firstChild);
        }

        container.classList.remove(dynamoConfig.hiddenClass);

        var preloaderElement = document.createElement('i');
        preloaderElement.className = dynamoConfig.preloaderClass;
        preloaderElement.setAttribute('id', (container.getAttribute('id') + "_preloader"));
        container.appendChild(preloaderElement);
    } else if (container.getAttribute('data-preloader') == "overlay") {
        var overlayElement = document.createElement('div');
        overlayElement.className = dynamoConfig.preloaderOverlayClass;
        overlayElement.setAttribute('id', "overlay");
        var overlayElementIcon = document.createElement('div');
        overlayElementIcon.className = dynamoConfig.preloaderOverlayIconClass;
        overlayElementIcon.style.top = window.pageYOffset + "px";
        overlayElement.appendChild(overlayElementIcon);

        if (document.getElementById(dynamoConfig.preloaderOverlayLocationID)) {
            document.getElementById(dynamoConfig.preloaderOverlayLocationID).parentNode.insertBefore(overlayElement, document.getElementById(dynamoConfig.preloaderOverlayLocationID));
        }
    } 

    if (container.hasAttribute('data-pre-render-template') && !container.hasChildNodes()) {
        var preRenderElement = document.createElement('div');
        preRenderElement.innerHTML = Dynamo.LoadTemplate(container.getAttribute('data-pre-render-template'));

        var newElementNodes = preRenderElement.childNodes;
        for (var item = 1; item < newElementNodes.length; item++) {
            container.appendChild(newElementNodes[item]);
        }
    }

    if (/Edge\/\d./i.test(navigator.userAgent)) {
        var currentTime = new Date();
        feed += "&Tick=" + currentTime.getTime();
    }

    var xhr = new XMLHttpRequest();
    xhr.open('GET', feed, true);
    xhr.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            var data;

            if (this.response.trim() != "" && Dynamo.IsJsonString(this.response)) {
                if (xhr.responseType === 'json') {
                    data = xhr.response.message;
                } else {
                    data = JSON.parse(this.response);
                }

                if (!addToExisting) {
                    cache[container.getAttribute('id')] = data;
                } else {
                    for (var i = 0; i < data.lengt; i++) {
                        cache[container.getAttribute('id')].push(data[i]);
                    }
                }

                Dynamo.CreateItemsFromJson(data, container, addToExisting);
            } else {
                if (container.hasAttribute('data-no-result-template')) {
                    while (container.firstChild) container.removeChild(container.firstChild);

                    if (document.getElementById('overlay')) {
                        document.getElementById('overlay').parentNode.removeChild(document.getElementById('overlay'));
                    }

                    var noResultsRenderElement = document.createElement('div');
                    noResultsRenderElement.innerHTML = Dynamo.LoadTemplate(container.getAttribute('data-no-result-template'));

                    var newElementNodes = noResultsRenderElement.childNodes;
                    for (var item = 1; item < newElementNodes.length; item++) {
                        container.appendChild(newElementNodes[item]);
                    }
                }
            }
        } else {
            if (!container.hasAttribute('data-no-result-template')) {
                Dynamo.CleanContainer(container, addToExisting);
            }
        }
    };
    xhr.send();
}

Dynamo.prototype.IsJsonString = function (str) {
    try {
        JSON.parse(str);
    } catch (e) {
        return false;
    }
    return true;
}

//Create visual elements from the data provided and with the chosen template
Dynamo.prototype.CreateItemsFromJson = function (data, container, addToExisting, count) {
    Dynamo.CleanContainer(container, addToExisting);

    if (!count) {
        count = 0;
    }

    if (document.body.contains(container)) {

        for (var i = 0; i < data.length; i++) {
            var templateId;

            //Get template from either the data attribute or a 'template' property in the JSON feed
            if (container.hasAttribute('data-template')) {
                templateId = container.getAttribute('data-template');
            } 
            
            for (var property in data[i]) {
                if (property == "template") {
                    if (data[i][property] != null) {
                        templateId = data[i][property];
                        container.setAttribute('data-template', templateId);
                    }
                }
            }

            //If a template setting is found in a cookie, then use that one insted af the above
            if (container.hasAttribute('data-save-cookie')) {
                if (Dynamo.GetCookie(container.getAttribute("id") + "Template")) {
                    templateId = Dynamo.GetCookie(container.getAttribute("id") + "Template");
                }

                var cookieId = container.getAttribute("id") + "Template=";
                if (document.cookie.indexOf(cookieId) != -1) {
                    document.cookie.replace(cookieId, templateId)
                } else {
                    document.cookie = cookieId + templateId;
                }  
            }

            //Create a temporary container to contain the parsed element before rendering
            var temporaryElementType = container.tagName;
            var temporaryElement = document.createElement(temporaryElementType);

            temporaryElement.innerHTML = Dynamo.RenderItem(data[i], templateId);

            var newElementNodes = temporaryElement.childNodes;
            for (var item = 1; item < newElementNodes.length; item++) {
                container.appendChild(newElementNodes[item]);
            }

            var event = new CustomEvent('itemCreated', { 'detail': data[i] });
            container.dispatchEvent(event);

            //Check to see if there is a sub nodelists in the data provided, if so then render new items 
            for (var property in data[i]) {
                if (typeof data[i][property] == 'object') {
                    var subContainer = document.getElementById(property);
                    //Make the ID unique for each sub object
                    var uniqueId = data[i].id ? property + data[i].id : count == 0 ? property : property + count;

                    //Fix for multiple instances of the same element (Fx. multiple mini carts), while supporting different views (Fx. a product list) 
                    if (document.getElementById(uniqueId)) {
                        if (!document.getElementById(uniqueId).hasAttribute('data-save-cookie')) {
                            uniqueId = uniqueId + Math.floor((Math.random() * 100000));
                        }
                    }

                    cache[uniqueId] = data[i][property];

                    if (subContainer) {
                        subContainer.setAttribute('id', uniqueId);
                        subContainer = document.getElementById(uniqueId);

                        var subData = data[i][property];

                        if (subData != null) {
                            if (subData.length > 0) {
                                Dynamo.CreateItemsFromJson(data[i][property], subContainer, addToExisting, count);
                            } else {
                                subContainer.classList.add(dynamoConfig.hiddenClass);
                            }
                        }
                    }

                    count++;
                }
            }
        }

        Dynamo.ContentCreated(container);
    }
}

Dynamo.prototype.ContentCreated = function (container) {
    container.classList.remove(dynamoConfig.hiddenClass);

    var event = document.createEvent('Event');
    event.initEvent('contentLoaded', true, true);
    container.dispatchEvent(event);
}

//Clean the container for either all the elements or the preloader
Dynamo.prototype.CleanContainer = function (container, addToExisting) {
    if (document.body.contains(container)) {
        if (container.getAttribute('data-preloader') == "minimal" && document.getElementById(container.getAttribute('id') + "_preloader")) {
            container.removeChild(document.getElementById(container.getAttribute('id') + "_preloader"));
        } else if (document.getElementById('overlay')) {
            document.getElementById('overlay').parentNode.removeChild(document.getElementById('overlay'));
        }

        if (!addToExisting) {
            while (container.firstChild) container.removeChild(container.firstChild);
            container.classList.add(dynamoConfig.hiddenClass);
        }
    }
}

//Parse the data properties into the element                            
Dynamo.prototype.RenderItem = function (data, templateId) {
    var template = Dynamo.LoadTemplate(templateId);

    if (template != null) {
        for (var property in data) {
            var item = data[property];
            var nameKey = "{{" + property + "}}";                        

            template = template.replace(new RegExp(nameKey, "gi"), item);
        }
    }

    return template;
}

//Load the chosen template
Dynamo.prototype.LoadTemplate = function (templateId) {
    if (document.getElementById(templateId)) {
        return document.getElementById(templateId).innerHTML;
    } else {
        console.log("Dynamo: Template element not found - " + templateId);
        return null;
    }
}

//Parse to finde the chosen cookie
Dynamo.prototype.GetCookie = function(name) {
    var pattern = RegExp(name + "=.[^;]*"),
        matched = document.cookie.match(pattern);

    if (matched) {
        var cookie = matched[0].split('=')
        return cookie[1]
    }
    return false
}


//Auto initialization
var Dynamo = new Dynamo();

document.addEventListener("DOMContentLoaded", function (event) {
    Dynamo.GetConfiguration();

    var ajaxContainer = document.getElementsByClassName("js-ajax-container");

    for (var i = 0; i < ajaxContainer.length; i++) {
        var ajaxContainerElement = ajaxContainer[i];

        if (!ajaxContainerElement.getAttribute('data-json-feed')) {
            console.log("Ajax element: Please specify json feed via data attribute: data-json-feed");
        }

        if (!ajaxContainerElement.hasAttribute('data-init-onload') || ajaxContainerElement.getAttribute('data-init-onload') == false) {
            Dynamo.GetContentFromJson(ajaxContainerElement);
        } 
    }

    window.addEventListener('popstate', function (event) {
        location.reload();
    });
});



//IE Polyfill for CustomEvents
(function () {

    if (typeof window.CustomEvent === "function") return false;

    function CustomEvent(event, params) {
        params = params || { bubbles: false, cancelable: false, detail: undefined };
        var evt = document.createEvent('CustomEvent');
        evt.initCustomEvent(event, params.bubbles, params.cancelable, params.detail);
        return evt;
    }

    CustomEvent.prototype = window.Event.prototype;

    window.CustomEvent = CustomEvent;
})();
var DynamoConfig = function () { }

DynamoConfig.prototype.Configuration = function () {
  var dynamoConfigObject = {
    hiddenClass: "u-hidden",
    preloaderClass: "fa fa-circle-o-notch fa-spin preloader",
    preloaderOverlayClass: "preloader-overlay",
    preloaderOverlayIconClass: "preloader-overlay__icon",
    preloaderOverlayLocationID: "content"
  };

  return dynamoConfigObject;
}

var DynamoConfig = new DynamoConfig();

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
var ImageList = function () { }

ImageList.prototype.LoadImage = function (selectedThumb) {
    var thumbButtons = document.getElementsByClassName("js-thumb-btn");

    for (var i = 0; i < thumbButtons.length; i++) {
        var thumbBtn = thumbButtons[i];
        if (thumbBtn.getAttribute('data-for') == selectedThumb.getAttribute('data-for')) {
            thumbBtn.classList.remove('thumb-list__item--active');
        }
    }

    selectedThumb.classList.add('thumb-list__item--active');
    var targetImageElement = document.getElementById(selectedThumb.getAttribute('data-for'));

    if (targetImageElement) {
        targetImageElement.src = selectedThumb.getAttribute('data-image-path');
        targetImageElement.setAttribute("data-full-image", selectedThumb.getAttribute('data-full-image'));
    } 
}

ImageList.prototype.GetPreviousImage = function (thisButton) {
    var galleryContainer = thisButton.closest('.js-gallery-slider');
    var galleryImage = galleryContainer.getElementsByClassName("js-gallery-image")[0];
    var images = galleryContainer.getAttribute("data-images").split(",");
    var currentImage = galleryContainer.getAttribute("data-current-image");
    var totalImages = galleryContainer.getAttribute("data-total-images");

    if (currentImage > 0) {
        currentImage--;
    } else {
        currentImage = (totalImages - 1);
    }

    galleryImage.src = images[currentImage];
    galleryContainer.setAttribute("data-current-image", currentImage);
    galleryContainer.getElementsByClassName("js-image-list-counter")[0].innerHTML = (currentImage + 1);
}

ImageList.prototype.GetNextImage = function (thisButton) {
    var galleryContainer = thisButton.closest('.js-gallery-slider');
    var galleryImage = galleryContainer.getElementsByClassName("js-gallery-image")[0];
    var images = galleryContainer.getAttribute("data-images").split(",");
    var currentImage = galleryContainer.getAttribute("data-current-image");
    var totalImages = galleryContainer.getAttribute("data-total-images");

    if (currentImage < (totalImages-1)) {        
        currentImage++;
    } else {
        currentImage = 0;
    }

    galleryImage.src = images[currentImage];
    galleryContainer.setAttribute("data-current-image", currentImage);
    galleryContainer.getElementsByClassName("js-image-list-counter")[0].innerHTML = (currentImage + 1);
}

//Polyfill for Closest()
if (window.Element && !Element.prototype.closest) {
    Element.prototype.closest =
    function (s) {
        var matches = (this.document || this.ownerDocument).querySelectorAll(s),
            i,
            el = this;
        do {
            i = matches.length;
            while (--i >= 0 && matches.item(i) !== el) { };
        } while ((i < 0) && (el = el.parentElement));
        return el;
    };
}

var ImageList = new ImageList();

var LoadMore = function () { }

LoadMore.prototype.Next = function (selected) {
    var pagesize = parseInt(selected.getAttribute("data-page-size"));
    var url = selected.getAttribute("data-feed-url") + location.search.replace("?", "&") + "&feedType=productsOnly";
    url = LoadMore.replaceUrlParam("pagesize", pagesize, url)
    var container = selected.getAttribute("data-container");
    var currentPage = selected.getAttribute("data-current");
    var totalPages = selected.getAttribute("data-total");

    console.log(url);

    currentPage++;

    selected.setAttribute("data-current", currentPage);

    url += "&pagenum=" + currentPage;

    if (currentPage <= totalPages) {
        Dynamo.AddContent(container, url);

        if (LoadMore.getParameter("pagesize")) {
            pagesize += parseInt(LoadMore.getParameter("pagesize"));
        } else {
            pagesize = (pagesize * 2);
        }

        var url = LoadMore.replaceUrlParam("pagesize", pagesize, window.location.href);
        history.pushState(null, null, url);
    }

    if (currentPage == totalPages) {
        selected.classList.add('disabled');
    }
}

LoadMore.prototype.replaceUrlParam = function (paramName, paramValue, url) {
    var pattern = new RegExp('\\b(' + paramName + '=).*?(&|$)');
    if (url.search(pattern) >= 0) {
        return url.replace(pattern, '$1' + paramValue + '$2');
    }

    return url + (url.indexOf('?') > 0 ? '&' : '?') + paramName + '=' + paramValue
}

LoadMore.prototype.getParameter = function (theParameter) {
    var params = window.location.search.substr(1).split('&');

    for (var i = 0; i < params.length; i++) {
        var p = params[i].split('=');
        if (p[0] == theParameter) {
            return decodeURIComponent(p[1]);
        }
    }
    return false;
}

var LoadMore = new LoadMore();

var RememberState = function () { }
var loadedRememberStateElements = [];
var observer = new MutationObserver(function (mutations) { });
var config = { attributes: true, childList: false, characterData: false }

document.addEventListener("DOMContentLoaded", function (event) {
    RememberState.GetState();

    //Make it work with Ajax loaded content
    var ajaxContainer = document.getElementsByClassName("js-ajax-container");
    if (ajaxContainer.length > 0) {
        for (var i = 0; i < ajaxContainer.length; i++) {
            ajaxContainer[i].addEventListener('contentLoaded', function (e) {
                RememberState.GetState();
            }, false);
        }
    }
});

RememberState.prototype.SaveState = function () {
    var rememberStateElements = document.getElementsByClassName("js-remember-state");

    for (var elm = 0; elm < rememberStateElements.length; elm++) {
        var target = rememberStateElements[elm];

        if (RememberState.ElementExists(target.id) == false) {

            //Save cookie when an attribute changes on the element
            observer = new MutationObserver(function (mutations) {
                var stateCookie = "StateCookie_" + mutations[0].target.id + "=[{";

                if (target.getAttribute("type") != "checkbox") {
                    var count = 0;

                    mutations.forEach(function (mutation) {
                        stateCookie += '"' + mutation.attributeName + '": "' + mutation.target.getAttribute(mutation.attributeName) + '"';
                        if (count != mutations.length - 1) {
                            stateCookie += ",";
                        }
                        count++;
                    });
                } else {
                    stateCookie += '"checked": "' + mutations[0].target.checked + '"';
                }

                stateCookie += "}]";

                document.cookie = stateCookie;
            });

            if (target.getAttribute("type") == "checkbox") {
                target.addEventListener('click', function (e) {
                    e.target.setAttribute('checked', e.target.checked);
                });
            }

            observer.observe(target, config);
        }

        loadedRememberStateElements.push(target.id);
    }
}

RememberState.prototype.GetState = function () {
    var rememberStateElements = document.getElementsByClassName("js-remember-state");

    for (var elm = 0; elm < rememberStateElements.length; elm++) {
        var target = rememberStateElements[elm];

        //Get the cookie and set the saved attributes
        var resultCookie = RememberState.GetCookie("StateCookie_" + target.id);

        if (resultCookie) {
            resultCookie = JSON.parse(resultCookie);

            for (var crumb = 0; crumb < resultCookie.length; crumb++) {
                for (property in resultCookie[crumb]) {
                    target.setAttribute(property, resultCookie[crumb][property]);

                    if (property == "checked") {
                        if (resultCookie[crumb][property] == "false") {
                            target.removeAttribute("checked");
                        } else {
                            target.checked = true;
                        }
                    }
                }
            }
        } 
    }

    //Set up remember state again after the last state is set
    RememberState.SaveState();
}

//Parse to find the chosen cookie
RememberState.prototype.ElementExists = function (elementId) {
    var condition = false;

    for (var i = 0; i < loadedRememberStateElements.length; i++) {
        if (loadedRememberStateElements[i] == elementId) {
            condition = true;
        }
    }

    return condition
}

//Parse to find the chosen cookie
RememberState.prototype.GetCookie = function (name) {
    var pattern = RegExp(name + "=.[^;]*"),
        matched = document.cookie.match(pattern);

    if (matched) {
        var cookie = matched[0].split('=')
        return cookie[1]
    }
    return false
}


//Set simple checkbox state by url parameter (js-remember-state class not required)
RememberState.prototype.getSearchParameters = function() {
    var paramstring = window.location.search.substr(1);
    return paramstring != null && paramstring != "" ? RememberState.transformToAssocArray(paramstring) : {};
}

RememberState.prototype.transformToAssocArray = function (paramstring) {
    var params = {};
    var paramsarray = paramstring.split("&");
    for (var i = 0; i < paramsarray.length; i++) {
        var tmparray = paramsarray[i].split("=");
        params[tmparray[0]] = tmparray[1];
    }
    return params;
}

document.addEventListener("DOMContentLoaded", function (event) {
    var params = RememberState.getSearchParameters();

    for (property in params) {
        if (document.getElementById(property)) {
            var element = document.getElementById(property);

            if (element.type === 'checkbox') {
                element.checked = params[property];
            }
        }
    }
});

var RememberState = new RememberState();

var Scroll = function () { }

document.addEventListener("DOMContentLoaded", function (event) {
    var ajaxContainer = document.getElementsByClassName("js-ajax-container");

    if (ajaxContainer.length > 0) {
        for (var i = 0; i < ajaxContainer.length; i++) {
            ajaxContainer[i].addEventListener('contentLoaded', function (e) {
                Scroll.SetPosition();
                Scroll.SetPagePosition();
            }, false);
        }
    }

    Scroll.SetPagePosition();
});

Scroll.prototype.SavePosition = function (e) { 
    e.preventDefault();

    var url = window.location.href;

    var seperator = "?";
    if (url.indexOf("?") != -1) {
        seperator = "&";
    }

    var scrollPos = document.documentElement.scrollTop || document.body.scrollTop;

    if (Scroll.getURLParameter("ScrollPos")) {
        url = url.replace(/\bScrollPos=[^&#]+/g, "ScrollPos=" + Math.round(scrollPos));
    } else {
        url = window.location + seperator + "ScrollPos=" + Math.round(scrollPos);
    }
    
    history.replaceState(null, null, url);

    window.location.href = e.currentTarget.getAttribute("href");
}

Scroll.prototype.SetPosition = function () {
    var scrollPos = Scroll.getURLParameter("ScrollPos");

    if (scrollPos != null) {
        window.scroll(0, scrollPos);
    }
}

Scroll.prototype.SetPagePosition = function () {
    if (document.getElementById("Page").classList.contains("js-page-pos")) {
        var topHeight = document.getElementById("Top").clientHeight;
        var scrollDelay = 1;

        if (/Edge\/\d./i.test(navigator.userAgent)) {
            scrollDelay = 500;
        }

        if (topHeight > 0) {
            document.getElementById("Page").style.marginTop = topHeight + "px";
        } else {
            setTimeout(function () {
                topHeight = document.getElementById("Top").clientHeight;
                document.getElementById("Page").style.marginTop = topHeight + "px";
            }, scrollDelay);
        }
        
    }
}

Scroll.prototype.getURLParameter = function (name) {
    return decodeURIComponent((new RegExp('[?|&]' + name + '=' + '([^&;]+?)(&|#|;|$)').exec(location.search) || [null, ''])[1].replace(/\+/g, '%20')) || null;
}


var Scroll = new Scroll();

var Search = function () { }

function debounce(method, delay) {
    var timer;
    return function () {
        clearTimeout(timer);
        timer = setTimeout(function () {
            method();
        }, delay);
    };
}

Search.prototype.Init = function () {
    var searchElements = document.querySelectorAll(".js-typeahead");
    var nodesArray = [].slice.call(searchElements);
    nodesArray.forEach(function (searchElement) {
        const groupsBtn         = searchElement.querySelector(".js-typeahead-groups-btn"),
              groupsContent     = searchElement.querySelector(".js-typeahead-groups-content"),
              searchField       = searchElement.querySelector(".js-typeahead-search-field"),
              searchContent     = searchElement.querySelector(".js-typeahead-search-content"),
              enterBtn          = searchElement.querySelector(".js-typeahead-enter-btn"),
              options           = {
                  pageSize:       searchElement.getAttribute("data-page-size"),
                  searchPageId:   searchElement.getAttribute("data-search-page-id"),
                  resultPageId:   searchElement.getAttribute("data-result-page-id"),
                  groupsPageId:   searchElement.getAttribute("data-groups-page-id"),
                  searchTemplate: searchContent.getAttribute("data-template")
              };
        var   selectionPosition = -1;

        if (groupsBtn) {
            groupsBtn.onclick = function () {
                Dynamo.UpdateContent(groupsContent.getAttribute("id"), '/Default.aspx?ID=' + options.groupsPageId + '&feedType=' + 'productGroups');
            }
        }

        searchField.onkeyup = debounce(function () {
            var query = searchField.value;
            selectionPosition = -1

            if (groupsBtn) {
                if (groupsBtn.getAttribute("data-group-id") != "all") {
                    query += "&GroupID=" + groupsBtn.getAttribute("data-group-id");
                }
            }

            if (query.length > 2) {
                Dynamo.UpdateContent(searchContent.getAttribute("id"),
                                     '/Default.aspx?ID='   + options.searchPageId +
                                     '&feedType='          + 'productsOnly' +
                                     '&pagesize='          + options.pageSize +
                                     '&Search='            + query +
                                     (options.searchTemplate ? '&Template=' + options.searchTemplate : ''));
                document.getElementsByTagName('body')[0].addEventListener('keydown', keyPress, false);
            } else {
                Dynamo.CleanContainer(searchContent);
            }
        }, 500);

        function clickedOutside(e) {
            if (searchContent.contains(e.target)) {
                document.getElementsByTagName('body')[0].removeEventListener('keydown', keyPress, false);
                return;
            }

            if (e.target != searchField && !e.target.classList.contains("js-ignore-click-outside")) {
                Dynamo.CleanContainer(searchContent);
            }

            if (groupsBtn) {
                if (e.target != groupsBtn && !groupsContent.contains(e.target)) {
                    Dynamo.CleanContainer(groupsContent);
                }
            }

            document.getElementsByTagName('body')[0].removeEventListener('keydown', keyPress, false);
        }

        function keyPress(e) {
            const KEY_CODE = {
                LEFT:   37,
                TOP:    38,
                RIGHT:  39,
                BOTTOM: 40,
                ENTER:  13
            };

            if ([KEY_CODE.LEFT, KEY_CODE.TOP, KEY_CODE.RIGHT, KEY_CODE.BOTTOM].indexOf(e.keyCode) > -1) {
                e.preventDefault();
            }

            if (e.keyCode == KEY_CODE.BOTTOM && selectionPosition < (options.pageSize - 1)) {
                selectionPosition++;
                searchField.blur();
            }

            if (e.keyCode == KEY_CODE.TOP && selectionPosition > 0) {
                selectionPosition--;
                searchField.blur();
            }

            var selectedElement = searchContent.childNodes[selectionPosition];

            if (e.keyCode == KEY_CODE.TOP || e.keyCode == KEY_CODE.BOTTOM) {
                for (var i = 0; i < searchContent.childNodes.length; i++) {
                    searchContent.childNodes[i].classList.remove("active");
                }

                if (selectedElement && selectedElement.getElementsByClassName("js-typeahead-name")[0]) {
                    selectedElement.classList.add("active");
                    searchField.value = selectedElement.getElementsByClassName("js-typeahead-name")[0].innerHTML;
                }
            }

            if (selectedElement && e.keyCode == KEY_CODE.ENTER) {
                selectedElement.click();
                document.getElementsByTagName('body')[0].removeEventListener('keydown', keyPress, false);
            }

            if (e.keyCode == KEY_CODE.ENTER) {
                GetLinkBySelection(selectedElement);
            }
        }

        function GetLinkBySelection(selectedElement) {
            var jslink = selectedElement ? selectedElement.getElementsByClassName("js-typeahead-link") : "";

            if (jslink.length > 0) {
                window.location.href = jslink[0].getAttribute("href");
            }
        }

        if (enterBtn) {
            enterBtn.onclick = function () {
                window.location.href = '/Default.aspx?ID=' + options.resultPageId + '&Search=' + searchField.value;
            }
        }

        document.getElementsByTagName('body')[0].addEventListener('click', clickedOutside, true);
    });
}

Search.prototype.UpdateGroupSelection = function (selectedElement) {
    const groupsContent = selectedElement.parentNode,
          groupsBtn     = groupsContent.parentNode.querySelector(".js-typeahead-groups-btn");

    groupsBtn.setAttribute("data-group-id", selectedElement.getAttribute("data-group-id"));
    groupsBtn.innerHTML = selectedElement.innerText;

    Dynamo.CleanContainer(groupsContent);
}

Search.prototype.UpdateFieldValue = function (selectedElement) {
    const searchContent = selectedElement.parentNode,
          searchField   = searchContent.parentNode.querySelector(".js-typeahead-search-field");

    searchField.value = selectedElement.querySelector(".js-typeahead-name").innerText;

    Dynamo.CleanContainer(searchContent);
}

Search.prototype.ResetExpressSearch = function () {
    const searchField   = document.getElementById("ExpressBuyProductSearchField"),
          quantityField = document.getElementById("ExpressBuyProductCount");

    if (searchField && quantityField) {
        searchField.value = "";
        quantityField.value = "1";
        searchField.focus();
    }
}

var Search = new Search();

document.addEventListener("DOMContentLoaded", Search.Init);
var Variants = function () { }

var productFeedId = 0;
var productUrl = "";
var viewMode = "";


Variants.prototype.VariantGroup = function (id, name, options) {
    this.id = id;
    this.name = name;
    this.VariantOptions = options;
}

Variants.prototype.VariantOption = function (id, productid, name, selected, disabled, color, image) {
    this.id = id;
    this.productid = productid;
    this.name = name;
    this.selected = selected;
    this.disabled = disabled;
    this.color = color;
    this.image = image;
    if (image) {
        this.template = "VariantOptionImage";
    } else {
        this.template = "VariantOption";
    }
}

Variants.prototype.CombinationItem = function (id) {
    this.id = id;
}

Variants.prototype.VariantObject = function (id, variants, combinations) {
    this.id = id;
    this.Variants = variants;
    this.Combinations = combinations;
}

Variants.prototype.SetVariantOptionStatesForProductList = function (variantContainer) {
    if (variantContainer) {
        var productId = variantContainer.getAttribute("data-product-id");
        var product = Dynamo.FindDataInCache("Product" + productId)[0];
        if (product) {
            var variants = product.Variants;
            var combinations = product.Combinations;
            if (variants.length > 0 && combinations.length > 0) {
                Variants.SetVariantOptionStates(variants, combinations);
                Variants.HandleSelection(variants, productId, false);
            }
        }
    }
}

Variants.prototype.SetProductFeedId = function (id) {
    productFeedId = id;
}

Variants.prototype.SetProductUrl = function (url) {
    productUrl = url;
}

Variants.prototype.SetViewMode = function (mode) {
    viewMode = mode;
}

Variants.prototype.InitVariants = function (variants, combinations, productId) {
    viewMode = "singleProduct";
    var data = [];
    Variants.SetVariantOptionStates(variants, combinations);
    Variants.HandleSelection(variants, productId, false);
    var obj = new Variants.VariantObject(productId, variants, combinations);
    data.push(obj);
}

Variants.prototype.UpdateVariants = function (selectedVariant, createItemsFromJSON) {
    var data = Variants.ModifyDataByAvailableVariants(selectedVariant, true);

    if (createItemsFromJSON != false) {
        var productId = selectedVariant.getAttribute("data-product-id");
        Dynamo.CreateItemsFromJson(data, document.getElementById('Variants' + productId));
    }
}

Variants.prototype.ModifyDataByAvailableVariants = function (selectedVariant, updateLocation) {
    var id = selectedVariant.id;
    var productId = selectedVariant.getAttribute("data-product-id");
    var variantsData = Dynamo.FindDataInCache("Variants" + productId);
    var combinations = Dynamo.FindDataInCache("Combinations" + productId);

    Variants.ChangeSelectedOption(id, variantsData);
    Variants.SetVariantOptionStates(variantsData, combinations);
    Variants.HandleSelection(variantsData, productId, true, updateLocation);

    Dynamo.SetDataInCache(("Variants" + productId), variantsData);

    return variantsData;
}

Variants.prototype.HandleSelection = function (variantsData, productId, updateContent, updateLocation) {
    var selections = Variants.FindSelectedVariants(variantsData);

    if (selections.length == variantsData.length) {
        var selectedVariantId = selections.join(".");
        if (viewMode == "singleProduct" && updateLocation) {
            var url = Variants.ReplaceUrlParam("VariantID", selectedVariantId, productUrl);
            updateContent = false;
            location.href = url;
        }
        var variantElement = document.getElementById("Variant_" + productId);
        if (variantElement) {
            variantElement.value = selectedVariantId;
        }
        Variants.SelectionComplete(productId, selections, updateContent);
    } else {
        Variants.SelectionMissing(productId);
    }
}

Variants.prototype.ChangeSelectedOption = function (selectedVariantId, variants) {
    for (var i = 0; i < variants.length; i++) {
        var groupOptions = variants[i]['VariantOptions'];
        if (groupOptions.some(function (option) {
            return option.id == selectedVariantId;
        })) {
            groupOptions.forEach(function (option) {
                var selected = (option.id == selectedVariantId ? (option.selected == "checked" ? "" : "checked") : "");
                option.selected = selected;
                if (viewMode == "singleProduct") {
                    if (selected == "checked") {
                        document.getElementById(option.id).classList.add("checked");
                    } else {
                        document.getElementById(option.id).classList.remove("checked");
                    }
                    document.getElementById(option.id).setAttribute("data-check", selected);
                }
            });
        }
    }
}

Variants.prototype.SetVariantOptionStates = function (variants, combinations) {
    var availableVariants = [];

    var selectedCombination = variants.map(function (vg) {
        var selectedOption = vg['VariantOptions'].filter(function (option) {
            return option.selected == "checked";
        })[0];
        return selectedOption ? selectedOption.id : "";
    });

    combinations = combinations.map(function (combination) { return combination.id.split("."); });

    if (combinations.length > 0) {
        var combinationsByGroup = [];
        combinations.forEach(function (arr, key) {
            arr.forEach(function (val, arrkey) {
                if (!combinationsByGroup[arrkey]) { combinationsByGroup[arrkey] = []; }
                combinationsByGroup[arrkey].push(val);
            });
        });

        for (currentVariantGroup = 0; currentVariantGroup < variants.length; currentVariantGroup++) {
            var disabledOptions = [];
            var otherOptionsSelected = false;
            for (otherVariantGroup = 0; otherVariantGroup < variants.length; otherVariantGroup++) {
                if (selectedCombination[otherVariantGroup] != "") {
                    if (otherVariantGroup != currentVariantGroup) {
                        otherOptionsSelected = true;
                        var otherGroupAvailableCombinations = combinationsByGroup[otherVariantGroup];

                        var availableOptions = []
                        for (var i = 0; i < otherGroupAvailableCombinations.length ; i++) {
                            var otherAvailableCombination = otherGroupAvailableCombinations[i];
                            if (otherAvailableCombination == selectedCombination[otherVariantGroup]) {
                                availableOptions.push(combinationsByGroup[currentVariantGroup][i]);
                            }
                        }

                        for (property in variants[currentVariantGroup]) {
                            var groupProperty = variants[currentVariantGroup][property];
                            if (typeof groupProperty == 'object') {
                                var otherGroupProperty = variants[otherVariantGroup][property];
                                for (variantOption = 0; variantOption < groupProperty.length; variantOption++) {
                                    //var found = false;
                                    var otherGroupOption = otherGroupProperty[variantOption];
                                    var groupOption = groupProperty[variantOption];
                                    if (availableOptions.indexOf(groupOption.id) == -1) {
                                        disabledOptions.push(groupOption.id);
                                        if (viewMode == "singleProduct") {
                                            document.getElementById(groupOption.id).disabled = true;
                                            document.getElementById(groupOption.id).classList.add("disabled");
                                        }
                                        groupOption.disabled = "disabled";
                                    } else if (disabledOptions.indexOf(groupOption.id) == -1) {
                                        if (viewMode == "singleProduct") {
                                            document.getElementById(groupOption.id).disabled = false;
                                            document.getElementById(groupOption.id).classList.remove("disabled");
                                        }
                                        groupOption.disabled = "";
                                    }
                                }
                            }
                        }
                    }
                }
            }
            if (!otherOptionsSelected) {
                variants[currentVariantGroup]['VariantOptions'].forEach(function (option) {
                    if (viewMode == "singleProduct") {
                        document.getElementById(option.id).disabled = false;
                        document.getElementById(option.id).classList.remove("disabled");
                    }
                    option.disabled = "";
                });
            }
        }
    }

    return variants;
}

Variants.prototype.FindSelectedVariants = function (variants) {
    var selections = [];
    for (variantGroup = 0; variantGroup < variants.length; variantGroup++) {
        for (property in variants[variantGroup]) {
            if (typeof variants[variantGroup][property] == 'object') {
                for (variantOption = 0; variantOption < variants[variantGroup][property].length; variantOption++) {
                    if (variants[variantGroup][property][variantOption].selected == "checked") {
                        selections.push(variants[variantGroup][property][variantOption].id);
                    }
                }
            }
        }
    }
    return selections;
}

Variants.prototype.ResetSelections = function (variants) {
    for (variantGroup = 0; variantGroup < variants.length; variantGroup++) {
        for (property in variants[variantGroup]) {
            if (typeof variants[variantGroup][property] == 'object') {
                for (variantOption = 0; variantOption < variants[variantGroup][property].length; variantOption++) {
                    variants[variantGroup][property][variantOption].selected = "";
                    variants[variantGroup][property][variantOption].disabled = "";
                }
            }
        }
    }
    return variants;
}

Variants.prototype.ReplaceUrlParam = function (paramName, paramValue, url) {
    var url = url || window.location.href;

    var pattern = new RegExp('\\b(' + paramName + '=).*?(&|$)');
    if (url.search(pattern) >= 0) {
        return url.replace(pattern, '$1' + paramValue + '$2');
    }

    return url + (url.indexOf('?') > 0 ? '&' : '?') + paramName + '=' + paramValue
}

Variants.prototype.SelectionMissing = function (productId) {
    document.getElementById('CartButton_' + productId).disabled = true;
    document.getElementById('CartButton_' + productId).classList.add('disabled');
    document.getElementById('helpText_' + productId).classList.remove('u-visibility-hidden');

    var variantElement = document.getElementById('Variant_' + productId);
    if (variantElement) {
        variantElement.value = '';
    }

    if (document.getElementById('Favorite' + productId)) {
        document.getElementById('Favorite' + productId).classList.add('disabled');
    }
}

Variants.prototype.SelectionComplete = function (productId, selections, updateContent) {
    document.getElementById('CartButton_' + productId).disabled = false;
    document.getElementById('CartButton_' + productId).classList.remove('disabled');
    document.getElementById('helpText_' + productId).classList.add('u-visibility-hidden');

    var selectedVatiantId = selections.join(".");

    var variantElement = document.getElementById('Variant_' + productId);
    if (variantElement) {
        variantElement.value = selectedVatiantId;
    }

    if (document.getElementById('Favorite' + productId)) {
        document.getElementById('Favorite' + productId).classList.remove('disabled');
    }

    if (updateContent) {
        var feedUrl = "/Default.aspx?ID=" + productFeedId + "&ProductID=" + productId + "&VariantID=" + selectedVatiantId;
        var containerId = "Product" + productId;
        Dynamo.UpdateContent(containerId, feedUrl);
    }
}

var Variants = new Variants();


var Wireframe = function () { }

var wireframeConfig = {
    cssFilesToRemove: ["rapidoCss", "igniteCss"],
    hasDynamo: true,
    paragraphContainerClass: "paragraph-container",
    backgroundImageContainers: ["paragraph-container", "multiple-paragraphs-container"],
    mediaContainers: ["google-map", "video-wrapper"],
    hiddenClass: "u-hidden",
    visuallyHiddenClass: "u-visually-hidden",
    wireImageClass: "wire-image",
    wireBackgroundImageClass: "wire-image-lines",
    wireGrayscaleClass: "wire-grayscale",
    lightBoxImageClass: "lightbox__image",
    elementsWithColorClasses: ["u-color-warning"],
    replacementColorClass: "u-color-light-gray",
    elementsWithBackgroundColorClasses: ["u-color-warning--bg"],
    replacementBackgroundColorClass: "u-color-light-gray--bg"
};

Wireframe.prototype.GetConfiguration = function () {
    if (typeof WireframeConfig == 'object') {
        wireframeConfig = WireframeConfig.Configuration();
    }
}

var _wireframeMode = false;

Wireframe.prototype.Init = function (wireframeMode) {
    if (wireframeMode == true) {
        //Render as Wireframe
        document.addEventListener("DOMContentLoaded", function (event) {
            Wireframe.GetConfiguration();

            Wireframe.WireImages();

            for (var i = 0; i < wireframeConfig.cssFilesToRemove.length; i++) {
                document.getElementById(wireframeConfig.cssFilesToRemove[i]).setAttribute("href", "");
            }
            document.body.classList.remove(dynamoConfig.hiddenClass);
        });

        document.body.classList.add(dynamoConfig.hiddenClass);
        
        if (wireframeConfig.hasDynamo == true) {
            var ajaxContainer = document.getElementsByClassName("js-ajax-container");
            for (var i = 0; i < ajaxContainer.length; i++) {
                ajaxContainer[i].addEventListener('contentLoaded', function (e) {
                    Wireframe.WireImages();
                }, false);
            }
        }
    }

    _wireframeMode = wireframeMode;
}

//Render all images as 'abstract' symbolized images
Wireframe.prototype.WireImages = function () {
    if (_wireframeMode == true) {
        var imgElements = document.getElementsByTagName("IMG");

        for (var i = 0; i < imgElements.length; i++) {
            var imageElement = imgElements[i];

            if (!imageElement.classList.contains(dynamoConfig.hiddenClass) && !imageElement.classList.contains(wireframeConfig.lightBoxImageClass)) {
                var imageWireframe = document.createElement("DIV");
                imageWireframe.classList.add(wireframeConfig.wireImageClass);
                imageElement.parentElement.insertBefore(imageWireframe, imageElement.parentNode.firstChild);
            }

            if (imageElement.classList.contains(wireframeConfig.lightBoxImageClass)) {
                imageElement.classList.add(wireframeConfig.visuallyHiddenClass);
            }

            imageElement.classList.add(dynamoConfig.hiddenClass);
        }

        for (var i = 0; i < wireframeConfig.backgroundImageContainers.length; i++) {
            var imgBgElements = document.getElementsByClassName(wireframeConfig.backgroundImageContainers[i]);

            for (var elm = 0; elm < imgBgElements.length; elm++) {
                var imgBgElement = imgBgElements[elm];

                if (imgBgElement.style.backgroundImage != "") {
                    imgBgElement.setAttribute("style", "");
                    imgBgElement.classList.add(wireframeConfig.wireBackgroundImageClass);
                }
            }
        }

        var imgBgElements = document.getElementsByClassName(wireframeConfig.paragraphContainerClass);

        for (var i = 0; i < imgBgElements.length; i++) {
            var imgBgElement = imgBgElements[i];

            if (imgBgElement.getAttribute("style") != "") {
                imgBgElement.setAttribute("style", "");
                imgBgElement.classList.add(wireframeConfig.wireBackgroundImageClass);
            }
        }

        for (var i = 0; i < wireframeConfig.mediaContainers.length; i++) {
            var mediaElement = document.getElementsByClassName(wireframeConfig.mediaContainers[i]);

            for (var elm = 0; elm < mediaElement.length; elm++) {
                mediaElement[elm].classList.add(wireframeConfig.wireGrayscaleClass);
            }
        }

        for (var i = 0; i < wireframeConfig.elementsWithColorClasses.length; i++) {
            var warningColor = document.getElementsByClassName(wireframeConfig.elementsWithColorClasses[i]);

            for (var i = 0; i < warningColor.length; i++) {
                var warningElement = warningColor[i];

                warningElement.classList.remove(wireframeConfig.elementsWithColorClasses[i]);
                warningElement.classList.add(wireframeConfig.replacementColorClass);
            }
        }

        for (var i = 0; i < wireframeConfig.elementsWithBackgroundColorClasses.length; i++) {
            var warningColor = document.getElementsByClassName(wireframeConfig.elementsWithBackgroundColorClasses[i]);

            for (var i = 0; i < warningColor.length; i++) {
                var warningElement = warningColor[i];

                warningElement.classList.remove(wireframeConfig.elementsWithBackgroundColorClasses[i]);
                warningElement.classList.add(wireframeConfig.replacementBackgroundColorClass);
            }
        }

        for (var i = 0; i < document.getElementsByClassName("responsive-image").length; i++) {
            document.getElementsByClassName("responsive-image")[i].classList.remove("responsive-image--1-1");
            document.getElementsByClassName("responsive-image")[i].classList.remove("responsive-image--16-9");
            document.getElementsByClassName("responsive-image")[i].classList.remove("responsive-image--4-3");
        }
    }
}

var Wireframe = new Wireframe();
var WireframeConfig = function () { }

WireframeConfig.prototype.Configuration = function () {
    var wireframeConfigObject = {
        cssFilesToRemove: ["rapidoCss", "igniteCss"],
        hasDynamo: true,
        backgroundImageContainers: ["paragraph-container", "multiple-paragraphs-container"],
        mediaContainers: ["google-map", "video-wrapper"],
        hiddenClass: "u-hidden",
        visuallyHiddenClass: "u-visually-hidden",
        wireImageClass: "wire-image",
        wireBackgroundImageClass: "wire-image-lines",
        wireGrayscaleClass: "wire-grayscale",
        lightBoxImageClass: "lightbox__image",
        elementsWithColorClasses: ["u-color-warning"],
        replacementColorClass: "u-color-light-gray",
        elementsWithBackgroundColorClasses: ["u-color-warning--bg"],
        replacementBackgroundColorClass: "u-color-light-gray--bg"
    };

  return wireframeConfigObject;
}

var WireframeConfig = new WireframeConfig();