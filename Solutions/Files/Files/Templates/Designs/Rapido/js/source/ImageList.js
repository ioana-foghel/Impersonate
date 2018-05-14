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