<#import "/manage/tpl/htmlBase.ftl" as html>
<@html.htmlBase>
<div >
	<div>
		<div>
			<form action="${basepath}/xmlgenerate.do">
                <input type="hidden" name="type" value="ceb623">
                <table style="width: 99%;margin:0px auto" class="table table-bordered" >
                    <tr><th colspan="6"></th></tr>
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
                        <td nowrap="nowrap" width="10%">申报海关代码</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="customsCode" value="" ></td>
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
                        <td nowrap="nowrap">物流运单编号</td>
                        <td nowrap="nowrap"><input type="text" name="logisticsNo" value="${e.expressNo!""}"></td>
                        <td nowrap="nowrap">物流企业代码</td>
                        <td nowrap="nowrap"><input type="text" name="logisticsCode" value="${e.expressCode!""}""></td>

                    </tr>
                    <tr>
                        <td nowrap="nowrap" width="10%">物流企业名称</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="logisticsName" value="${e.expressCompanyName!""}" ></td>
                        <td nowrap="nowrap" width="10%">企业内部编号</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="copNo" value=""></td>
                        <td nowrap="nowrap" width="10%">预录入编号</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="preNo" value=""></td>
                        <td nowrap="nowrap" width="10%">清单编号</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="invtNo" value=""></td>
                    </tr>

                    <tr>
                        <td nowrap="nowrap" width="10%">订购人证件类型</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="buyerIdType" value=""></td>
                        <td nowrap="nowrap">订购人证件号码</td>
                        <td nowrap="nowrap"><input type="text" name="buyerIdNumber" value=""></td>
                        <td nowrap="nowrap">订购人姓名</td>
                        <td nowrap="nowrap"><input type="text" name="buyerName" value="${e.ordership.shipname!""}"></td>
                        <td nowrap="nowrap">订购人电话</td>
                        <td nowrap="nowrap"><input type="text" name="buyerTelephone" value="${e.ordership.phone!""}"></td>
                    </tr>

                    <tr>
                        <td nowrap="nowrap" width="10%">申报企业代码</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="agentCode" value="${ss.agentCode!""}" ></td>
                        <td nowrap="nowrap" width="10%">申报企业名称</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="agentName" value="${ss.agentName!""}"></td>
                        <td nowrap="nowrap">撤单原因</td>
                        <td nowrap="nowrap" ><input type="text" name="reason" value=""></td>
                        <td nowrap="nowrap">备注</td>
                        <td nowrap="nowrap" colspan="3"><input type="text" name="note" value=""></td>
                    </tr>
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