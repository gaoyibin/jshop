<#import "/manage/tpl/htmlBase.ftl" as html>
<@html.htmlBase>
<div >
	<div>
		<div>
			<form action="${basepath}/xmlgenerate.do">
                <input type="hidden" name="type" value="ceb621">
                <table style="width: 99%;margin:0px auto" class="table table-bordered" >
                    <tr><th colspan="6">进口清单表头</th></tr>
                    <tr style="height: 20px">
                        <td nowrap="nowrap" width="10%">系统唯一序号</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="guid" value="${uid}" ></td>
                        <td nowrap="nowrap" width="10%">报送类型</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="appType" value="1"></td>
                        <td nowrap="nowrap" width="10%">报送时间</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="appTime" value=""></td>
                        <td nowrap="nowrap">业务状态</td>
                        <td nowrap="nowrap"><input type="text" name="appStatus" value="2"></td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap">订单编号</td>
                        <td nowrap="nowrap"><input type="text" name="orderNo" value="${e.id!""}"></td>
                        <td nowrap="nowrap">电商平台代码</td>
                        <td nowrap="nowrap"><input type="text" name="ebpCode" value="${ss.ecpCode!""}"></td>
                        <td nowrap="nowrap">电商平台名称</td>
                        <td nowrap="nowrap"><input type="text" name="ebpName" value="${ss.ecpName!""}"></td>
                        <td nowrap="nowrap">电商企业代码</td>
                        <td nowrap="nowrap"><input type="text" name="ebcCode" value="${ss.agentCode!""}"></td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap">电商企业名称</td>
                        <td nowrap="nowrap"><input type="text" name="ebcName" value="${ss.agentName!""}"></td>
                        <td nowrap="nowrap">物流运单编号</td>
                        <td nowrap="nowrap"><input type="text" name="logisticsNo" value="${e.expressNo!""}"></td>
                        <td nowrap="nowrap">物流企业代码</td>
                        <td nowrap="nowrap"><input type="text" name="logisticsCode" value="${e.expressCode!""}""></td>
                        <td nowrap="nowrap" width="10%">物流企业名称</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="logisticsName" value="${e.expressCompanyName!""}" ></td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap" width="10%">企业内部编号</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="copNo" value=""></td>
                        <td nowrap="nowrap" width="10%">预录入编号</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="preNo" value=""></td>
                        <td nowrap="nowrap" width="10%">担保企业编号</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="assureCode" value="" ></td>
                        <td nowrap="nowrap" width="10%">账册编号</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="emsNo" value="" ></td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap" width="10%">清单编号</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="invtNo" value=""></td>
                        <td nowrap="nowrap" width="10%">进出口标记</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="ieFlag" value="I"></td>
                        <td nowrap="nowrap" width="10%">申报日期</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="declTime" value=""></td>
                        <td nowrap="nowrap" width="10%">申报海关代码</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="customsCode" value="" ></td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap" width="10%">口岸海关代码</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="portCode" value=""></td>
                        <td nowrap="nowrap" width="10%">进口日期</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="ieDate" value=""></td>
                        <td nowrap="nowrap" width="10%">订购人证件类型</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="buyerIdType" value=""></td>
                        <td nowrap="nowrap">订购人证件号码</td>
                        <td nowrap="nowrap"><input type="text" name="buyerIdNumber" value=""></td>
                    </tr>

                    <tr>
                        <td nowrap="nowrap">订购人姓名</td>
                        <td nowrap="nowrap"><input type="text" name="buyerName" value="${e.ordership.shipname!""}"></td>
                        <td nowrap="nowrap">订购人电话</td>
                        <td nowrap="nowrap"><input type="text" name="buyerTelephone" value="${e.ordership.phone!""}"></td>
                        <td nowrap="nowrap">收件地址</td>
                        <td nowrap="nowrap"><input type="text" name="consigneeAddress" value="${e.ordership.shipaddress!""}"></td>
                        <td nowrap="nowrap" width="10%">申报企业代码</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="agentCode" value="${ss.agentCode!""}" ></td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap" width="10%">申报企业名称</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="agentName" value="${ss.agentName!""}"></td>
                        <td nowrap="nowrap" width="10%">区内企业代码</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="areaCode" value=""></td>
                        <td nowrap="nowrap" width="10%">区内企业名称</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="areaName" value=""></td>
                        <td nowrap="nowrap" width="10%">贸易方式</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="tradeMode" value=""></td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap" width="10%">运输方式</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="trafMode" value="" ></td>
                        <td nowrap="nowrap" width="10%">运输工具编号</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="trafNo" value=""></td>
                        <td nowrap="nowrap" width="10%">航班航次号</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="voyageNo" value=""></td>
                        <td nowrap="nowrap" width="10%">提运单号</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="billNo" value=""></td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap" width="10%">监管场所代码</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="loctNo" value="" ></td>
                        <td nowrap="nowrap" width="10%">许可证件号</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="licenseNo" value=""></td>
                        <td nowrap="nowrap" width="10%">起运国（地区）</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="country" value="${ss.shipperCountry!""}"></td>
                        <td nowrap="nowrap" width="10%">运费</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="freight" value="${e.fee!""}"></td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap" width="10%">保费</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="insuredFee" value="" ></td>
                        <td nowrap="nowrap" width="10%">币制</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="currency" value=""></td>
                        <td nowrap="nowrap" width="10%">包装种类代码</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="wrapType" value="${ss.wrapType!""}"></td>
                        <td nowrap="nowrap" width="10%">件数</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="packNo" value=""></td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap">毛重（公斤）</td>
                        <td nowrap="nowrap" ><input type="text" name="grossWeight" value=""></td>
                        <td nowrap="nowrap">净重（公斤）</td>
                        <td nowrap="nowrap" ><input type="text" name="netWeight" value=""></td>
                        <td nowrap="nowrap">备注</td>
                        <td nowrap="nowrap" colspan="3"><input type="text" name="note" value=""></td>
                    </tr>

                </table>
                <table  style="width: 99%;margin:0px auto;margin-left: 10px;margin-top: 10px"  class="table table-bordered">
                    <tr><th colspan="21">进口清单表体 </th></tr>
                    <tr>
                        <td>序号</td>
                        <td>账册备案料号</td>
                        <td>企业商品货号</td>
                        <td>企业商品品名</td>
                        <td>商品编码</td>
                        <td>商品名称</td>
                        <td>商品规格型号</td>
                        <td>条码</td>
                        <td>原产国</td>
                        <td>币制</td>
                        <td>数量</td>
                        <td>法定数量</td>
                        <td>第二数量</td>
                        <td>计量单位</td>
                        <td>法定计量单位</td>
                        <td>第二计量单位</td>
                        <td>单价</td>
                        <td>总价</td>
                        <td>备注</td>
                    </tr>
					<#list e.orderdetail as item>
                        <tr>
                            <td nowrap="nowrap" style="width:50px;">&nbsp;${item_index+1}</td>
                            <td nowrap="nowrap"><input style="width:100px;" name="itemRecordNo${item_index+1}" type="text" value=""></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="itemNo${item_index+1}" type="text" value="${item.product.goodsNo!""}"></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="itemName${item_index+1}" type="text" value="${item.product.name!""}"></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="gcode${item_index+1}" type="text" value=""></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="gname${item_index+1}" type="text" value="${item.product.name!""}"></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="gmodel${item_index+1}" type="text" value="${item.product.goodsModel!""}"></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="barCode${item_index+1}" type="text" value=""></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="country${item_index+1}" type="text" value="${item.product.country!""}"></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="currency${item_index+1}" type="text" value="${item.product.currency!""}"></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="qty${item_index+1}" type="text" value="${item.number!""}"></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="qty1${item_index+1}" type="text" value="${item.number!""}"></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="qty2${item_index+1}" type="text" value="${item.number!""}"></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="unit${item_index+1}" type="text" value="${item.product.unit!""}"></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="unit1${item_index+1}" type="text" value="${item.product.unit!""}"></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="unit2${item_index+1}" type="text" value="${item.product.unit!""}"></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="price${item_index+1}" type="text" value="${item.product.price!""}"></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="totalPrice${item_index+1}" type="text" value="${item.total0!""}"></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="note${item_index+1}" type="text" value=""></td>
                        </tr>
					</#list>
                </table>
                <table style="width: 99%;margin:0px auto;margin-left: 10px;margin-top: 10px" class="table table-bordered" >
                    <tr><th colspan="6">其他</th></tr>
                    <tr>
                        <td nowrap="nowrap" width="10%">传输企业代码</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="copCode" value="${ss.agentCode!""}" ></td>
                        <td nowrap="nowrap" width="10%">传输企业名称</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="copName" value="${ss.agentName!""}"></td>
                        <td nowrap="nowrap" width="10%">报文传输模式</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="dxpMode" value="DXP"></td>
                        <td nowrap="nowrap">报文传输编号</td>
                        <td nowrap="nowrap"><input type="text" name="dxpId" value=""></td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap">备注</td>
                        <td nowrap="nowrap" colspan="7"><input type="text" name="note2" value=""></td>
                    </tr>
                </table>
                <a href="javascript:;" class="a-upload">
                    <input type="submit" >下载xml
                </a>
			</form>

		</div>
	</div>	
</div>
</body>
<style>
    /*a  upload */
    .a-upload {
		margin-top: 10px;
		margin-left: 10px;
        padding: 6px 12px;
        line-height: 20px;
        position: relative;
        cursor: pointer;
        color: #ffffff;
        background: #337ab7;
        border: 1px solid #337ab7;
        border-radius: 4px;
        overflow: hidden;
        display: inline-block;
        *display: inline;
        *zoom: 1
    }

    .a-upload  input {
        position: absolute;
        font-size: 100px;
        right: 0;
        top: 0;
        opacity: 0;
        filter: alpha(opacity=0);
        cursor: pointer
    }

    .a-upload:hover {
        color: #ffffff;
        background: #2e6da4;
        border-color: #2e6da4;
        text-decoration: none
    }
</style>
</html>

</@html.htmlBase>