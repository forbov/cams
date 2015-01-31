var W3CDOM = (document.createElement && document.getElementsByTagName);

function initFileUploads() {
	if (!W3CDOM) return;
	var fakeFileUpload = document.createElement('div');
	fakeFileUpload.className = 'fakefile';
	var inputContainer = document.createElement('div');
	inputContainer.className = 'small-9 columns';
	var fakeInput = document.createElement('input');
	fakeInput.type = 'text';
	inputContainer.appendChild(fakeInput);
	fakeFileUpload.appendChild(inputContainer);
	var image = document.createElement('i');
	image.className ='fi-camera medium';
	var imageContainer = document.createElement('div');
	imageContainer.className = 'small-3 columns';
	imageContainer.appendChild(image);
	fakeFileUpload.appendChild(imageContainer);
	var x = document.getElementsByTagName('input');
	for (var i=0;i<x.length;i++) {
		if (x[i].type != 'file') continue;
		if (x[i].parentNode.className != 'fileinputs') continue;
		x[i].className = 'file hidden';
		var clone = fakeFileUpload.cloneNode(true);
		x[i].parentNode.appendChild(clone);
		x[i].relatedElement = clone.getElementsByTagName('input')[0];
		x[i].onchange = x[i].onmouseout = function () {
						this.relatedElement.value = this.value;
		};
	}
}