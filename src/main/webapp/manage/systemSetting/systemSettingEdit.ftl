<#import "/manage/tpl/pageBase.ftl" as page>
<@page.pageBase currentMenu="系统设置">
<style type="text/css">
input,textarea{
	width: 80%;
}

.leftTd{
	text-align: right;width: 100px
}

.rightTd{
	text-align: left;
}
</style>
<script type="text/javascript">
$(function() {
	$( "#tabs" ).tabs({
		//event: "mouseover"
	});
	changeStyle();
});
function changeStyle(){
	var _png = "${basepath}/resource/bootstrap3.3.4/style/"+$("#style").val()+".png";
	$("#styleImg").attr("src",_png);
	$("#ceshiA").attr("href",$("#base_input").val()+$("#style").val());
}
</script>
</head>

<body style="padding: 5px;">
<form action="${basepath}/manage/systemSetting/" id="form">

<div style="text-align: center;border-bottom: 1px solid #ccc;padding: 5px;">
	<button method="insertOrUpdate" class="btn btn-success">
		<i class="icon-ok icon-white"></i> 保存
	</button>
</div>

<div id="tabs">
	<ul>
		<li><a href="#tabs-1">基本设置</a></li>
		<li><a href="#tabs-2">图片设置</a></li>
		<li><a href="#tabs-3">样式设置</a></li>
<!-- 		<li><a href="#tabs-4">邮件格式</a></li> -->
		<li><a href="#tabs-5">QQ店小二设置</a></li>
		<li><a href="#tabs-6">图集</a></li>
        <li><a href="#tabs-7">其他</a></li>
<!-- 		<li><a href="#tabs-7">信任登陆配置</a></li> -->
<!-- 		<li><a href="#tabs-8">门户数据配置</a></li> -->
	</ul>
	<div id="tabs-1">
		<table class="table table-condensed">
					<tr style="display: none;">
						<td>id</td>
						<td><input type="hidden" name="id" value="${e.id!""}" id="id"/></td>
					</tr>
					<tr>
						<td style="text-align: right;width: 100px">系统版本</td>
						<td style="text-align: left;"><input type="text" name="version" value="${e.version!""}" id="version" data-rule="required;version;length[0~100];"/>
							</td>
					</tr>
					<tr>
						<td style="text-align: right;width: 100px">系统代号</td>
						<td style="text-align: left;"><input type="text"  name="systemCode" value="${e.systemCode!""}"
								id="systemCode" data-rule="required;systemCode;length[1~30];"/></td>
					</tr>
					<tr>
						<td style="text-align: right;width: 100px">名称</td>
						<td style="text-align: left;"><input type="text"  name="name" value="${e.name!""}"
								id="name" data-rule="required;name;length[1~30];"/></td>
					</tr>
					<tr>
						<td style="text-align: right;">门户地址</td>   
						<td style="text-align: left;"><input type="text"  name="www" size="100" value="${e.www!""}"
								id="www" data-rule="required;www;length[1~100];"/></td>
					</tr>
					<tr>
						<td style="text-align: right;">后台地址</td>   
						<td style="text-align: left;"><input type="text"  name="manageHttp" size="100"  value="${e.manageHttp!""}"
								id="manageHttp" data-rule="required;manageHttp;length[1~100];"/></td>
					</tr>
					<tr>
						<td style="text-align: right;">log</td>
						<td style="text-align: left;"><input type="text"  name="log"  value="${e.log!""}"
								id="log" data-rule="required;log;length[0~100];"/></td>
					</tr>
					<tr>
						<td style="text-align: right;">网站标题</td>
						<td style="text-align: left;"><input type="text"  name="title"  value="${e.title!""}"
								id="title" data-rule="required;title;length[0~100];"/></td>
					</tr>
					<tr>
						<td style="text-align: right;">description</td>
						<td style="text-align: left;">
                            <input type="text"  id="description" name="description" value="${e.description!""}" data-rule="required;description;length[0~100];"/>
						</td>
					</tr>
					<tr>
						<td style="text-align: right;">keywords</td>
						<td style="text-align: left;">
							<input type="text"  id="keywords" name="keywords" value="${e.keywords!""}" data-rule="required;keywords;length[0~100];"/>
						</td>
					</tr>
					<tr>
						<td style="text-align: right;">shortcuticon</td>
						<td style="text-align: left;">
							<input type="text"  id="shortcuticon" name="shortcuticon" value="${e.shortcuticon!""}" data-rule="required;shortcuticon;length[0~100];"/>
						</td>
					</tr>
					<tr>
						<td style="text-align: right;">联系地址</td>
						<td style="text-align: left;">
							<input type="text"  id="address" name="address" value="${e.address!""}" data-rule="required;address;length[0~100];"/>
						</td>
					</tr>
					<tr>
						<td style="text-align: right;">联系电话</td>
						<td style="text-align: left;">
							<input type="text"  id="tel" name="tel"  value="${e.tel!""}"/>
						</td>
					</tr>
					<tr>
						<td style="text-align: right;">邮箱</td>
						<td style="text-align: left;">
							<input type="text"  id="email" name="email" value="${e.email!""}" data-rule="required;email;length[0~100];"/>
						</td>
					</tr>
					<tr>
						<td style="text-align: right;">备案号</td>
						<td style="text-align: left;">
							<input type="text"  id="icp" name="icp"  value="${e.icp!""}" data-rule="required;icp;length[0~100];"/>
						</td>
					</tr>
					<tr>
						<td style="text-align: right;">站长统计代码</td>
						<td style="text-align: left;">
							<textarea id="statisticsCode" cols="300" rows="6" name="statisticsCode" data-rule="required;statisticsCode;length[10~1000];">${e.statisticsCode!""}</textarea>
						</td>
					</tr>
					<tr>
						<td style="text-align: right;">是否开放网站</td>
						<td style="text-align: left;">
							<input type="checkbox" id="isopen" name="isopen" value="true" <#if e.isopen=="true">checked="checked"</#if> />
						</td>
					</tr>
					<tr>
						<td style="text-align: right;">关闭信息</td>
						<td style="text-align: left;">
							<textarea id="closeMsg" name="closeMsg" cols="300" rows="6">${e.closeMsg!""}</textarea>
						</td>
					</tr>
				</table>
	</div>
	<div id="tabs-2">
		<table class="table table-condensed">
			<tr>
				<td style="text-align: right;width: 100px">是否启用响应式</td>
				<td style="text-align: left;">
					<#assign y_n = {'y':'启用','n':'禁用'}>
					<select id="unit" name="openResponsive">
					<#list y_n?keys as key>
					    <option value="${key}" <#if e.openResponsive?? && e.openResponsive==key>selected="selected" </#if>>${y_n[key]}</option>
					</#list>
					</select>
				</td>
			</tr>
			<tr>
				<td style="text-align: right;width: 100px">图片根路径</td>
				<td style="text-align: left;"><input type="text"  name="imageRootPath"  value="${e.imageRootPath!""}"
						id="imageRootPath" data-rule="required;imageRootPath;length[0~100];"/></td>
			</tr>
			<tr>
				<td style="text-align: right;">产品默认图片</td>
				<td style="text-align: left;"><input type="text"  name="defaultProductImg"  value="${e.defaultProductImg!""}"
						id="defaultProductImg" data-rule="required;defaultProductImg;length[0~100];"/></td>
			</tr>
			<tr>
				<td style="text-align: right;width: 100px">后台左侧菜单叶子节点的图标</td>
				<td style="text-align: left;"><input type="text"  name="manageLeftTreeLeafIcon"  value="${e.manageLeftTreeLeafIcon!""}"
						id="manageLeftTreeLeafIcon" data-rule="required;manageLeftTreeLeafIcon;length[0~100];"/></td>
			</tr>
		</table>
	</div>
	<div id="tabs-3">
		<table class="table table-condensed">
			<tr>
				<td style="text-align: right;">选择样式</td>
				<td style="text-align: left;">

					<#assign styles = {'amelia':'amelia','cerulean':'cerulean','cosmo':'cosmo','cyborg':'cyborg','default':'default','flatly':'flatly','journal':'journal','readable':'readable','simplex':'simplex','slate':'slate','spacelab':'spacelab','united':'united','yeti':'yeti'}>
                    <select id="style" name="style" class="input-medium" onchange="changeStyle()" >
					<#list styles?keys as key>
                        <option value="${key}" <#if e.style?? && e.style==key>selected="selected" </#if>>${styles[key]}</option>
					</#list>
                    </select>
					<br>
					<a id="ceshiA" target="_blank">
						<img alt="" src="" id="styleImg" style="border: 1px solid #aaa;" >
					</a>
				</td>
			</tr>
		</table>
	</div>
	<div id="tabs-5">
		<table class="table table-bordered">
			<tr>
				<td style="text-align: left;" colspan="2">
					<div class="alert alert-info">
						请在下面填写站点客服的QQ组建HTML内容。可以从QQ的网站(http://connect.qq.com/intro/wpa)上取得HTML内容。号码和内容描述可以自己修改。
					</div>
					<textarea name="qqHelpHtml" style="width:100%;height:200px;visibility:hidden;">${e.qqHelpHtml!""}</textarea>
				</td>
			</tr>
		</table>
	</div>
	<div id="tabs-6">
		<div>
			<div class="alert alert-info">图集：如果广告位的属性设置为图集随机优先，则广告位的位置会优先选择显示图集中的图片。选择图片的方式为随机选取。</div>
			<table class="table table-bordered">
				<tr>
					<td colspan="11">
						<input style="display: none;" onclick="addTrFunc();" value="添加" class="btn btn-warning" type="button"/>
						<button method="deleteImageByImgPaths" onclick="return deleteImageByImgPaths(this);"
								class="btn btn-primary">删除</button>
							
					</td>
				</tr>
				<tr style="background-color: #dff0d8">
					<th width="50"><input type="checkbox" id="firstCheckbox" /></th>
					<th>图片地址</th>
				</tr>
				<#list e.imagesList as img>
					<tr>
						<td><input type="checkbox" name="imagePaths"
								value="${img}" /></td>
						<td>
							<a href="${systemSetting().imageRootPath}/${img}" target="_blank">
								<img style="max-width: 100px;max-height: 100px;" alt="" src="${systemSetting().imageRootPath}/${img}">
							</a>
						</td>
					</tr>
				</#list>
			</table>
		</div>
		<br>
		<table class="table table-bordered">
			<tr style="background-color: #dff0d8">
				<td>文件</td>
			</tr>
			<tr id="firstTr">
				<td>
					<#list [0..10] as item>
					<div>
						<input type="button" name="filemanager" value="浏览图片" class="btn btn-warning"/>
						<input type="text" ccc="imagesInput" name="images" style="width: 80%;" />
					</div>
					</#list>
				</td>
			</tr>
		</table>
	</div>
    <div id="tabs-7">
        <table class="table table-condensed">
            <tr>
                <td style="text-align: right;width: 140px">邮件发送账号</td>
                <td style="text-align: left;"><input type="text" name="emailAccount" value="${e.emailAccount!""}" id="emailAccount" data-rule="required;version;length[0~100];"/>
                </td>
            </tr>
            <tr>
                <td style="text-align: right;width: 100px">邮件发送密码</td>
                <td style="text-align: left;"><input type="text"  name="emailPassword" value="${e.emailPassword!""}"
                                                     id="emailPassword" data-rule="required;systemCode;length[1~30];"/></td>
            </tr>
            <tr>
                <td style="text-align: right;width: 100px">邮件发送服务</td>
                <td style="text-align: left;"><input type="text"  name="emailSmtpServer" value="${e.emailSmtpServer!""}" id="emailSmtpServer" data-rule="required;name;length[1~30];"/></td>
            </tr>
            <tr>
                <td style="text-align: right;width: 140px">电商代码</td>
                <td style="text-align: left;"><input type="text"  name="cbeCode" value="${e.cbeCode!""}" id="cbeCode" data-rule="name;length[1~40];"/></td>
                <td style="text-align: right;width: 140px">电商名称</td>
                <td style="text-align: left;"><input type="text"  name="cbeName" value="${e.cbeName!""}" id="cbeName" data-rule="name;length[1~100];"/></td>
			</tr>
            <tr>
                <td style="text-align: right;width: 140px">电商平台代码</td>
                <td style="text-align: left;"><input type="text"  name="ecpCode" value="${e.ecpCode!""}" id="ecpCode" data-rule="name;length[1~40];"/></td>
                <td style="text-align: right;width: 100px">电商平台名称</td>
                <td style="text-align: left;"><input type="text"  name="ecpName" value="${e.ecpName!""}" id="ecpName" data-rule="name;length[1~100];"/></td>
			</tr>
            <tr>
                <td style="text-align: right;width: 100px">进口行邮税</td>
                <td style="text-align: left;"><input type="text"  name="tax" value="${e.tax!""}" id="tax" data-rule="name;length[5~19];"/></td>
                <td style="text-align: right;width: 100px">发货人名称</td>
                <td style="text-align: left;"><input type="text"  name="shipper" value="${e.shipper!""}" id="shipper" data-rule="name;length[1~60];"/></td>
			</tr>
            <tr>
                <td style="text-align: right;width: 100px">发货人地址</td>
                <td style="text-align: left;"><input type="text"  name="shipperAddress" value="${e.shipperAddress!""}" id="shipperAddress" data-rule="name;length[1~100];"/></td>
                <td style="text-align: right;width: 100px">发货人电话</td>
                <td style="text-align: left;"><input type="text"  name="shipperTelephone" value="${e.shipperTelephone!""}" id="shipperTelephone" data-rule="name;length[1~20];"/></td>
			</tr>
            <tr>
                <td style="text-align: right;width: 100px">发货人所在国</td>
                <td style="text-align: left;">
					<#assign map ={'142':'中国','101':'阿富汗','102':'巴林', '103':'孟加拉国','104':'不丹','105':'文莱','106':'缅甸','107':'柬埔寨','108':'塞浦路斯','109':'朝鲜','110':'中国香港','111':'印度','112':'印度尼西亚','113':'伊朗','114':'伊拉克','115':'以色列','116':'日本','117':'约旦','118':'科威特','119':'老挝','120':'黎巴嫩','121':'中国澳门','122':'马来西亚','123':'马尔代夫','124':'蒙古','125':'尼泊尔','126':'阿曼','127':'巴基斯坦','128':'巴勒斯坦','129':'菲律宾','130':'卡塔尔','131':'沙特阿拉伯','132':'新加坡','133':'韩国','134':'斯里兰卡','135':'叙利亚','136':'泰国','137':'土耳其','138':'阿联酋','139':'也门共和国','141':'越南','143':'台澎金马关税区','144':'东帝汶','145':'哈萨克斯坦','146':'吉尔吉斯斯坦','147':'塔吉克斯坦','148':'土库曼斯坦','149':'乌兹别克斯坦','199':'亚洲其他国家(地区)','201':'阿尔及利亚','202':'安哥拉','203':'贝宁','204':'博茨瓦那','205':'布隆迪','206':'喀麦隆','207':'加那利群岛','208':'佛得角','209':'中非共和国','210':'塞卜泰','211':'乍得','212':'科摩罗','213':'刚果','214':'吉布提','215':'埃及','216':'赤道几内亚','217':'埃塞俄比亚','218':'加蓬','219':'冈比亚','220':'加纳','221':'几内亚','222':'几内亚(比绍)','223':'科特迪瓦','224':'肯尼亚','225':'利比里亚','226':'利比亚','227':'马达加斯加','228':'马拉维','229':'马里','230':'毛里塔尼亚','231':'毛里求斯','232':'摩洛哥','233':'莫桑比克','234':'纳米比亚','235':'尼日尔','236':'尼日利亚','237':'留尼汪','238':'卢旺达','239':'圣多美和普林西比','240':'塞内加尔','241':'塞舌尔','242':'塞拉利昂','243':'索马里','244':'南非','245':'西撒哈拉','246':'苏丹','247':'坦桑尼亚','248':'多哥','249':'突尼斯','250':'乌干达','251':'布基纳法索','252':'民主刚果','253':'赞比亚','254':'津巴布韦','255':'莱索托','256':'梅利利亚','257':'斯威士兰','258':'厄立特里亚','259':'马约特岛','299':'非洲其他国家(地区)','301':'比利时','302':'丹麦','303':'英国','304':'德国','305':'法国','306':'爱尔兰','307':'意大利','308':'卢森堡','309':'荷兰','310':'希腊','311':'葡萄牙','312':'西班牙','313':'阿尔巴尼亚','314':'安道尔','315':'奥地利','316':'保加利亚','318':'芬兰','320':'直布罗陀','321':'匈牙利','322':'冰岛','323':'列支敦士登','324':'马耳他','325':'摩纳哥','326':'挪威','327':'波兰','328':'罗马尼亚','329':'圣马力诺','330':'瑞典','331':'瑞士','334':'爱沙尼亚','335':'拉脱维亚','336':'立陶宛','337':'格鲁吉亚','338':'亚美尼亚','339':'阿塞拜疆','340':'白俄罗斯','343':'摩尔多瓦','344':'俄罗斯联邦','347':'乌克兰','349':'塞尔维亚和黑山','350':'斯洛文尼亚','351':'克罗地亚', '352':'捷克共和国','353':'斯洛伐克','354':'马其顿', '355':'波斯尼亚-黑塞哥维那共','356':'梵蒂冈城国','357':'法罗群岛','399':'欧洲其他国家(地区)','401':'安提瓜和巴布达','402':'阿根廷','403':'阿鲁巴岛', '404':'巴哈马','405':'巴巴多斯','406':'伯利兹','408':'玻利维亚','409':'博内尔', '410':'巴西','411':'开曼群岛','412':'智利','413':'哥伦比亚','414':'多米尼亚共和国','415':'哥斯达黎加', '416':'古巴','417':'库腊索岛','418':'多米尼加共和国','419':'厄瓜多尔','420':'法属圭亚那','421':'格林纳达','422':'瓜德罗普','423':'危地马拉','424':'圭亚那','425':'海地', '426':'洪都拉斯','427':'牙买加','428':'马提尼克','429':'墨西哥','430':'蒙特塞拉特','431':'尼加拉瓜','432':'巴拿马','433':'巴拉圭','434':'秘鲁','435':'波多黎各','436':'萨巴','437':'圣卢西亚','438':'圣马丁岛','439':'圣文森特和格林纳丁斯','440':'萨尔瓦多','441':'苏里南','442':'特立尼达和多巴哥','443':'特克斯和凯科斯群岛','444':'乌拉圭','445':'委内瑞拉','446':'英属维尔京群岛','447':'圣其茨-尼维斯','448':'圣皮埃尔和密克隆','449':'荷属安地列斯群岛','499':'拉丁美洲其他国家(地区)','501':'加拿大','502':'美国','503':'格陵兰','504':'百慕大','599':'北美洲其他国家(地区)','601':'澳大利亚','602':'库克群岛','603':'斐济','604':'盖比群岛','605':'马克萨斯群岛','606':'瑙鲁','607':'新喀里多尼亚','608':'瓦努阿图','609':'新西兰','610':'诺福克岛','611':'巴布亚新几内亚','612':'社会群岛','613':'所罗门群岛','614':'汤加','615':'土阿莫土群岛','616':'土布艾群岛','617':'萨摩亚','618':'基里巴斯','619':'图瓦卢','620':'密克罗尼西亚联邦','621':'马绍尔群岛','622':'帕劳共和国','623':'法属波利尼西亚','625':'瓦利斯和浮图纳','699':'大洋洲其他国家(地区)','701':'国(地)别不详的','702':'联合国及机构和国际组织','999':'中性包装原产国别'}>
                    <select id="shipperCountry" name="shipperCountry" class="input-medium">
						<#list map?keys as key>
                            <option value="${key}" <#if e.shipperCountry?? && e.shipperCountry==key>selected="selected" </#if>>${map[key]}</option>
						</#list>
                    </select>
				</td>
                <td style="text-align: right;width: 100px">进出口标志</td>
                <td style="text-align: left;">
					<#assign map ={'I':'进口','E':'出口'}>
                    <select id="ieType" name="ieType" class="input-medium">
						<#list map?keys as key>
                            <option value="${key}" <#if e.ieType?? && e.ieType==key>selected="selected" </#if>>${map[key]}</option>
						</#list>
                    </select>
                </td>
            </tr>
            <tr>
                <td style="text-align: right;width: 100px">批次号</td>
                <td style="text-align: left;"><input type="text"  name="batchNumbers" value="${e.batchNumbers!""}" id="batchNumbers" data-rule="name;length[1~100];"/></td>
                <td style="text-align: right;width: 100px">总运单号</td>
                <td style="text-align: left;"><input type="text"  name="totalLogisticsNo" value="${e.totalLogisticsNo!""}" id="totalLogisticsNo" data-rule="name;length[1~24];"/></td>
			</tr>
            <tr>
                <td style="text-align: right;width: 100px">贸易国别</td>
                <td style="text-align: left;">
					<#assign map ={'142':'中国','101':'阿富汗','102':'巴林', '103':'孟加拉国','104':'不丹','105':'文莱','106':'缅甸','107':'柬埔寨','108':'塞浦路斯','109':'朝鲜','110':'中国香港','111':'印度','112':'印度尼西亚','113':'伊朗','114':'伊拉克','115':'以色列','116':'日本','117':'约旦','118':'科威特','119':'老挝','120':'黎巴嫩','121':'中国澳门','122':'马来西亚','123':'马尔代夫','124':'蒙古','125':'尼泊尔','126':'阿曼','127':'巴基斯坦','128':'巴勒斯坦','129':'菲律宾','130':'卡塔尔','131':'沙特阿拉伯','132':'新加坡','133':'韩国','134':'斯里兰卡','135':'叙利亚','136':'泰国','137':'土耳其','138':'阿联酋','139':'也门共和国','141':'越南','143':'台澎金马关税区','144':'东帝汶','145':'哈萨克斯坦','146':'吉尔吉斯斯坦','147':'塔吉克斯坦','148':'土库曼斯坦','149':'乌兹别克斯坦','199':'亚洲其他国家(地区)','201':'阿尔及利亚','202':'安哥拉','203':'贝宁','204':'博茨瓦那','205':'布隆迪','206':'喀麦隆','207':'加那利群岛','208':'佛得角','209':'中非共和国','210':'塞卜泰','211':'乍得','212':'科摩罗','213':'刚果','214':'吉布提','215':'埃及','216':'赤道几内亚','217':'埃塞俄比亚','218':'加蓬','219':'冈比亚','220':'加纳','221':'几内亚','222':'几内亚(比绍)','223':'科特迪瓦','224':'肯尼亚','225':'利比里亚','226':'利比亚','227':'马达加斯加','228':'马拉维','229':'马里','230':'毛里塔尼亚','231':'毛里求斯','232':'摩洛哥','233':'莫桑比克','234':'纳米比亚','235':'尼日尔','236':'尼日利亚','237':'留尼汪','238':'卢旺达','239':'圣多美和普林西比','240':'塞内加尔','241':'塞舌尔','242':'塞拉利昂','243':'索马里','244':'南非','245':'西撒哈拉','246':'苏丹','247':'坦桑尼亚','248':'多哥','249':'突尼斯','250':'乌干达','251':'布基纳法索','252':'民主刚果','253':'赞比亚','254':'津巴布韦','255':'莱索托','256':'梅利利亚','257':'斯威士兰','258':'厄立特里亚','259':'马约特岛','299':'非洲其他国家(地区)','301':'比利时','302':'丹麦','303':'英国','304':'德国','305':'法国','306':'爱尔兰','307':'意大利','308':'卢森堡','309':'荷兰','310':'希腊','311':'葡萄牙','312':'西班牙','313':'阿尔巴尼亚','314':'安道尔','315':'奥地利','316':'保加利亚','318':'芬兰','320':'直布罗陀','321':'匈牙利','322':'冰岛','323':'列支敦士登','324':'马耳他','325':'摩纳哥','326':'挪威','327':'波兰','328':'罗马尼亚','329':'圣马力诺','330':'瑞典','331':'瑞士','334':'爱沙尼亚','335':'拉脱维亚','336':'立陶宛','337':'格鲁吉亚','338':'亚美尼亚','339':'阿塞拜疆','340':'白俄罗斯','343':'摩尔多瓦','344':'俄罗斯联邦','347':'乌克兰','349':'塞尔维亚和黑山','350':'斯洛文尼亚','351':'克罗地亚', '352':'捷克共和国','353':'斯洛伐克','354':'马其顿', '355':'波斯尼亚-黑塞哥维那共','356':'梵蒂冈城国','357':'法罗群岛','399':'欧洲其他国家(地区)','401':'安提瓜和巴布达','402':'阿根廷','403':'阿鲁巴岛', '404':'巴哈马','405':'巴巴多斯','406':'伯利兹','408':'玻利维亚','409':'博内尔', '410':'巴西','411':'开曼群岛','412':'智利','413':'哥伦比亚','414':'多米尼亚共和国','415':'哥斯达黎加', '416':'古巴','417':'库腊索岛','418':'多米尼加共和国','419':'厄瓜多尔','420':'法属圭亚那','421':'格林纳达','422':'瓜德罗普','423':'危地马拉','424':'圭亚那','425':'海地', '426':'洪都拉斯','427':'牙买加','428':'马提尼克','429':'墨西哥','430':'蒙特塞拉特','431':'尼加拉瓜','432':'巴拿马','433':'巴拉圭','434':'秘鲁','435':'波多黎各','436':'萨巴','437':'圣卢西亚','438':'圣马丁岛','439':'圣文森特和格林纳丁斯','440':'萨尔瓦多','441':'苏里南','442':'特立尼达和多巴哥','443':'特克斯和凯科斯群岛','444':'乌拉圭','445':'委内瑞拉','446':'英属维尔京群岛','447':'圣其茨-尼维斯','448':'圣皮埃尔和密克隆','449':'荷属安地列斯群岛','499':'拉丁美洲其他国家(地区)','501':'加拿大','502':'美国','503':'格陵兰','504':'百慕大','599':'北美洲其他国家(地区)','601':'澳大利亚','602':'库克群岛','603':'斐济','604':'盖比群岛','605':'马克萨斯群岛','606':'瑙鲁','607':'新喀里多尼亚','608':'瓦努阿图','609':'新西兰','610':'诺福克岛','611':'巴布亚新几内亚','612':'社会群岛','613':'所罗门群岛','614':'汤加','615':'土阿莫土群岛','616':'土布艾群岛','617':'萨摩亚','618':'基里巴斯','619':'图瓦卢','620':'密克罗尼西亚联邦','621':'马绍尔群岛','622':'帕劳共和国','623':'法属波利尼西亚','625':'瓦利斯和浮图纳','699':'大洋洲其他国家(地区)','701':'国(地)别不详的','702':'联合国及机构和国际组织','999':'中性包装原产国别'}>
                    <select id="tradeCountry" name="tradeCountry" class="input-medium">
						<#list map?keys as key>
                            <option value="${key}" <#if e.tradeCountry?? && e.tradeCountry==key>selected="selected" </#if>>${map[key]}</option>
						</#list>
                    </select>
                </td>
                <td style="text-align: right;width: 100px">代理企业</td>
                <td style="text-align: left;"><input type="text"  name="agentCode" value="${e.agentCode!""}" id="agentCode" data-rule="name;length[1~40];"/></td>
            </tr>
            <tr>
                <td style="text-align: right;width: 100px">代理企业名称</td>
                <td style="text-align: left;"><input type="text"  name="agentName" value="${e.agentName!""}" id="agentName" data-rule="name;length[1~100];"/></td>
                <td style="text-align: right;width: 100px">包装种类</td>
                <td style="text-align: left;"><input type="text"  name="wrapType" value="${e.wrapType!""}" id="wrapType" data-rule="name;length[1~30];"/></td>
            </tr>
            <tr>
                <td style="text-align: right;width: 100px">操作类型</td>
                <td style="text-align: left;">
					<#assign map ={'1':'新增','2':'修改','3':'删除'}>
                    <select id="modifyMark" name="modifyMark" class="input-medium">
						<#list map?keys as key>
                            <option value="${key}" <#if e.modifyMark?? && e.modifyMark==key>selected="selected" </#if>>${map[key]}</option>
						</#list>
                    </select>
				</td>
                <td style="text-align: right;width: 100px">行邮税号</td>
                <td style="text-align: left;"><input type="text"  name="taxCode" value="${e.taxCode!""}" id="taxCode" data-rule="name;length[1~8];"/></td>
            </tr>
            <tr>
                <td style="text-align: right;width: 100px">废旧物品</td>
                <td style="text-align: left;">
					<#assign map ={'1':'正常','2':'废品','5':'旧品','9':'其他'}>
                    <select id="wasteMaterials" name="wasteMaterials" class="input-medium">
						<#list map?keys as key>
                            <option value="${key}" <#if e.wasteMaterials?? && e.wasteMaterials==key>selected="selected" </#if>>${map[key]}</option>
						</#list>
                    </select>
                </td>
                <td style="text-align: right;width: 100px">支付企业代码</td>
                <td style="text-align: left;"><input type="text"  name="paymentCode" value="${e.paymentCode!""}" id="paymentCode" data-rule="name;length[1~10];"/></td>
            </tr>
            <tr>
                <td style="text-align: right;width: 100px">支付企业名称</td>
                <td style="text-align: left;"><input type="text"  name="paymentName" value="${e.paymentName!""}" id="paymentName" data-rule="name;length[1~100];"/></td>
                <td style="text-align: right;width: 100px">支付类型</td>
                <td style="text-align: left;">
					<#assign map ={'A':'全款','S':'商户款','X':'行邮税'}>
                    <select id="paymentType" name="paymentType" class="input-medium">
						<#list map?keys as key>
                            <option value="${key}" <#if e.paymentType?? && e.paymentType==key>selected="selected" </#if>>${map[key]}</option>
						</#list>
                    </select>
                </td>
            </tr>
            <tr>
                <td style="text-align: right;width: 100px">物流企业代码</td>
                <td style="text-align: left;"><input type="text"  name="logisticsCode" value="${e.logisticsCode!""}" id="logisticsCode" data-rule="name;length[1~10];"/></td>
                <td style="text-align: right;width: 100px">物流企业名称</td>
                <td style="text-align: left;"><input type="text"  name="logisticsName" value="${e.logisticsName!""}" id="logisticsName" data-rule="name;length[1~100];"/></td>
            </tr>
        </table>
    </div>
</div>
</form>
<input value="${basepath}/?style=" id="base_input" style="display: none;"/>
<script>
	var qqHelpHtml;
	KindEditor.ready(function(K) {
		qqHelpHtml = K.create('textarea[name="qqHelpHtml"]', {
			allowFileManager : true,
            uploadJson : '${basepath}/editor/upload',
            fileManagerJson : '${basepath}/editor/fileManager'
		});
		K('input[name=getHtml]').click(function(e) {
			alert(editor.html());
		});
		K('input[name=isEmpty]').click(function(e) {
			alert(editor.isEmpty());
		});
		K('input[name=getText]').click(function(e) {
			alert(editor.text());
		});
		K('input[name=selectedHtml]').click(function(e) {
			alert(editor.selectedHtml());
		});
		K('input[name=setHtml]').click(function(e) {
			editor.html('<h3>Hello KindEditor</h3>');
		});
		K('input[name=setText]').click(function(e) {
			editor.text('<h3>Hello KindEditor</h3>');
		});
		K('input[name=insertHtml]').click(function(e) {
			editor.insertHtml('<strong>插入HTML</strong>');
		});
		K('input[name=appendHtml]').click(function(e) {
			editor.appendHtml('<strong>添加HTML</strong>');
		});
		K('input[name=clear]').click(function(e) {
			editor.html('');
		});
	});
</script>

<script>
KindEditor.ready(function(K) {
	var editor = K.editor({
		fileManagerJson : '${basepath}/editor/fileManager'
	});
	K('input[name=filemanager]').click(function() {
		var imagesInputObj = $(this).parent().children("input[ccc=imagesInput]");
		editor.loadPlugin('filemanager', function() {
			editor.plugin.filemanagerDialog({
				viewType : 'VIEW',
				dirName : 'image',
				clickFn : function(url, title) {
					//K('#picture').val(url);
					//alert(url);
                    url = url.substring("/upload".length,url.length);
					imagesInputObj.val(url);
					editor.hideDialog();
					clearRootImagePath(imagesInputObj);//$("#picture"));
				}
			});
		});
	});
	
});

function deleteImageByImgPaths(obj){
	if ($("input:checked").size() == 0) {
		alert("请选择要删除的图片！");
		return false;
	}
	if(confirm("确定删除选择的图片吗?")){
		return true;
	}
	return false;
	
}
</script>

</@page.pageBase>