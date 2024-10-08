<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<jsp:include page="/layout/menu.jsp"></jsp:include>
	<title>view 기본 세팅 파일</title>
</head>
<style>
</style>
<body>
	<div id="app">
	 도/시
	 	<select v-model="si" @change="fnGetArea">
			<option value="">::선택::</option>
			<option v-for="item in siList" :value="item.si">{{item.si}}</option>
		</select>
	구/군
		<select v-model="gu" @change="fnGetArea">
			<option value="">::선택::</option>
			<option v-for="item in guList" :value="item.gu">{{item.gu}}</option>
		</select>
	동/면/리
		<select v-model="dong" @change="fnGetArea">
			<option value="">::선택::</option>
			<option v-for="item in dongList" :value="item.dong">{{item.dong}}</option>
		</select>
		
		<div>
			<input type="text" class="in" placeholder="주소" v-model="roadFullAddr"></input>
			<button @click="fnSearchAddr">주소 검색</button>
		</div>	
	</div>
</body>
</html>
<script>
	function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail, roadAddrPart2, engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn, detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo) {
		if (window.vueAppInstance) {
			window.vueAppInstance.fnResult(roadFullAddr, roadAddrPart1, addrDetail, roadAddrPart2, engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn, detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo);
		} else {
			console.error("Vue app instance is not available.");
		}
	}
    const app = Vue.createApp({
        data() {
            return {
				si:"",
				siList:[],
				gu:"",
				guList:[],
				dong:"",
				dongList:[],
				roadFullAddr:""
            };
        },
        methods: {
			fnGetArea(){
				var self=this;
				if(self.si==""){
					self.guList=[];
					self.dongList=[];
				}
				var nparmap ={
					si: self.si,
					gu: self.gu,
					dong: self.dong
				};
				$.ajax({
					url:"area.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data.list);
						if(self.si !=""){
							self.guList=data.list;
							self.dongList=data.list;
						}else{
							self.siList=data.list;
						}
						
					}
				});
			},
			fnSearchAddr(){
				var self = this;
				var option = "width = 500, height = 500, top = 100, left = 200, location = no"
				window.open("addr.do", "addr", option);
			},
			fnResult(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo){
				var self = this;
				self.roadFullAddr = roadFullAddr;
				// 콘솔 통해 각 변수 값 찍어보고 필요한거 가져다 쓰면 됩니다.
				console.log(roadFullAddr);
				console.log(roadAddrPart1);
				console.log(addrDetail);
				console.log(engAddr);
			}
        },
        mounted() {
			var self = this;
			this.fnGetArea();
			window.vueAppInstance = this;
        }
    });
    app.mount('#app');
</script>