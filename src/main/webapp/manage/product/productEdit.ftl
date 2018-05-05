<#import "/manage/tpl/pageBase.ftl" as page>
<@page.pageBase currentMenu="商品管理">
<form action="${basepath}/manage/product" id="form" name="form" namespace="/manage" theme="simple" enctype="multipart/form-data" method="post">

	<span id="pifeSpan" class="input-group-addon" style="display:none">${systemSetting().imageRootPath}</span>
	<input type="hidden" value="${e.id!""}" id="productID"/>
	<input type="hidden" value="${e.catalogID!""}" id="catalogID"/>

		<div style="text-align: center;">
			<div id="updateMsg"><font color='red'>${updateMsg!""}</font></div>
			<#if e.id??>
                商品ID：<span class="badge badge-success">${e.id!""}</span>
                <#if e.activityID??>
                    活动ID：<span class="badge badge-success">${e.activityID!""}</span>
                </#if>
                <button method="update" class="btn btn-success">
                    <i class="icon-ok icon-white"></i> 保存
                </button>

                <#if e.status??&&e.status!=2>
                    <button method="updateUpProduct?id=${e.id!""}" class="btn btn-warning" onclick="return confirm('确定上架商品吗?');">
                    <i class="icon-arrow-up icon-white"></i> 上架
                    </button>
                <#else>
                    <button method="updateDownProduct?id=${e.id!""}" class="btn btn-warning" onclick="return confirm('确定下架商品吗?');">
                    <i class="icon-arrow-down icon-white"></i> 下架
                    </button>
                </#if>

                <a class="btn btn-info" target="_blank" href="${systemSetting().www}/product/${e.id!""}.html">
                    <i class="icon-eye-open icon-white"></i> 查看</a>
                <#--<a target="_blank" href="${basepath}/freemarker/create?method=staticProductByID&id=${e.id!""}" class="btn btn-warning">-->
                    <#--<i class="icon-refresh icon-white"></i> 静态化</a>-->
            <#else>
                <button method="insert" class="btn btn-success">
                    <i class="icon-ok icon-white"></i> 新增
                </button>
			</#if>
			
<!-- 			<a href="selectList?init=y" class="btn btn-inverse">返回</a> -->
		</div>
		
		<div id="tabs">
			<ul>
				<li><a href="#tabs-1">基本信息</a></li>
				<li><a href="#tabs-2">商品介绍</a></li>
				<li><a href="#tabs-3">商品图片</a></li>
				<li><a href="#tabs-4">商品属性</a></li>
				<li><a href="#tabs-5">商品参数</a></li>
				<li><a href="#tabs-6">商品规格</a></li>
				<li><a href="#tabs-7">绑定商品赠品</a></li>
			</ul>
			<div id="tabs-1">
                <input type="hidden" value="${e.id!""}" name="id" label="id" id="id"/>
				<div class="row form-horizontal"-role="form">

                    <div class="form-group">
                        <label class="col-md-2 control-label">名称</label>
                        <div class="col-md-10">
                            <input type="text" value="${e.name!""}" name="name"  data-rule="商品名称;required;name;length[0~44];" size="44" maxlength="44" style="width: 80%;"
                                   id="name" />
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label class="col-md-4 control-label">商品货号</label>
                        <div class="col-md-8"><input type="text"  value="${e.goodsNo!""}" name="goodsNo" size="20" maxlength="20"
                                                     id="goodsNo" />
                        </div>
                    </div>

                    <div class="form-group col-md-6">
                        <label class="col-md-4 control-label">HS编码</label>
                        <div class="col-md-8"><input type="text"  value="${e.codeTs!""}" name="codeTs"  size="14" maxlength="14"
                                                     id="codeTs" />
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label class="col-md-4 control-label">类别</label>
						<div class="col-md-8">
                            <select onchange="catalogChange(this)" name="catalogID" id="catalogSelect">
                                <option></option>
								<#list catalogs as item>
                                    <option pid="0" value="${item.id!""}"><font color='red'>${item.name!""}</font></option>
									<#if item.children??>
										<#list item.children as item>
                                            <option value="${item.id!""}">&nbsp;&nbsp;&nbsp;&nbsp;${item.name!""}</option>
										</#list>
									</#if>
								</#list>
                            </select>(请选择子类别)
                        </div>
						</div>

                    <div class="form-group col-md-6">
                        <label class="col-md-4 control-label">单位</label>
                        <div class="col-md-8">
							<#assign map = {'011':'件','001':'台','002':'座','003':'辆','004':'艘','005':'架','006':'套','007':'个','008':'只','009':'头','010':'张','012':'支','013':'枝','014':'根','015':'条','016':'把','017':'块','018':'卷','019':'副','020':'片','021':'组','022':'份','023':'幅','025':'双','026':'对','027':'棵','028':'株','029':'井','030':'米','031':'盘','032':'平方米','033':'立方米','034':'筒','035':'千克','036':'克','037':'盆','038':'万个','039':'具','040':'百副','041':'百支','042':'百把','043':'百个','044':'百片','045':'刀','046':'疋','047':'公担','048':'扇','049':'百枝','050':'千只','051':'千块','052':'千盒','053':'千枝','054':'千个','055':'亿支','056':'亿个','057':'万套','058':'千张','059':'万张','060':'千伏安','061':'千瓦','062':'千瓦时','063':'千升','067':'英尺','070':'吨','071':'长吨','072':'短吨','073':'司马担','074':'司马斤','075':'斤','076':'磅','077':'担','078':'英担','079':'短担','080':'两','081':'市担','083':'盎司','084':'克拉','085':'市尺','086':'码','088':'英寸','089':'寸','095':'升','096':'毫升','097':'英加仑','098':'美加仑','099':'立方英尺','101':'立方尺','110':'平方码','111':'平方英尺','112':'平方尺','115':'英制马力','116':'公制马力','118':'令','120':'箱','121':'批','122':'罐','123':'桶','124':'扎','125':'包','126':'箩','127':'打','128':'筐','129':'罗','130':'匹','131':'册','132':'本','133':'发','134':'枚','135':'捆','136':'袋','139':'粒','140':'盒','141':'合','142':'瓶','143':'千支','144':'万双','145':'万粒','146':'千粒','147':'千米','148':'千英尺','149':'百万贝可','163':'部'}>
                            <select id="unit" name="unit" class="input-medium">
								<#list map?keys as key>
                                    <option value="${key}" <#if e.unit?? && e.unit==key>selected="selected" </#if>>${map[key]}</option>
								</#list>
                            </select>
							</div>
						</div>

                    <div class="form-group">
                        <label class="col-md-2 control-label">简介</label>
                        <div class="col-md-10">
							<textarea name="introduce" class="form-control" rows="3" id="introduce"
									  data-rule="商品简介;required;introduce;length[4~500];">${e.introduce!""}</textarea>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-md-2 control-label">主图</label>
                        <div class="col-md-10">
                            <input type="button" name="filemanager" value="浏览图片" class="btn btn-success"/>
                            <input type="text"  value="${e.picture!""}" name="picture" type="text" id="picture"  ccc="imagesInput" style="width: 600px;"
                                   data-rule="小图;required;maxPicture;"/>
							<#if e.picture??>
                                <a target="_blank" href="${systemSetting().imageRootPath}${e.picture!""}">
                                    <img style="max-width: 50px;max-height: 50px;" alt="" src="${systemSetting().imageRootPath}${e.picture!""}">
                                </a>
							</#if>
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label class="col-md-4 control-label">定价</label>
                        <div class="col-md-8"><input type="text"  value="${e.price!""}" name="price"  data-rule="定价;required;price;" size="10" maxlength="10"
                                                     id="price" />
                        </div>
                    </div>

                    <div class="form-group col-md-6">
                        <label class="col-md-4 control-label">现价</label>
                        <div class="col-md-8"><input type="text"  value="${e.nowPrice!""}" name="nowPrice"  data-rule="现价;required;nowPrice;" size="10" maxlength="10"
                                                     id="nowPrice" />
                        </div>
                    </div>

                    <div class="form-group col-md-6">
                        <label class="col-md-4 control-label">库存</label>
                        <div class="col-md-8"><input type="text"  value="${e.stock!""}" name="stock"  data-rule="库存;required;integer;stock;"
                                                     id="stock" />
                        </div>
                    </div>

                    <div class="form-group col-md-6">
                        <label class="col-md-4 control-label">销量</label>
                        <div class="col-md-8"><input type="text"  value="${e.sellcount!""}" name="sellcount"  data-rule="销量;required;integer;sellcount;"
                                                     id="sellcount" />
                        </div>
                    </div>

                    <div class="form-group col-md-6">
                        <label class="col-md-4 control-label">币制</label>
                        <div class="col-md-8">
							<#assign map = {'142':'人民币','110':'港币','116':'日本元','121':'澳门元','129':'菲律宾比索','132':'新加坡元','133':'韩国圆','136':'泰国铢','300':'欧元','302':'丹麦克朗','303':'英镑','304':'德国马克','305':'法国法郎','307':'意大利里拉','312':'西班牙比赛塔','315':'奥地利先令','318':'芬兰马克','326':'挪威克朗','330':'瑞典克朗','331':'瑞士法郎','501':'加拿大元','502':'美元','601':'澳大利亚元','609':'新西兰元'}>
                            <select id="currency" name="currency" class="input-medium">
								<#list map?keys as key>
                                    <option value="${key}" <#if e.unit?? && e.unit==key>selected="selected" </#if>>${map[key]}</option>
								</#list>
                            </select>
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label class="col-md-4 control-label">国家代码</label>
                        <div class="col-md-8">
							<#assign map ={'142':'中国','101':'阿富汗','102':'巴林', '103':'孟加拉国','104':'不丹','105':'文莱','106':'缅甸','107':'柬埔寨','108':'塞浦路斯','109':'朝鲜','110':'中国香港','111':'印度','112':'印度尼西亚','113':'伊朗','114':'伊拉克','115':'以色列','116':'日本','117':'约旦','118':'科威特','119':'老挝','120':'黎巴嫩','121':'中国澳门','122':'马来西亚','123':'马尔代夫','124':'蒙古','125':'尼泊尔','126':'阿曼','127':'巴基斯坦','128':'巴勒斯坦','129':'菲律宾','130':'卡塔尔','131':'沙特阿拉伯','132':'新加坡','133':'韩国','134':'斯里兰卡','135':'叙利亚','136':'泰国','137':'土耳其','138':'阿联酋','139':'也门共和国','141':'越南','143':'台澎金马关税区','144':'东帝汶','145':'哈萨克斯坦','146':'吉尔吉斯斯坦','147':'塔吉克斯坦','148':'土库曼斯坦','149':'乌兹别克斯坦','199':'亚洲其他国家(地区)','201':'阿尔及利亚','202':'安哥拉','203':'贝宁','204':'博茨瓦那','205':'布隆迪','206':'喀麦隆','207':'加那利群岛','208':'佛得角','209':'中非共和国','210':'塞卜泰','211':'乍得','212':'科摩罗','213':'刚果','214':'吉布提','215':'埃及','216':'赤道几内亚','217':'埃塞俄比亚','218':'加蓬','219':'冈比亚','220':'加纳','221':'几内亚','222':'几内亚(比绍)','223':'科特迪瓦','224':'肯尼亚','225':'利比里亚','226':'利比亚','227':'马达加斯加','228':'马拉维','229':'马里','230':'毛里塔尼亚','231':'毛里求斯','232':'摩洛哥','233':'莫桑比克','234':'纳米比亚','235':'尼日尔','236':'尼日利亚','237':'留尼汪','238':'卢旺达','239':'圣多美和普林西比','240':'塞内加尔','241':'塞舌尔','242':'塞拉利昂','243':'索马里','244':'南非','245':'西撒哈拉','246':'苏丹','247':'坦桑尼亚','248':'多哥','249':'突尼斯','250':'乌干达','251':'布基纳法索','252':'民主刚果','253':'赞比亚','254':'津巴布韦','255':'莱索托','256':'梅利利亚','257':'斯威士兰','258':'厄立特里亚','259':'马约特岛','299':'非洲其他国家(地区)','301':'比利时','302':'丹麦','303':'英国','304':'德国','305':'法国','306':'爱尔兰','307':'意大利','308':'卢森堡','309':'荷兰','310':'希腊','311':'葡萄牙','312':'西班牙','313':'阿尔巴尼亚','314':'安道尔','315':'奥地利','316':'保加利亚','318':'芬兰','320':'直布罗陀','321':'匈牙利','322':'冰岛','323':'列支敦士登','324':'马耳他','325':'摩纳哥','326':'挪威','327':'波兰','328':'罗马尼亚','329':'圣马力诺','330':'瑞典','331':'瑞士','334':'爱沙尼亚','335':'拉脱维亚','336':'立陶宛','337':'格鲁吉亚','338':'亚美尼亚','339':'阿塞拜疆','340':'白俄罗斯','343':'摩尔多瓦','344':'俄罗斯联邦','347':'乌克兰','349':'塞尔维亚和黑山','350':'斯洛文尼亚','351':'克罗地亚', '352':'捷克共和国','353':'斯洛伐克','354':'马其顿', '355':'波斯尼亚-黑塞哥维那共','356':'梵蒂冈城国','357':'法罗群岛','399':'欧洲其他国家(地区)','401':'安提瓜和巴布达','402':'阿根廷','403':'阿鲁巴岛', '404':'巴哈马','405':'巴巴多斯','406':'伯利兹','408':'玻利维亚','409':'博内尔', '410':'巴西','411':'开曼群岛','412':'智利','413':'哥伦比亚','414':'多米尼亚共和国','415':'哥斯达黎加', '416':'古巴','417':'库腊索岛','418':'多米尼加共和国','419':'厄瓜多尔','420':'法属圭亚那','421':'格林纳达','422':'瓜德罗普','423':'危地马拉','424':'圭亚那','425':'海地', '426':'洪都拉斯','427':'牙买加','428':'马提尼克','429':'墨西哥','430':'蒙特塞拉特','431':'尼加拉瓜','432':'巴拿马','433':'巴拉圭','434':'秘鲁','435':'波多黎各','436':'萨巴','437':'圣卢西亚','438':'圣马丁岛','439':'圣文森特和格林纳丁斯','440':'萨尔瓦多','441':'苏里南','442':'特立尼达和多巴哥','443':'特克斯和凯科斯群岛','444':'乌拉圭','445':'委内瑞拉','446':'英属维尔京群岛','447':'圣其茨-尼维斯','448':'圣皮埃尔和密克隆','449':'荷属安地列斯群岛','499':'拉丁美洲其他国家(地区)','501':'加拿大','502':'美国','503':'格陵兰','504':'百慕大','599':'北美洲其他国家(地区)','601':'澳大利亚','602':'库克群岛','603':'斐济','604':'盖比群岛','605':'马克萨斯群岛','606':'瑙鲁','607':'新喀里多尼亚','608':'瓦努阿图','609':'新西兰','610':'诺福克岛','611':'巴布亚新几内亚','612':'社会群岛','613':'所罗门群岛','614':'汤加','615':'土阿莫土群岛','616':'土布艾群岛','617':'萨摩亚','618':'基里巴斯','619':'图瓦卢','620':'密克罗尼西亚联邦','621':'马绍尔群岛','622':'帕劳共和国','623':'法属波利尼西亚','625':'瓦利斯和浮图纳','699':'大洋洲其他国家(地区)','701':'国(地)别不详的','702':'联合国及机构和国际组织','999':'中性包装原产国别'}>
                            <select id="country" name="country" class="input-medium">
								<#list map?keys as key>
                                    <option value="${key}" <#if e.unit?? && e.unit==key>selected="selected" </#if>>${map[key]}</option>
								</#list>
                            </select>
                        </div>
                    </div>

                    <div class="form-group col-md-6">
                        <label class="col-md-4 control-label">是否新品</label>
                        <div class="col-md-8">
							<#assign map = {'n':'否','y':'是'}>
                            <select id="isnew" name="isnew" class="input-medium">
								<#list map?keys as key>
                                    <option value="${key}" <#if e.isnew?? && e.isnew==key>selected="selected" </#if>>${map[key]}</option>
								</#list>
                            </select>
                        </div>
                    </div>

                    <div class="form-group col-md-6">
                        <label class="col-md-4 control-label">是否特价</label>
                        <div class="col-md-8">
							<#assign map = {'n':'否','y':'是'}>
                            <select id="sale" name="sale" class="input-medium">
								<#list map?keys as key>
                                    <option value="${key}" <#if e.sale?? && e.sale==key>selected="selected" </#if>>${map[key]}</option>
								</#list>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">规格型号</label>
                        <div class="col-md-10">
							<textarea name="goodsModel" class="form-control" rows="3" id="goodsModel"
                                      data-rule="规格型号;required;introduce;length[4~500];">${e.goodsModel!""}</textarea>
                        </div>
                    </div>

                    <div class="form-group col-md-6">
                        <label class="col-md-4 control-label">行邮税号</label>
                        <div class="col-md-8"><input type="text"  value="${e.taxCode!""}" name="taxCode"  size="8" maxlength="8"
                                                     id="taxCode" />
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label class="col-md-4 control-label">送积分</label>
                        <div class="col-md-8">
                            <input type="text"  value="${e.score!""}" name="score" type="text"  id="score" maxlength="20" data-rule="销量;required;integer;score;"/>
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label class="col-md-4 control-label">海关备案商品编号</label>
                        <div class="col-md-8"><input type="text"  value="${e.itemNo!""}" name="itemNo"  size="8" maxlength="8"
                                                     id="itemNo" />
                        </div>
                    </div>
                    <div class="form-group col-md-6">
                        <label class="col-md-4 control-label">用途</label>
                        <div class="col-md-8">
                            <#assign map = {'1':'种用或繁殖','2':'食用','3':'奶用','4':'观赏或演艺','5':'伴侣','6':'实验','7':'药用','8':'饲用','9':'其他','10':'介质土','A':'食品包装材料','B':'食品加工设备','C':'食品添加剂','D':'食品容器','E':'食品洗涤剂','F':'食品消毒剂'}>
                            <select id="purposeCode" name="purposeCode" class="input-medium">
                                <#list map?keys as key>
                                    <option value="${key}" <#if e.purposeCode?? && e.purposeCode==key>selected="selected" </#if>>${map[key]}</option>
                                </#list>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">页面标题</label>
                        <div class="col-md-10">
                            <input type="text"  value="${e.title!""}" name="title" type="text" class="form-control"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">页面描述</label>
                        <div class="col-md-10">
                            <input type="text"  value="${e.description!""}" name="description" type="text" class="form-control" />
						</div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">页面关键字</label>
                        <div class="col-md-10">
                            <input type="text"  value="${e.keywords!""}" name="keywords" type="text" class="form-control" />
                        </div>
                    </div>
					<#if e.id??>
                    <div class="form-group">
                        <label class="col-md-2 control-label">其他信息</label>
                        <div class="col-md-10">
                            录入人：<a style="text-decoration: underline;" target="_blank" href="${basepath}/manage/user/show?account=${e.createAccount!""}">${e.createAccount!""}</a>
                            录入时间：${e.createtime!""}<br>
                            最后修改人：<a style="text-decoration: underline;" target="_blank" href="${basepath}/manage/user/show?account=${e.updateAccount!""}">${e.updateAccount!""}</a>
                            最后修改时间：${e.updatetime!""}
                        </div>
                    </div>
					</#if>
                    </div> <!--end form-->
			</div>
			<div id="tabs-2">
				<textarea data-rule="商品介绍;required;productHTML;" id="productHTML" name="productHTML" style="width:100%;height:500px;visibility:hidden;">${e.productHTML!""}</textarea>
			</div>
			<div id="tabs-3">
				<div>
					<h4><div class="alert alert-info">图片列表</div></h4>
					<table class="table table-bordered">
						<tr>
							<td colspan="11">
								<button method="deleteImageByImgPaths" onclick="return deleteImageByImgPaths();"
											class="btn btn-primary">删除</button>
							</td>
						</tr>
						<tr style="background-color: #dff0d8">
							<th width="20"><input type="checkbox" id="firstCheckbox" /></th>
							<th>图片地址</th>
		<!-- 					<th>设为封面</th> -->
						</tr>
                        <#if e.imagesList??>
                            <#list e.imagesList as item>
                                <tr>
                                    <td><input type="checkbox" name="imagePaths"
                                            value="${item!""}" /></td>
                                    <td>
                                        <a href="${systemSetting().imageRootPath}${item!""}" target="_blank">
                                            <img style="max-width: 100px;max-height: 100px;" alt="" src="${systemSetting().imageRootPath}${item!""}">
                                        </a>
                                    </td>
                                </tr>
                            </#list>
                        </#if>
					</table>
				</div>
				<br>
				<table class="table table-bordered">
					<tr style="background-color: #dff0d8">
						<td>新增图片 </td>
					</tr>
					<tr>
						<td>
                            <input id="uploadify" name="uploadify" value="添加" class="btn btn-warning" type="button"/></td>
					</tr>
					<tr id="firstTr" style="display:none">
						<td>
								<#--<input type="button" name="filemanager" value="浏览图片" class="btn btn-warning"/>-->
									<img name="img"  style="width:50px;height:50px;max-width: 50px;max-height: 50px;">
								<input type="text" ccc="imagesInput" name="images" style="width: 260px;" readonly="readonly"/>
						</td>
					</tr>
				</table>
			</div>
			
			<!-- 商品属性 -->
			<div id="tabs-4">
				<table class="table table-bordered">
                    <#if e.attrList?? && e.attrList?size gt 0>
                        <#list e.attrList as attr>
                            <tr>
                                <td nowrap="nowrap" style="text-align: right;">${attr.name!""}</td>
                                <td>
                                    <select id="attrSelectIds_${attr_index}" name="attrSelectIds">
                                        <option value="">--请选择--</option>
                                        <#list attr.attrList as item>
                                            <option value="${item.id!""}" <#if attr.selectedID==item.id?eval>selected="selected" </#if>>${item.name!""}</option>
                                        </#list>
                                    </select>
                                </td>
                            </tr>
                        </#list>
                    </#if>
				</table>
			</div>
			
			<!-- 商品参数 -->
			<div id="tabs-5">
				<table class="table">
                    <#if e.parameterList?? && e.parameterList?size gt 0 >
                        <#list e.parameterList as param>
                            <tr>
                                <th style="display: none;"><input type="hidden" value="${param.id!""}" name="parameterIds"/></th>
                                <th style="text-align: right;">${param.name!""}</th>
                                <th><input type="text"  value="${param.parameterValue!""}" name="parameterNames" /></th>
                            </tr>
                        </#list>
                    </#if>
				</table>
			</div>
			
			<!-- 商品规格 -->
			<div id="tabs-6">
				<div class="row">
				<table class="table">
					<tr>
						<th style="display: none;">id</th>
						<th>尺寸</th>
						<th>颜色</th>
						<th>规格库存数</th>
						<th>价格</th>
						<th>是否显示</th>
					</tr>
					<#if e.specList?? && e.specList?size gt 0>
                        <#list e.specList as item>
							<tr>
								<td style="display: none;"><input type="hidden" value="${item.id!""}" name="specList[${item_index}].id"/></td>
								<td><input type="text"  value="${e.specList[item_index].specSize!""}" name="specList[${item_index}].specSize"  class="search-query input-small"/></td>
								<td><input type="text"  value="${e.specList[item_index].specColor!""}" name="specList[${item_index}].specColor"  class="search-query input-small"/></td>
								<td><input type="text"  value="${e.specList[item_index].specStock!""}" name="specList[${item_index}].specStock"  class="search-query input-small"/></td>
								<td><input type="text"  value="${e.specList[item_index].specPrice!""}" name="specList[${item_index}].specPrice"  class="search-query input-small"/></td>
								<td>
                                    <#assign map = {'n':'不显示','y':'显示'}>
                                    <select id="e_spec_specStatus" name="specList[${item_index}].specStatus" class="search-query input-medium">
                                        <#list map?keys as key>
                                            <option value="${key}" <#if item.specStatus?? && item.specStatus==key>selected="selected" </#if>>${map[key]}</option>
                                        </#list>
                                    </select>
                                </td>
							</tr>
                        </#list>
					<#else>
                        <#list [1,2] as item>
							<tr>
								<td style="display: none;"><input type="hidden" value="${e.id!""}" name="specList[${item_index}].id"/></td>
								<td><input type="text" name="specList[${item_index}].specColor"  class="search-query input-small"/></td>
								<td><input type="text" name="specList[${item_index}].specSize"  class="search-query input-small"/></td>
								<td><input type="text" name="specList[${item_index}].specStock"  class="search-query input-small"/></td>
								<td><input type="text" name="specList[${item_index}].specPrice"  class="search-query input-small"/></td>
								<td>
                                    <#assign map = {'n':'不显示','y':'显示'}>
                                    <select id="e_spec_specStatus" name="specList[${item_index}].specStatus" class="search-query input-medium">
                                        <#list map?keys as key>
                                            <option value="${key}" >${map[key]}</option>
                                        </#list>
                                    </select>
                                </td>
							</tr>
                        </#list>
					</#if>
				</table>
                </div>
			</div>
			
			<div id="tabs-7">
				商品赠品:
                    <select name="giftID">
                        <option></option>
                        <#if giftList??>
                            <#list giftList as item>
                                <option value="${item.id}" <#if e.giftID?? && e.giftID == item.id>selected="selected"</#if>>${item.giftName!""}</option>
                            </#list>
                        </#if>
                    </select>
			</div>
			
		</div>
</form>

<script>
$(function() {
	$( "#tabs" ).tabs({
		//event: "mouseover"
	});
	//alert($("#insertOrUpdateMsg").html());
//	if($("#insertOrUpdateMsg").html()!='' && $("#insertOrUpdateMsg").html().trim().length>0){
//		$("#insertOrUpdateMsg").slideDown(1000).delay(1500).slideUp(1000);
//	}
	
	selectDefaultCatalog();
	
	$("#removePife").click(function(){
		clearRootImagePath();
	});
});
//删除图片主路径
function deleteImageByImgPaths(){
	if ($("input:checked").size() == 0) {
		alert("请选择要删除的图片！");
		return false;
	}
	return confirm("确定删除选择的图片吗?");
}

function selectDefaultCatalog(){
	var _catalogID = $("#catalogID").val();
	if(_catalogID!='' && _catalogID>0){
		//$("#catalogSelect").attr("value",_catalogID);
		$("#catalogSelect").val(_catalogID);
	}
}

function catalogChange(obj){
	var _pid = $(obj).find("option:selected").attr("pid");
	if(_pid==0){
		alert("不能选择大类!");
		selectDefaultCatalog();
		return false;
	}
	var _productID = $("#productID").val();
	
	if(confirm("修改商品类别会清空该商品的属性和参数，确认要这样做吗？")){
		$.blockUI({ message: "正在切换商品目录，请稍候...",css: { 
            border: 'none', 
            padding: '15px', 
            backgroundColor: '#000', 
            '-webkit-border-radius': '10px', 
            '-moz-border-radius': '10px', 
            opacity: .5, 
            color: '#fff' 
        }});
		
		//alert($(obj).val());
		if(_productID==''){
			//alert(3);
			document.form.action = "toAdd?chanageCatalog=true&catalog="+$(obj).val();
		}else{
			document.form.action = "updateProductCatalog?id="+_productID+"&chanageCatalog=true&catalog="+$(obj).val();
		}
		document.form.submit();
	}else{
		selectDefaultCatalog();
	}
}
</script>

<script>
	var editor;
	KindEditor.ready(function(K) {
		editor = K.create('textarea[name="productHTML"]', {
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
	
	function addTrFunc(){
		var cc = $("#firstTr").clone();
		$("#firstTr").after(cc);
		
		cc.find("a").show();
	}
	
	function removeThis(t){
		$(t).parent().parent().remove();
		return false;
	}
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
</script>
		
	 <link rel="stylesheet" href="${basepath}/resource/uploadify/uploadify.css"  type="text/css">
	 <script type="text/javascript" src="${basepath}/resource/uploadify/jquery.uploadify.min.js"></script>
	 
	 <script type="text/javascript">
	$(document).ready(function() {
	
		ajaxLoadImgList();
		var url = '${basepath}/common/uploadify.do';
		//alert(url);
		$("#uploadify").uploadify({
			//'auto'           : false,
           'swf'       	 : '${basepath}/resource/uploadify/uploadify.swf',
           'uploader'       : url,//后台处理的请求
           'queueID'        : 'fileQueue',//与下面的id对应
           //'queueSizeLimit' :100,
           //'fileTypeDesc'   : 'rar文件或zip文件',
           //'fileTypeExts' 	 : '*.jpg;*.jpg', //控制可上传文件的扩展名，启用本项时需同时声明fileDesc
           //'fileTypeExts'   : '*.rar;*.zip', //控制可上传文件的扩展名，启用本项时需同时声明fileDesc  
           
           
           //'fileTypeDesc' : '图片文件' , //出现在上传对话框中的文件类型描述
//'fileTypeExts' : '*.jpg;*.bmp;*.png;*.gif', //控制可上传文件的扩展名，启用本项时需同时声明filedesc

           'multi'          : true,
           'buttonText'     : '本地上传',
           
           onUploadSuccess:function(file, data, response){
				//alert("上传成功,data="+data+",file="+file+",response="+response);      
//				ajaxLoadImgList();
			   data = $.parseJSON(data);
			   if(data.error == '1') {
				   alert("上传失败：\n失败原因:" + data.msg);
			   } else {
					var $tr = $("#firstTr").clone();
				   $tr.find("img[name=img]").attr("src", "${systemSetting().imageRootPath}" + data.filePath);
				   $tr.find(":input[name=images]").val(data.filePath);
				   $("#firstTr").parent().append($tr);
				   $tr.show();
			   }
           },
           onUploadError:function(file, errorCode, errorMsg) {
        	   alert("上传失败,data="+data+",file="+file+",response="+response);   
           }
	 	});
	});
	
	//ajax加载内容图片列表
	function ajaxLoadImgList(){
		if($("#id").val()==''){
			 $("#fileListDiv").html("");
			 return;
		}
		
		 $("#fileListDiv").html("");
		var _url = "ajaxLoadImgList?id="+$("#id").val();
		$.ajax({
		  type: 'POST',
		  url: _url,
		  data: {},
		  success: function(data){
			  var _tableHtml = "<table class='table table-bordered' style='border:0px solid red;'>";
				  _tableHtml += "<tr style='background-color: #dff0'>";
				  _tableHtml += "<td>图片地址</td><td>设为默认图片</td><td>操作</td>";
				  _tableHtml += "</tr>";
			  $.each(data,function(i,row){
				  _tableHtml += "<tr>";
				  var str = "<a target='_blank' href='"+row+"'>"+row+"</a>";
				  _tableHtml += "<td>"+str+"</td><td><input type='radio' onclick='setProductImageToDefault(\""+row+"\")' name='abcdef123'/></td><td><input type='button' Class='btn btn-danger' value='删除' onclick='deleteImageByProductID(\""+row+"\")'/></td>";
				  _tableHtml += "</tr>";
				  //$("#fileListDiv").append("<a target='_blank' href='"+row+"'>"+row+"</a><br>");
			  });
			  _tableHtml += "</table>";
			  $("#fileListDiv").append(_tableHtml);
		  },
		  dataType: "json",
		  error:function(){
			alert("加载图片列表失败！");
		  }
		});
	}
	
	//产品图片设置为默认图片
	function setProductImageToDefault(imageUrl){
		var _url = "setProductImageToDefault?id="+$("#id").val()+"&imageUrl="+imageUrl;
		$.ajax({
		  type: 'POST',
		  url: _url,
		  data: {},
		  success: function(data){
			  //alert("设置成功!");
			  $("#showMessage").append("设置成功！").fadeTo(2000, 1, function(){
				   //alert("Animation Done.");
				   $("#showMessage").html("").hide();
			  });
		  },
		  dataType: "text",
		  error:function(){
			alert("设置失败！");
		  }
		});
	}
	
	//产品图片设置为默认图片
	function deleteImageByProductID(imageUrl){
		if(!confirm("确定删除选择的记录?")){
			return ;
		}
		var _url = "deleteImageByProductID?id="+$("#id").val()+"&imageUrl="+imageUrl;
		$.ajax({
		  type: 'POST',
		  url: _url,
		  data: {},
		  success: function(data){
				  	ajaxLoadImgList();
			  //$("#showMessage").append("删除成功！").fadeTo(2000, 1, function(){
				//   $("#showMessage").html("").hide();
			  //});
			  
		  },
		  dataType: "text",
		  error:function(){
			alert("删除失败！");
		  }
		});
	}
	</script>
</@page.pageBase>