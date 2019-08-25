c<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp"%>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Modify</h1>
	</div>
</div>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Board Modify Page</div>
			<div class="panel-body">
				<form role="form" action="/board/modify" method="post">
				<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}"/>'>
				<input type="hidden" name="amount" value='<c:out value="${cri.amount}"/>'>
				<input type="hidden" name="type" value='<c:out value="${cri.type}"/>'>
				<input type="hidden" name="keyword" value='<c:out value="${cri.keyword}"/>'>
				<div class="form-group">
					<label>Bno</label><input class="form-control" name="bno"
						value='<c:out value="${board.bno}"/>'>
				</div>
				<div class="form-group">
					<label>Title</label><input class="form-control" name="title"
						value='<c:out value="${board.title}"/>' >
				</div>
				<div class="form-group">
					<label>Text area</label>
					<textarea class="form-control" rows="3" name="content"><c:out value="${board.content}" /></textarea>
				</div>
				<div class="form-group">
					<label>Writer</label><input class="form-control" name="writer"
						value='<c:out value="${board.writer}"/>' readonly="readonly">
				</div>
				<div class="form-group">
					<label>RegDate</label><input class="form-control" name="regDate"
						value='<fmt:formatDate pattern = "yyyy/MM/dd" value="${board.regdate}"/>' readonly="readonly">
				</div>
				
				<div class="form-group">
					<label>Update</label><input class="form-control" name="updateDate"
						value='<fmt:formatDate pattern = "yyyy/MM/dd" value="${board.updatedate}"/>' readonly="readonly">
				</div>
				
				<button type="submit" data-oper='modify' class="btn btn-default">Modify</button>
				<button type="submit" data-oper='remove' class="btn btn-danger">Remove</button>
				<button type="submit" data-oper='list' class="btn btn-info">List</button>
				</form>
			</div>
		</div>
	</div>
</div>
<div class="bigPictureWrapper">
	<div class="bigPicture">
	</div>
</div>
<style>
.uploadResult{
	width: 100%;
	background-color: gray;
}
.uploadResult ul{
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
	text-align: center;
}
.uploadResult ul li{
	list-style: none;
	padding: 10px;
	align-content: center;
	text-align: center;
}
.uploadResult ul li img{
	width: 100px;
}
.uploadResult ul li span{
	color: white;
}
.bigPictureWrapper{
	position: absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100;
	background: rgba(255,255,255,0.5);
}
.bigPicture {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}
.bigPicture img{
	width: 600px
}
</style>
<div class = "row">
	<div class = "col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
			Files
			</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<div class='uploadResult'>
					<ul>
					</ul>
				</div>
			</div>
			<!-- end panel-body -->
		</div>
		<!-- end panel-body -->
	</div>
	<!-- end panel -->
</div>
<!-- /.row -->
<%@include file="../includes/footer.jsp"%>
<script type="text/javascript">
$(document).ready(function(){
	(function() {
		var bno = '<c:out value="${board.bno}"/>';
		$.getJSON("/board/getAttachList", {bno: bno}, function(arr) {
			console.log(arr);
			var str = "";
			$(arr).each(function(i, attach) {
				// image type
				if(attach.fileType){
					var fileCallPath = encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName);
					str += "<li data-path='" + attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='" + attach.fileName+"' data-type='"+ attach.fileType+"'><div>";
					str += "<img src='/display?fileName="+fileCallPath+"'>";
					str += "</div>";
					str += "</li>";
				} else {
					str += "<li data-path='" + attach.uploadPath+"' data-uuid='" + attach.uuid+"' data-filename='"+ attach.fileName+"' data-type='" + attach.fileType+"'><div>";
					str += "<span> " + attach.fileName+"</span><br>";
					str += "<img src='/resources/img/attach.png'></a>";
					str += "</div>";
					str += "</li>";
				}
			});
			$(".uploadResult ul").html(str);
		});//end getJSON
	})();//end function
	var formObj = $("form");
	$('button').on("click", function (e) {
		e.preventDefault();
		var operation = $(this).data("oper");
		console.log(operation);
		if (operation === 'remove') {
			formObj.attr("action", "/board/remove");
		}else if (operation === 'list') {
			// move to list
			formObj.attr("action", "/board/list").attr("method", "get");
			var pageNumTag = $("input[name='pageNum']").clone();
			var amountTag = $("input[name='amount']").clone();
			var keywordTag = $("input[name='keyword']").clone();
			var typeTag = $("input[name='type']").clone();
			formObj.empty();
			formObj.append(pageNumTag);
			formObj.append(amountTag);
			formObj.append(keywordTag);
			formObj.append(typeTag);
		}
		formObj.submit();
	});
})

</script>
