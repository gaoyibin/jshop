<#import "/manage/tpl/htmlBase.ftl" as html>
<@html.htmlBase>
<div >
	<div>
		<div>
			<form action="${basepath}/manage/order/toCustomsDeclare.do" method="post">

                <table style="width: 99%;margin:0px auto" class="table table-bordered" >
                    <tr><th colspan="6">订单报关信息</th></tr>

                    <tr style="height: 20px">
                        <td nowrap="nowrap" width="10%">签名方式</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="sign_type" value="${e.sign_type!""}" >(固定；0代表MD5)</td>
                        <td nowrap="nowrap" width="10%">接口版本</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="service_version" value="${e.service_version!""}">(版本号，取值：1.0)</td>

                    </tr>
                    <tr>
                        <td nowrap="nowrap" width="10%">字符集</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="input_charset" value="${e.input_charset!""}">(字符编码,取值：UTF-8)</td>
                        <td nowrap="nowrap">请求流水</td>
                        <td nowrap="nowrap"><input type="text" name="request_id" value="${e.request_id!""}">(商户生成的用于唯一标识一次报关操作的业务编号,需确保永不重复)</td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap">商户号</td>
                        <td nowrap="nowrap"><input type="text" name="mcht_id" value="${e.mcht_id!""}"></td>
                        <td nowrap="nowrap">商户海关备案号</td>
                        <td nowrap="nowrap"><input type="text" name="mcht_customs_code" value="${e.mcht_customs_code!""}"></td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap">商户海关备案名称</td>
                        <td nowrap="nowrap"><input type="text" name="mcht_customs_name" value="${e.mcht_customs_name!""}"></td>
                        <td nowrap="nowrap">支付流水</td>
                        <td nowrap="nowrap"><input type="text" name="openepay_no" value="${e.openepay_no!""}"></td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap">币种</td>
                        <td nowrap="nowrap"><input type="text" name="currency" value="${e.currency!""}"></td>
                        <td nowrap="nowrap">报关金额</td>
                        <td nowrap="nowrap"><input type="text" name="amount" value="${e.amount!""}"></td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap">海关</td>
                        <td nowrap="nowrap"><input type="text" name="customs_type" value="${e.customs_type!""}"></td>
                        <td nowrap="nowrap">证件类型</td>
                        <td nowrap="nowrap"><input type="text" name="id_type" value="${e.id_type!""}"></td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap" width="10%">证件号码</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="id_no" value="${e.id_no!""}" ></td>
                        <td nowrap="nowrap" width="10%">姓名</td>
                        <td nowrap="nowrap" width="23%"><input type="text" name="id_name" value="${e.id_name!""}"></td>
                    </tr>
                    <#if retmsg??>
                        <tr colspan="2">
                            <td nowrap="nowrap" width="10%">报关结果</td>
                            <td nowrap="nowrap" width="23%"><font color="red">${retmsg!""}</font></td>

                        </tr>
                    </#if>

                </table>

                <a href="javascript:;" class="a-upload">
                    <input type="submit" >报关
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