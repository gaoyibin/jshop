<#import "/manage/tpl/htmlBase.ftl" as html>
<@html.htmlBase>
<div >
    <div>
        <div>
            <form action="${basepath}/xmlgenerate.do">

                <table style="width: 99%;margin:0px auto" class="table table-bordered" >
                    <tr><th colspan="6">订单信息表头</th></tr>
                    <tr style="height: 20px">
                        <td nowrap="nowrap" width="10%">电商代码</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="cbeCode" value="${ss.cbeCode!""}" ></td>
                        <td nowrap="nowrap" width="10%">电商名称</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="cbeName" value="${ss.cbeName!""}"></td>
                        <td nowrap="nowrap" width="10%">电商平台代码</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="ecpCode" value="${ss.ecpCode!""}"></td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap">电商平台名称</td>
                        <td nowrap="nowrap"><input type="text" name="ecpName" value="${ss.ecpName!""}"></td>
                        <td nowrap="nowrap">订单编号</td>
                        <td nowrap="nowrap"><input type="text" name="orderNo" value="${e.id!""}"></td>
                        <td nowrap="nowrap">总费用</td>
                        <td nowrap="nowrap"><input type="text" name="charge" value="${e.amount!""}"></td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap">货值</td>
                        <td nowrap="nowrap"><input type="text" name="goodsValue" value="${e.ptotal!""}"></td>
                        <td nowrap="nowrap">运费</td>
                        <td nowrap="nowrap"><input type="text" name="freight" value="${e.fee!""}"></td>
                        <td nowrap="nowrap">其他费用</td>
                        <td nowrap="nowrap"><input type="text" name="other" value=""></td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap">进口行邮税</td>
                        <td nowrap="nowrap"><input type="text" name="tax" value="${ss.tax!""}"></td>
                        <td nowrap="nowrap">客户姓名</td>
                        <td nowrap="nowrap"><input type="text" name="customer" value="${e.account!""}"></td>
                        <td nowrap="nowrap">发货人名称</td>
                        <td nowrap="nowrap"><input type="text" name="shipper" value="${ss.shipper!""}"></td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap" width="10%">发货人地址</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="shipperAddress" value="${ss.shipperAddress!""}" ></td>
                        <td nowrap="nowrap" width="10%">发货人电话</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="shipperTelephone" value="${ss.shipperTelephone!""}"></td>
                        <td nowrap="nowrap" width="10%">发货人所在国</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="shipperCountry" value="${ss.shipperCountry!""}"></td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap" width="10%">订购人名称</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="consignee" value="${e.ordership.shipname!""}" ></td>
                        <td nowrap="nowrap" width="10%">收货人地址</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="consigneeAddress" value="${e.ordership.shipaddress!""}"></td>
                        <td nowrap="nowrap" width="10%">收货人电话</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="consigneeTelephone" value="${e.ordership.phone!""}"></td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap" width="10%">收货人所在国</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="consigneeCountry" value="" ></td>
                        <td nowrap="nowrap" width="10%">证件类型</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="idType" value=""></td>
                        <td nowrap="nowrap" width="10%">订购人证件号码</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="customerId" value=""></td>
                    </tr>

                    <tr>
                        <td nowrap="nowrap">进出口标志</td>
                        <td nowrap="nowrap"><input type="text" name="ieType" value="${ss.ieType!""}"></td>
                        <td nowrap="nowrap">批次号</td>
                        <td nowrap="nowrap"><input type="text" name="batchNumbers" value="${ss.batchNumbers!""}"></td>
                        <td nowrap="nowrap">总运单号</td>
                        <td nowrap="nowrap"><input type="text" name="totalLogisticsNo" value="${ss.totalLogisticsNo!""}"></td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap">贸易国别</td>
                        <td nowrap="nowrap"><input type="text" name="tradeCountry" value="${ss.tradeCountry!""}"></td>
                        <td nowrap="nowrap">代理企业</td>
                        <td nowrap="nowrap"><input type="text" name="agentCode" value="${ss.agentCode!""}"></td>
                        <td nowrap="nowrap">代理企业名称</td>
                        <td nowrap="nowrap"><input type="text" name="agentName" value="${ss.agentName!""}"></td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap">包装种类</td>
                        <td nowrap="nowrap"><input type="text" name="wrapType" value="${ss.wrapType!""}"></td>
                        <td nowrap="nowrap">操作类型</td>
                        <td nowrap="nowrap"><input type="text" name="modifyMark" value="${ss.modifyMark!""}"></td>
                        <td nowrap="nowrap">备注</td>
                        <td nowrap="nowrap"><input type="text" name="Note" value=""></td>
                    </tr>

                </table>
                <table  style="width: 99%;margin:0px auto;margin-left: 10px;margin-top: 10px"  class="table table-bordered">
                    <tr><th colspan="21">订单信息表体</th></tr>
                    <tr>
                        <td>序号</td>
                        <!-- 			<td>商品编号</td> -->
                        <td>海关备案商品编号</td>
                        <td>商品货号</td>
                        <td>商品上架品名</td>
                        <td>商品描述</td>
                        <td>HS编码</td>
                        <td>申报品名</td>
                        <td>规格型号</td>
                        <td>行邮税号</td>
                        <td>成交单价</td>
                        <td>币制</td>
                        <td>数量</td>
                        <td>成交总价</td>
                        <td>计量单位</td>
                        <td>折扣优惠</td>
                        <td>是否赠品</td>
                        <td>原产国</td>
                        <td>用途</td>
                        <td>废旧物品</td>
                        <td>包装种类</td>
                        <td>件数</td>
                    </tr>
                    <#list e.orderdetail as item>
                        <tr>
                            <td nowrap="nowrap" style="width:50px;">&nbsp;${item_index+1}</td>
                            <td nowrap="nowrap"><input style="width:100px;" name="itemNo${item_index+1}" type="text" value="${item.productID!""}"></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="goodsNo${item_index+1}" type="text" value="${item.product.goodsNo!""}"></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="shelfGoodsName${item_index+1}" type="text" value="${item.product.name!""}"></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="describe${item_index+1}" type="text" value="${item.product.introduce!""}"></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="codeTs${item_index+1}" type="text" value="${item.product.codeTs!""}"></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="goodsName${item_index+1}" type="text" value="${item.product.name!""}"></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="goodsModel${item_index+1}" type="text" value="${item.product.goodsModel!""}"></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="taxCode${item_index+1}" type="text" value="${item.product.taxCode!""}"></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="price${item_index+1}" type="text" value="${item.product.price!""}"></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="currency${item_index+1}" type="text" value="${item.product.currency!""}"></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="quantity${item_index+1}" type="text" value="${item.number!""}"></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="priceTotal${item_index+1}" type="text" value="${item.total0!""}"></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="unit${item_index+1}" type="text" value="${item.product.unit!""}"></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="discount${item_index+1}" type="text" value=""></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="flag${item_index+1}" type="text" value="N"></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="country${item_index+1}" type="text" value="${item.product.country!""}"></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="purposeCode${item_index+1}" type="text" value="${item.product.purposeCode!""}"></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="wasteMaterials${item_index+1}" type="text" value="${ss.wasteMaterials!""}"></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="wrapType${item_index+1}" type="text" value="${ss.wrapType!""}"></td>
                            <td nowrap="nowrap"><input style="width:100px;" name="packNum${item_index+1}" type="text" value="${item.number!""}"></td>

                        </tr>
                    </#list>
                </table>
                <table style="width: 99%;margin:0px auto;margin-left: 10px;margin-top: 10px" class="table table-bordered" >
                    <tr><th colspan="6">订单支付信息</th></tr>
                    <tr>
                        <td nowrap="nowrap" width="10%">支付企业代码</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="paymentCode" value="${ss.paymentCode!""}" ></td>
                        <td nowrap="nowrap" width="10%">支付企业名称</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="paymentName" value="${ss.paymentName!""}"></td>
                        <td nowrap="nowrap" width="10%">支付类型</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="paymentType" value="${ss.paymentType!""}"></td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap">支付交易号</td>
                        <td nowrap="nowrap"><input type="text" name="paymentNo" value="${e.tradeNo!""}"></td>
                        <td nowrap="nowrap">物流企业代码</td>
                        <td nowrap="nowrap"><input type="text" name="logisticsCode" value="${e.expressCode!""}"></td>
                        <td nowrap="nowrap">物流企业名称</td>
                        <td nowrap="nowrap"><input type="text" name="logisticsName" value="${e.expressCompanyName!""}"></td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap">物流运单号</td>
                        <td nowrap="nowrap"><input type="text" name="logisticsNo" value="${e.expressNo!""}"></td>
                        <td nowrap="nowrap">物流跟踪号</td>
                        <td nowrap="nowrap"><input type="text" name="trackNo" value="${e.expressNo!""}"></td>
                        <td nowrap="nowrap" colspan="2"></td>

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