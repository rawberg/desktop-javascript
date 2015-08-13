// ES5 in all its splendor

function ready(fn) {
    if (document.readyState != 'loading') {
        fn();
    } else {
        document.addEventListener('DOMContentLoaded', fn);
    }
}

function buildVolumeNode(record) {
    var volContainerNode = document.createElement("div"),
        volLabelNode = document.createElement("span"),
        volUnitNode = document.createElement("span");

    volContainerNode.className = "ui attached segment";
    volLabelNode.innerText = record.name;
    var storageStats = Math.round(record.bytesAvailableCount) + record.bytesAvailableUnit + " / " +
        Math.round(record.bytesTotalCount) + record.bytesTotalUnit;
    volUnitNode.innerText = storageStats;

    volContainerNode.appendChild(volLabelNode);
    volContainerNode.appendChild(volUnitNode);

    return volContainerNode;
}

function emptyNode(el) {
    while (el.firstChild) {
        el.removeChild(el.firstChild);
    }
}

function render(data) {
    if(typeof data === "undefined") {
        throw "data required for rendering"
    }

    var volumeNodes = document.createDocumentFragment();
    data.forEach(function(volume) {
        volumeNodes.appendChild(buildVolumeNode(volume));
    });

    var el = document.querySelector(".volumes-container");
    emptyNode(el);
    el.appendChild(volumeNodes);
}

function spinnerShow() {
    var el = document.querySelector(".volumes-container"),
        spinnerNode = document.createElement("div"),
        spinnerLabel = document.createElement("div");

    emptyNode(el);
    spinnerNode.className = "ui active inverted dimmer";
    spinnerLabel.className = "ui text loader";
    spinnerLabel.innerText = "Loading";
    spinnerNode.appendChild(spinnerLabel);
    el.appendChild(spinnerNode);
}

function spinnerHide() {

}

ready(function() {
    spinnerShow();
    nativeBridge.fetchMountedVolumes({callback: render});
});