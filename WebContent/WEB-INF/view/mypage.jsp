<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>iPastel :: MyPage</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<style type="text/css">
		@font-face {
			font-family: "NanumGothicCoding";
			src: url("./font/NanumGothicCoding.ttf");
		}
		
		* {
			font-family: "NanumGothicCoding";
		}
		
		.font-white-package {
			font-family: "NanumGothicCoding";
			color: #eee;
		}
		.font-black-package {
			font-family: "NanumGothicCoding";
			color: #24292e;
		}
		
		.button-none-hover:hover {
			background-color: #24292e;
			color: #eee;	
		}
		
		a:link {
			color: #eee;
			text-decoration: none;
		}
		a:hover {
			color: #eee;
			text-decoration: none;
		}
		a:visited {
			color: #eee;
			text-decoration: none;
		}
		a:active {
			color: #eee;
			text-decoration: none;
		}
		
		.container_bar {
			position: fixed;
			z-index: 1;
			width: 100%;
			transition: top 1s;
			background-color: #24292e;
		}
		.dropdownHover:hover {
			background-color: gray;
		}
		.dropdownHover:active {
			background-color: #24292e;
		}
		
		.form-input {
			color: blue;
		}
		.form-input:link {
			color: blue;
			text-decoration: underline;
		} 
		.form-input:hover {
			color: blue;
			text-decoration: underline;
		}
		.form-input:visited {
			color: blue;
			text-decoration: underline;
		}
		.form-input:active {
			color: blue;
			text-decoration: underline;
		}
	</style>
	<script type="text/javascript">
		$().ready(function() {
			var prevScrollpos = window.pageYOffset;
			window.onscroll = function() {
			var currentScrollPos = window.pageYOffset;
			  if (prevScrollpos > currentScrollPos) {
			    document.getElementById("top_bar").style.top = "0";
			  } else {
			    document.getElementById("top_bar").style.top = "-50px";
			  }
			  prevScrollpos = currentScrollPos;
			}
			
			
			$("#btn_modifiy").click(function() {
				var disabled = $("#mypage_pw").attr("disabled");
				
				if(disabled === "disabled") {
					var html = "";
					html += '<td>';
					html += '<div class="input-group mb-3">';
					html += '<div class="input-group-prepend">';
					html += '<span class="input-group-text">c&nbsp;h&nbsp;k</span>';
					html += '</div>';
					html += '<input type="password" class="form-control" id="mypage_confirm" name="mypage_confirm">';
					html += '</div>';
					html += '</td>';
					html += '<td>';
					html += '<p id="btn_modifiy_submit" onclick="confirmModify();" class="form-input">Modify</p>';
					html += '</td>';
					
					$("#confirm_modify").html(html);
					$("#mypage_pw").attr("disabled", false);
					$("#btn_modifiy").html("Cancel");
					$("#mypage_confirm").val($("#mypage_pw").val());
				} else if(disabled === undefined) {
					$("#mypage_pw").attr("disabled", true);
					$("#confirm_modify").html("");
					$("#btn_modifiy").html("Modify");
					$("#alert_danger").hide();
				}
			});
			$("#btn_DeleteAccount").click(function(e) {
				e.preventDefault();
				$("#modalDeleteAccount").modal("show");
			});
		});
		function confirmModify() {
			var pw1 = $("#mypage_pw").val();
			var pw2 = $("#mypage_confirm").val();
			if(pw1 === pw2) {
				// member 테이블 내의 pw 값 업데이트
				var id = encodeURIComponent(document.getElementById("mypage_id").value);
				var pw = encodeURIComponent(document.getElementById("mypage_pw").value);
				$.ajax({
					url:'pwUpdate.on',
					type:'post',
					data: {"id":id,"pw":pw},
					async:true,
					success:function(chk) {
						// ajax 전송 및 반환 성공 후 실행할 함수
						if("true" === chk) {
							$("#mypage_pw").attr("disabled", true);
							$("#confirm_modify").html("");
							$("#btn_modifiy").html("Modify");
							$("#alert_danger").hide();
							$('#alert_success').show();
						}
					},
					error:function() {
						alert("페이지 오류 발생, 페이지를 다시 불러와주시길 바랍니다.");
					}
				});
			} else {
				$('#alert_success').hide();
				$('#alert_danger').show();
			}
		}
		function imageAdd() {
			$("#form_mypage").submit();
		}
		function imageRemove() {
			var id = encodeURIComponent(document.getElementById("mypage_id").value);
			$.ajax({
				url:'profileImgRemove.on',
				type:'post',
				data: {"id":id},
				async:true,
				success:function(chk) {
					// ajax 전송 및 반환 성공 후 실행할 함수
					if("true" === chk) {
						console.log("이미지 삭제");
					}
				},
				error:function() {
					alert("페이지 오류 발생, 페이지를 다시 불러와주시길 바랍니다.");
				}
			});
		}
		function alertClose(id) {
			$("#" + id).hide();
		}
	</script>
</head>
<body>
	<div class="container-fluid p-0">
		<!-- top_bar -->
		<div id="top_bar" class="container_bar container-fulid d-flex flex-row-reverse p-1">
			<c:choose>
				<c:when test="${state eq 'login'}">
					<div class="px-5">
						<c:choose>
							<c:when test="${empty dto_mypage.profile_img}">
								<img src="img/userProfile.png" class="rounded-circle" width="40" height="40">
							</c:when>
							<c:otherwise>
								<img src="img/userProfile/${dto_mypage.profile_img}" class="rounded-circle" width="40" height="40">
							</c:otherwise>
						</c:choose>
	            		<p class="font-white-package d-inline px-3">${session_name}님 환영합니다.</p>
						<a class="dropdown-toggle" data-toggle="dropdown"></a>
						<div class="dropdown-menu" id="dropdown">
							<input class="btn btn-light btn-sm dropdown-item" type="button" value="마이페이지" onclick="location.href='mypage.do'">
							<input class="btn btn-light btn-sm dropdown-item" type="button" value="로그아웃" onclick="location.href='logout.do'">
						</div>
            		</div>
				</c:when>
				<c:otherwise>
					<c:if test="${faildLogin eq 'fail'}">
 						존재하지 않거나 잘못된 아이디 또는 비밀번호를 입력하셨습니다.
  					</c:if>
					<form id="form_login" action="login.do" method="post" class="font-white-package">
						<label for="login_id" class="form-control-text">id&nbsp;</label><input type="text" id="login_id" name="login_id" class="btn btn-outline-light btn-sm button-none-hover" style="width:150px;">&nbsp;&nbsp;
						<label for="login_pw"class="form-control-text">pw&nbsp;</label><input type="password" id="login_pw" name="login_pw" class="btn btn-outline-light btn-sm button-none-hover" style="width:150px;">
						<input type="button" id="btn_signin" value="SignIn" class="btn btn-light btn-sm">
						<input type="button" onclick="location.href='signup.do'" value="SignUp" class="btn btn-light btn-sm">
					</form>
				</c:otherwise>
			</c:choose>
		</div>
	
	
	
		<!-- banner -->
		<div class="container-fluid p-0 pb-5">
			<a href="index.do"><img src="img/banner.png" class="img-fluid"></a>
		</div>
		
		
		<!-- form -->
		<div class="container">
			<br>
			<div class="d-flex justify-content-center p-5">
				<form id="form_mypage" action="imgUpload.do" method="post" enctype="multipart/form-data">
					<table>
						<tr>
							<td>
								<!-- Alert -->
								<!-- Not Incorrect Password -->
								<div id="alert_danger" class="alert alert-danger" style="display:none;">
									<a href="#" class="close" aria-label="close" onclick="alertClose('alert_danger');">×</a>
									<strong>Error!</strong> Not Incorrect Password!
								</div>
								<!-- Changed Password -->
								<div id="alert_success" class="alert alert-success" style="display:none;">
									<a href="#" class="close" aria-label="close" onclick="alertClose('alert_success');">×</a>
									<strong>Success!</strong> Modified Password!
								</div>
							</td>
						</tr>
						<tr>
							<c:choose>
								<c:when test="${empty dto_mypage.profile_img}">
									<!-- if -->
									<td>
										<div class="input-group mb-3">
											<div class="input-group-prepend">
												<span class="input-group-text">Profile</span>
											</div>
											<span class="input-group-text p-3">
												<img src="img/userProfile.png" class="rounded">
											</span>
										</div>
									</td>
									<td>
										<a id="btn_imgUpload" href="" class="form-input"><label for="mypage_file">Upload</label></a>
										<input type="file" id="mypage_file" name="mypage_file" accept="image/gif, image/jpg, image/jpeg, image/png" style="display:none;" onchange="imageAdd();">
									</td>
								</c:when>
								<c:otherwise>
									<!-- else -->
									<td>
										<div class="input-group mb-3">
											<div class="input-group-prepend">
												<span class="input-group-text">Profile</span>
											</div>
											<span class="input-group-text p-3">
												<img src="img/userProfile/${dto_mypage.profile_img}" class="rounded">
											</span>
										</div>
									</td>
									<td>
										<a onclick="imageRemove();" href="" class="form-input">Remove</a>
									</td>
								</c:otherwise>
							</c:choose>
							
						</tr>
						<tr>
							<td>
								<div class="input-group mb-3">
									<div class="input-group-prepend">
										<span class="input-group-text">name</span>
									</div>
									<input type="text" class="form-control" id="mypage_name" name="mypage_name" value="${dto_mypage.name}" disabled>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div class="input-group mb-3">
									<div class="input-group-prepend">
										<span class="input-group-text">&nbsp;i&nbsp;&nbsp;d&nbsp;</span>
									</div>
									<input type="text" class="form-control" id="mypage_id" name="mypage_id" value="${dto_mypage.id}" disabled>
								</div>
							</td>
						</tr>
						
						<tr>
							<td>
								<div class="input-group mb-3">
									<div class="input-group-prepend">
										<span class="input-group-text">&nbsp;p&nbsp;&nbsp;w</span>
									</div>
									<input type="password" class="form-control" id="mypage_pw" name="mypage_pw" value="${dto_mypage.pw}" disabled>
								</div>
							</td>
							
							<td>
								<p id="btn_modifiy" class="form-input">Modify</p>
							</td>
						</tr>
						
						<tr id="confirm_modify"></tr>
						
						<tr>
							<td>
								<button id="btn_DeleteAccount" class="form-control btn btn-light font-black-package">Delete Account</button>
								
								<!-- 회원가입 확인 Modal-->
								<div class="modal fade" id="modalDeleteAccount" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
									<div class="modal-dialog" role="document">
										<div class="modal-content">
											<div class="modal-header">
												<h5 class="modal-title" id="exampleModalLabel">Delete Account</h5>
												<button class="close" type="button" data-dismiss="modal" aria-label="Close">
												<span aria-hidden="true">X</span>
												</button>
											</div>
											
											<div class="modal-body">정말 계정을 삭제하시겠습니까?</div>
											<div class="modal-footer">
												<a class="btn" id="modalY" href="#">예</a>
												<button class="btn" type="button" data-dismiss="modal">아니요</button>
											</div>
										</div>
									</div>
								</div>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<br>
		</div>
		
		
		<!-- footer -->
		<div id="footer" class="text-center text-white second mt-2 pt-5" style="background-color: #223547;">
			<br>
			<a href="">회사소개</a> | <a href="">인재채용</a> | <a href="">이용약관</a> | <a href="">개인정보처리방침</a> | <a href="">청소년보호정책</a> | <a href="">고객센터</a>&nbsp;&copy;58￥ corp.
			<br><br><br>
		</div>
	</div>
</body>
</html>