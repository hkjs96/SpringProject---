<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h3>수납전체통계 인데 pdf 연습화면됨</h3>
<script src="//mozilla.github.io/pdf.js/build/pdf.js"></script>
<style type="text/css">
#the-canvas {
  border: 1px solid black;
  direction: ltr;
}
</style>
</head>
<body>

<h1>PDF.js 'Hello, world!' example</h1>
<input type="text" id="pdfPath" placeholder="PDF 경로"/>
<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#sampleModal">
  PDF Sample
</button>
<div class="modal fade" id="sampleModal" tabindex="-1" aria-labelledby="sampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-fullscreen" data-bs-backdrop="static" >
	  <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title h4" id="sampleModalLabel">상품 상세 조회</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	      	<canvas id="the-canvas"></canvas>
	      </div>
	      <div class="modal-footer">
			<input type="button" value="수정" class="btn btn-primary mr-3" id="modifyBtn" />
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
	      </div>
	    </div>
	</div>
</div>
<script type="text/javascript">
	$("#sampleModal").on("shown.bs.modal", function(){
		var url = $("#pdfPath").val();
		var pdfjsLib = window['pdfjs-dist/build/pdf'];
		pdfjsLib.GlobalWorkerOptions.workerSrc = '//mozilla.github.io/pdf.js/build/pdf.worker.js';
		var loadingTask = pdfjsLib.getDocument(url);
		
		loadingTask.promise.then(function(pdf) {
			console.log('PDF loaded');

			// Fetch the first page
			var pageNumber = 1;
			pdf.getPage(pageNumber).then(
					function(page) {
						console.log('Page loaded');

						var scale = 1.5;
						var viewport = page.getViewport({
							scale : scale
						});

						// Prepare canvas using PDF page dimensions
						var canvas = document
								.getElementById('the-canvas');
						var context = canvas.getContext('2d');
						canvas.height = viewport.height;
						canvas.width = viewport.width;

						// Render PDF page into canvas context
						var renderContext = {
							canvasContext : context,
							viewport : viewport
						};
						var renderTask = page
								.render(renderContext);
						renderTask.promise.then(function() {
							console.log('Page rendered');
						});
					});
		}, function(reason) {
			// PDF loading error
			console.error(reason);
		});
	});
</script>