const imageHeadBag = document.querySelector('.image-head-bag');

function showBagImage() {
    imageHeadBag.style.display = 'block';
}

function hideImage() {
    imageHeadBag.style.display = 'none';
}

window.addEventListener('message', (event) => {
    if (event.data.type === 'showimage') {
        showBagImage();
    } else if (event.data.type === 'hideimage') {
        hideImage();
    }
});