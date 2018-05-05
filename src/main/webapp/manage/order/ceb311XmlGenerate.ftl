<#import "/manage/tpl/htmlBase.ftl" as html>
<@html.htmlBase>
<div >
	<div>
		<div>
			<form action="${basepath}/xmlgenerate.do">
                <input type="hidden" name="type" value="ceb311">
                <table style="width: 99%;margin:0px auto" class="table table-bordered" >
                    <tr><th colspan="6">电子订单表头</th></tr>
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
                        <td nowrap="nowrap">订单类型</td>
                        <td nowrap="nowrap"><input type="text" name="orderType" value="I"></td>
                        <td nowrap="nowrap">订单编号</td>
                        <td nowrap="nowrap"><input type="text" name="orderNo" value="${e.id!""}"></td>
                        <td nowrap="nowrap">电商平台代码</td>
                        <td nowrap="nowrap"><input type="text" name="ebpCode" value="${ss.ecpCode!""}"></td>
                        <td nowrap="nowrap">电商平台名称</td>
                        <td nowrap="nowrap"><input type="text" name="ebpName" value="${ss.ecpName!""}"></td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap">电商企业代码</td>
                        <td nowrap="nowrap"><input type="text" name="ebcCode" value="${ss.agentCode!""}"></td>
                        <td nowrap="nowrap">电商企业名称</td>
                        <td nowrap="nowrap"><input type="text" name="ebcName" value="${ss.agentName!""}"></td>
                        <td nowrap="nowrap">商品价格</td>
                        <td nowrap="nowrap"><input type="text" name="goodsValue" value="${e.amount!""}"></td>
                        <td nowrap="nowrap">运杂费</td>
                        <td nowrap="nowrap"><input type="text" name="freight" value="${e.fee!""}""></td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap" width="10%">非现金抵扣金额</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="discount" value="" ></td>
                        <td nowrap="nowrap" width="10%">代扣税款</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="taxTotal" value=""></td>
                        <td nowrap="nowrap" width="10%">实际支付金额</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="acturalPaid" value=""></td>
                        <td nowrap="nowrap" width="10%">币制</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="currency" value="142" ></td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap" width="10%">订购人注册号</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="buyerRegNo" value="" ></td>
                        <td nowrap="nowrap" width="10%">订购人姓名</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="buyerName" value="${e.ordership.shipname!""}"></td>
                        <td nowrap="nowrap" width="10%">订购人证件类型</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="buyerIdType" value=""></td>
                        <td nowrap="nowrap" width="10%">订购人证件号码</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="buyerIdNumber" value=""></td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap" width="10%">支付企业代码</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="payCode" value="${ss.paymentCode!""}" ></td>
                        <td nowrap="nowrap" width="10%">支付企业名称</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="payName" value="${ss.paymentName!""}"></td>
                        <td nowrap="nowrap" width="10%">支付交易编号</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="payTransactionId" value="${e.tradeNo!""}"></td>
                        <td nowrap="nowrap" width="10%">商品批次号</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="batchNumbers" value="${ss.batchNumbers!""}"></td>
                    </tr>

                    <tr>
                        <td nowrap="nowrap">收货人姓名</td>
                        <td nowrap="nowrap"><input type="text" name="consignee" value="${e.ordership.shipname!""}"></td>
                        <td nowrap="nowrap">收货人电话</td>
                        <td nowrap="nowrap"><input type="text" name="consigneeTelephone" value="${e.ordership.phone!""}"></td>
                        <td nowrap="nowrap">收货地址</td>
                        <td nowrap="nowrap"><input type="text" name="consigneeAddress" value="${e.ordership.shipaddress!""}"></td>
                        <td nowrap="nowrap">收货地址行政区划代码</td>
                        <td nowrap="nowrap"><input type="text" name="consigneeDistrict" value=""></td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap">备注</td>
                        <td nowrap="nowrap" colspan="7"><input type="text" name="note" value=""></td>

                    </tr>

                </table>
                <table  style="width: 99%;margin:0px auto;margin-left: 10px;margin-top: 10px"  class="table table-bordered">
                    <tr><th colspan="21">电子订单商品表体</th></tr>
                    <tr>
                        <td>商品序号</td>
                        <td>商品货号</td>
                        <td>商品名称</td>
                        <td>商品描述</td>
                        <td>条形码</td>
                        <td>单位</td>
                        <td>数量</td>
                        <td>单价</td>
                        <td>总价</td>
                        <td>币制</td>
                        <td>原产国</td>
                        <td>备注</td>
                    </tr>
					<#list e.orderdetail as item>
                        <tr>
                            <td nowrap="nowrap" style="width:50px;">&nbsp;${item_index+1}</td>
                            <td nowrap="nowrap"><input style="width:100px;" name="itemNo${item_index+1}" type="text" value="${item.product.goodsNo!""}"></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="itemName${item_index+1}" type="text" value="${item.product.name!""}"></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="itemDescribe${item_index+1}" type="text" value="${item.product.introduce!""}"></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="barCode${item_index+1}" type="text" value=""></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="unit${item_index+1}" type="text" value="${item.product.unit!""}"></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="qty${item_index+1}" type="text" value="${item.number!""}"></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="price${item_index+1}" type="text" value="${item.product.price!""}"></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="totalPrice${item_index+1}" type="text" value="${item.total0!""}"></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="currency${item_index+1}" type="text" value="${item.product.currency!""}"></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="country${item_index+1}" type="text" value="${item.product.country!""}"></td>
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