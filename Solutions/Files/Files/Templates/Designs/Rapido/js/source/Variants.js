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

