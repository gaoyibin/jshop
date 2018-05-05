package net.jeeshop.web.action.manage.order;import com.alibaba.fastjson.JSON;import net.jeeshop.core.KeyValueHelper;import net.jeeshop.core.ManageContainer;import net.jeeshop.core.ceb.build.BuildOrderXML;import net.jeeshop.core.dao.page.PagerModel;import net.jeeshop.core.exception.UpdateOrderStatusException;import net.jeeshop.core.front.SystemManager;import net.jeeshop.core.pay.opene.OpeneConfig;import net.jeeshop.core.system.bean.User;import net.jeeshop.services.front.area.bean.Area;import net.jeeshop.services.front.opene.OpeneService;import net.jeeshop.services.front.opene.bean.WithholdingOrder;import net.jeeshop.services.front.opene.utils.LogUtil;import net.jeeshop.services.manage.order.OrderService;import net.jeeshop.services.manage.order.bean.Order;import net.jeeshop.services.manage.orderdetail.OrderdetailService;import net.jeeshop.services.manage.orderdetail.bean.Orderdetail;import net.jeeshop.services.manage.orderlog.OrderlogService;import net.jeeshop.services.manage.orderlog.bean.Orderlog;import net.jeeshop.services.manage.orderpay.OrderpayService;import net.jeeshop.services.manage.orderpay.bean.Orderpay;import net.jeeshop.services.manage.ordership.OrdershipService;import net.jeeshop.services.manage.ordership.bean.Ordership;import net.jeeshop.services.manage.product.ProductService;import net.jeeshop.services.manage.product.bean.Product;import net.jeeshop.services.manage.systemSetting.bean.SystemSetting;import net.jeeshop.web.action.BaseController;import net.jeeshop.web.util.LoginUserHolder;import net.jeeshop.web.util.RequestHolder;import org.apache.commons.lang.StringUtils;import org.slf4j.LoggerFactory;import org.springframework.beans.factory.annotation.Autowired;import org.springframework.stereotype.Controller;import org.springframework.ui.ModelMap;import org.springframework.web.bind.annotation.RequestMapping;import org.springframework.web.bind.annotation.RequestMethod;import org.springframework.web.bind.annotation.ResponseBody;import java.io.IOException;import java.math.BigDecimal;import java.util.*;/** * 订单管理 *  * @author jqsl2012@163.com * @author dylan *  */@Controller@RequestMapping("/manage/order/")public class OrderAction extends BaseController<Order> {	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(OrderAction.class);	private static final long serialVersionUID = 1L;	@Autowired	private OrderService orderService;	@Autowired	private OrderpayService orderpayService;	@Autowired	private OrdershipService ordershipService;	@Autowired	private OrderdetailService orderdetailService;	@Autowired	private ProductService productService;	@Autowired	private OrderlogService orderlogService;	@Autowired	private OpeneService openeService;	private static final String page_toList = "/manage/order/orderList";	private static final String page_toAdd = "/manage/order/orderEdit";	private static final String page_toEdit = "/manage/order/orderEdit";	private static final String page_toPrint = "/manage/order/orderPrint";	private static final String page_toXmlGenerate = "/manage/order/orderXmlGenerate";	private static final String page_toCeb311Generate = "/manage/order/ceb311XmlGenerate";	private static final String page_toCeb621Generate = "/manage/order/ceb621XmlGenerate";	private static final String page_toCeb623Generate = "/manage/order/ceb623XmlGenerate";	private static final String page_toSendProduct = "/manage/order/sendProduct";	private static final String page_updateOrdership = "/manage/order/updateOrdership";	private static final String page_toCustomsDeclare = "/manage/order/orderCustomsDeclare";	private OrderAction() {		super.page_toList = page_toList;		super.page_toAdd = page_toAdd;		super.page_toEdit = page_toEdit;	}	// private Order order;	// private List<Orderdetail> orderdetailList;//订单项列表	// private String optionMsg;//操作消息提示	// private List<net.jeeshop.services.front.area.bean.Area> areaList;//区域列表	public OrderlogService getOrderlogService() {		return orderlogService;	}	public void setOrderlogService(OrderlogService orderlogService) {		this.orderlogService = orderlogService;	}	public OrdershipService getOrdershipService() {		return ordershipService;	}	public void setOrdershipService(OrdershipService ordershipService) {		this.ordershipService = ordershipService;	}	public OrderpayService getOrderpayService() {		return orderpayService;	}	public void setOrderpayService(OrderpayService orderpayService) {		this.orderpayService = orderpayService;	}	public ProductService getProductService() {		return productService;	}	public void setProductService(ProductService productService) {		this.productService = productService;	}	public OrderdetailService getOrderdetailService() {		return orderdetailService;	}	public void setOrderdetailService(OrderdetailService orderdetailService) {		this.orderdetailService = orderdetailService;	}	@Override	public OrderService getService() {		return orderService;	}	public void setOrderService(OrderService orderService) {		this.orderService = orderService;	}	@Override	protected void selectListAfter(PagerModel pager) {		super.selectListAfter(pager);		if (pager.getList() != null) {			// 订单状态中文化显示。			for (int i = 0; i < pager.getList().size(); i++) {				Order item = (Order) pager.getList().get(i);				item.setStatusStr(KeyValueHelper.get("order_status_" + item.getStatus()));				item.setPaystatusStr(KeyValueHelper.get("order_paystatus_" + item.getPaystatus()));				String kstatus = item.getKstatus();				item.setKstatus("1".equals(kstatus) ? "入库成功" : "0".equals(kstatus) ? "入库失败" : "");			}		}	}	/**	 * 退款管理、退货管理 页面必须直接显示与退款、退款状态相一致的数据	 */	@Override	protected void setParamWhenInitQuery(Order e) {		String refundStatus = RequestHolder.getRequest().getParameter("refundStatus");		String status = RequestHolder.getRequest().getParameter("status");		String paystatus = RequestHolder.getRequest().getParameter("paystatus");		// String notCancel = getRequest().getParameter("notCancel");		logger.error("refundStatus=" + refundStatus + ",status=" + status + ",paystatus=" + paystatus);		if (StringUtils.isNotBlank(refundStatus)) {			e.setRefundStatus(refundStatus);		}		if (StringUtils.isNotBlank(status)) {			e.setStatus(status);		}		if (StringUtils.isNotBlank(paystatus)) {			e.setPaystatus(paystatus);		}	}	/**	 * 订单打印功能	 * 	 * @return	 * @throws Exception	 */	@RequestMapping("toPrint")	public String toPrint(Order e, ModelMap model) throws Exception {		if (StringUtils.isBlank(e.getId())) {			throw new NullPointerException("订单ID不能为空！");		}		// 加载指定的订单信息		e = orderService.selectById(e.getId());		// 加载收货人地址信息		Ordership ordership = new Ordership();		ordership.setOrderid(e.getId());		ordership = ordershipService.selectOne(ordership);		if (ordership == null) {			throw new NullPointerException("系统查询不到收货人地址信息！");		}		e.setOrdership(ordership);		// 加载订单项列表 以及 产品信息		Orderdetail orderdetail = new Orderdetail();		orderdetail.setOrderID(Integer.valueOf(e.getId()));		List<Orderdetail> orderdetailList = orderdetailService.selectList(orderdetail);		if (orderdetailList == null) {			throw new NullPointerException("查询不到订单明细信息！");		}		e.setOrderdetail(orderdetailList);		model.addAttribute("e", e);		return page_toPrint;	}	/**	 * 下载跨境通xml文件	 *	 * @return	 * @throws Exception	 */	@RequestMapping("toXmlGenerate")	public String toXmlGenerate(Order e, ModelMap model) throws Exception {		if (StringUtils.isBlank(e.getId())) {			throw new NullPointerException("订单ID不能为空！");		}		// 加载指定的订单信息		e = orderService.selectById(e.getId());		// 加载收货人地址信息		Ordership ordership = new Ordership();		ordership.setOrderid(e.getId());		ordership = ordershipService.selectOne(ordership);		if (ordership == null) {			throw new NullPointerException("系统查询不到收货人地址信息！");		}		e.setOrdership(ordership);		// 加载订单项列表 以及 产品信息		Orderdetail orderdetail = new Orderdetail();		orderdetail.setOrderID(Integer.valueOf(e.getId()));		List<Orderdetail> orderdetailList = orderdetailService.selectList(orderdetail);		if (orderdetailList == null) {			throw new NullPointerException("查询不到订单明细信息！");		}		for(Orderdetail detail : orderdetailList){			Product product = productService.selectById(detail.getProductID() + "");			detail.setProduct(product);		}		e.setOrderdetail(orderdetailList);		model.addAttribute("e", e);		SystemSetting systemSetting = SystemManager.getInstance().getSystemSetting();		model.addAttribute("ss", systemSetting);		return page_toXmlGenerate;	}	/**	 * 海关报关	 *	 * @return	 * @throws Exception	 */	@RequestMapping("customsDeclare")	public String customsDeclare(Order e, ModelMap model) throws Exception {		if (StringUtils.isBlank(e.getId())) {			throw new NullPointerException("订单ID不能为空！");		}		// 加载指定的订单信息		e = orderService.selectById(e.getId());		if(e == null){			throw new NullPointerException("订单不存在！");		}		// 加载支付记录		Orderpay orderpay = new Orderpay();		orderpay.setOrderid(e.getId());		List<Orderpay> list = orderpayService.selectList(orderpay);		if (list != null) {				orderpay = list.get(0);		}		OrderCustomsDeclare orderCustomsDeclare = new OrderCustomsDeclare();		orderCustomsDeclare.setRequest_id(e.getId());		orderCustomsDeclare.setOpenepay_no(orderpay.getTradeNo());		orderCustomsDeclare.setAmount(new BigDecimal(e.getAmount()).multiply(new BigDecimal(100)).intValue() + "");//		openeService.customsDeclare(e.getId(),e.getTradeNo());		model.addAttribute("e", orderCustomsDeclare);		return page_toCustomsDeclare;	}	/**	 * 查看订单详细信息	 */	@Override	public String toEdit(Order e, ModelMap model) throws Exception {		if (StringUtils.isBlank(e.getId())) {			throw new NullPointerException("订单ID不能为空！");		}		// 加载指定的订单信息		e = orderService.selectOne(e);		if (e == null) {			throw new NullPointerException("根据订单ID查询不到订单！");		}		// 订单各种状态 中文化。这样做是为了考虑到以后国际化的需要		if (StringUtils.isNotBlank(e.getStatus())) {			e.setStatusStr(KeyValueHelper.get("order_status_" + e.getStatus()));		}		if (StringUtils.isNotBlank(e.getRefundStatus())) {			e.setRefundStatusStr(KeyValueHelper.get("order_refundStatus_" + e.getRefundStatus()));		}		if (StringUtils.isNotBlank(e.getPaystatus())) {			e.setPaystatusStr(KeyValueHelper.get("order_paystatus_" + e.getPaystatus()));		}		// 加载支付记录		Orderpay orderpay = new Orderpay();		orderpay.setOrderid(e.getId());		e.setOrderpayList(orderpayService.selectList(orderpay));		if (e.getOrderpayList() != null) {			for (int i = 0; i < e.getOrderpayList().size(); i++) {				Orderpay orderpayInfo = e.getOrderpayList().get(i);				String paymethod = KeyValueHelper.get("orderpay_paymethod_" + orderpayInfo.getPaymethod());				orderpayInfo.setPaymethod(paymethod);			}		}		// 加载订单配送记录		e.setOrdership(ordershipService.selectOne(new Ordership(e.getId())));		// 加载订单项列表 以及 产品信息		Orderdetail orderdetail = new Orderdetail();		orderdetail.setOrderID(Integer.valueOf(e.getId()));		List<Orderdetail> orderdetailList = orderdetailService.selectList(orderdetail);		if (orderdetailList == null || orderdetailList.size() == 0) {			throw new NullPointerException("订单数据异常，订单未包含任何订单项数据！");		}		e.setOrderdetail(orderdetailList);		// 检查此订单是否含赠品		for (int i = 0; i < e.getOrderdetail().size(); i++) {			Orderdetail item = e.getOrderdetail().get(i);			if (StringUtils.isNotBlank(item.getGiftID())) {				e.setHasGift(true);				break;			}		}		// 加载订单支付日志记录		if (StringUtils.isNotBlank(e.getId())) {			e.setOrderlogs(orderlogService.selectList(new Orderlog(e.getId())));			if (e.getOrderlogs() == null) {				e.setOrderlogs(Collections.EMPTY_LIST);			}			logger.error(">>>orderlogs.size=" + e.getOrderlogs().size());		}		model.addAttribute("e", e);		return page_toEdit;	}	/**	 * 生成跨境通xml文件	 */	@RequestMapping("xmlGenerate")	public String xmlGenerate(Order e, ModelMap model) throws Exception {		if (StringUtils.isBlank(e.getId())) {			throw new NullPointerException("订单ID不能为空！");		}		// 加载指定的订单信息		e = orderService.selectOne(e);		if (e == null) {			throw new NullPointerException("根据订单ID查询不到订单！");		}		// 订单各种状态 中文化。这样做是为了考虑到以后国际化的需要		if (StringUtils.isNotBlank(e.getStatus())) {			e.setStatusStr(KeyValueHelper.get("order_status_" + e.getStatus()));		}		if (StringUtils.isNotBlank(e.getRefundStatus())) {			e.setRefundStatusStr(KeyValueHelper.get("order_refundStatus_" + e.getRefundStatus()));		}		if (StringUtils.isNotBlank(e.getPaystatus())) {			e.setPaystatusStr(KeyValueHelper.get("order_paystatus_" + e.getPaystatus()));		}		// 加载支付记录		Orderpay orderpay = new Orderpay();		orderpay.setOrderid(e.getId());		e.setOrderpayList(orderpayService.selectList(orderpay));		if (e.getOrderpayList() != null) {			for (int i = 0; i < e.getOrderpayList().size(); i++) {				Orderpay orderpayInfo = e.getOrderpayList().get(i);				String paymethod = KeyValueHelper.get("orderpay_paymethod_" + orderpayInfo.getPaymethod());				orderpayInfo.setPaymethod(paymethod);			}		}		// 加载订单配送记录		e.setOrdership(ordershipService.selectOne(new Ordership(e.getId())));		// 加载订单项列表 以及 产品信息		Orderdetail orderdetail = new Orderdetail();		orderdetail.setOrderID(Integer.valueOf(e.getId()));		List<Orderdetail> orderdetailList = orderdetailService.selectList(orderdetail);		if (orderdetailList == null || orderdetailList.size() == 0) {			throw new NullPointerException("订单数据异常，订单未包含任何订单项数据！");		}		for(Orderdetail detail : orderdetailList){			Product product = productService.selectById(detail.getProductID() + "");			detail.setProduct(product);		}		e.setOrderdetail(orderdetailList);		// 检查此订单是否含赠品		for (int i = 0; i < e.getOrderdetail().size(); i++) {			Orderdetail item = e.getOrderdetail().get(i);			if (StringUtils.isNotBlank(item.getGiftID())) {				e.setHasGift(true);				break;			}		}		// 加载订单支付日志记录		if (StringUtils.isNotBlank(e.getId())) {			e.setOrderlogs(orderlogService.selectList(new Orderlog(e.getId())));			if (e.getOrderlogs() == null) {				e.setOrderlogs(Collections.EMPTY_LIST);			}			logger.error(">>>orderlogs.size=" + e.getOrderlogs().size());		}		model.addAttribute("e", e);		BuildOrderXML.buildOrderMessage(e);		return page_toEdit;	}	/**	 * 生成跨境通xml文件	 */	@RequestMapping("toCustomsDeclare")	public String toCustomsDeclare(OrderCustomsDeclare e, ModelMap model) throws Exception {		Order ordere = new Order();		ordere.setId(e.getRequest_id());		ordere = orderService.selectOne(ordere);		Map<String,String> parameters = new HashMap<String,String>();		parameters.put("sign_type",  e.getSign_type()); //固定；0代表MD5		parameters.put("service_version", e.getService_version());//固定 1.0		parameters.put("input_charset", e.getInput_charset());		parameters.put("request_id", e.getRequest_id()); //请求流水		parameters.put("mcht_id", e.getMcht_id()); //商户在开联通申请开户的商户号		parameters.put("mcht_customs_code", e.getMcht_customs_code());//商户在海关备案的编号		parameters.put("mcht_customs_name",e.getMcht_customs_name()); //商户海关备案名称		parameters.put("openepay_no",e.getOpenepay_no());//开联通系统支付流水号//		parameters.put("sub_order_no",no);//商户报关商品订单号//		parameters.put("sub_order_time",dateTime);		parameters.put("currency", e.getCurrency()); //币种,暂只支持156(人民币)		parameters.put("amount", e.getAmount()); //订单金额，以分为单位，不拆单时为原订单金额，拆单时为子订单金额且不能超过原订单金额order_fee=transport_fee+product_fee+tax_fee//        parameters.put("transport_amt",orderpay.get); //物流费用，以分为单位，不拆单时为原订单物流费用，拆单时为子订单订单物流费用//        parameters.put("product_amt", "9000");//商品费用，以分为单位，不拆单时为原订单商品费用，拆单时为子订单订单商品费用//        parameters.put("tax_amt", "0");//关税，以分为单位//        parameters.put("insured_amt", "0");//保险费，以分为单位		parameters.put("customs_type", e.getCustoms_type());//海关		parameters.put("id_type", e.getId_type()); //证件类型,暂只支持01身份证		parameters.put("id_no", e.getId_no()); //证件号		parameters.put("id_name", e.getId_name()); //姓名//        parameters.put("business_type", "I10"); //业务类型,I20:保税进口 ,I10：直邮进口 如果不填，默认为I20, 保税进口//        parameters.put("notify_url", receiveUrl);//        parameters.put("is_split", "Y");		WithholdingOrder order = new WithholdingOrder();		Map<String,String> receive = null;		String retmsg = "";		try{			order.sign(parameters, OpeneConfig.CustomsDeclareKey);			receive = order.sendData(parameters, OpeneConfig.payUrl,OpeneConfig.CustomsDeclareKey);			String retcode = receive.get("retcode");			retmsg=receive.get("retmsg");			logger.info("return code：" + retcode + ",retmsg：" + retmsg);		}catch(Exception e1){			logger.error(e1.getMessage(),e1);			retmsg = "&#x62A5;&#x5173;&#x5F02;&#x5E38;";//报关异常		}		model.addAttribute("e", e);		model.addAttribute("retmsg", retmsg);		return page_toCustomsDeclare;	}	/**	 * 后台添加订单支付记录	 * 	 * @return	 * @throws Exception	 */	@RequestMapping(value = "insertOrderpay", method = RequestMethod.POST)	public String insertOrderpay(ModelMap model, Order e) throws Exception {		logger.error(">>>addOrderpay...orderid=" + e.getId());		if (StringUtils.isBlank(e.getId())) {			throw new NullPointerException(ManageContainer.OrderAction_param_null);		}		checkStatus1(e);		e.getOrderpay().setOrderid(e.getId());// 订单ID		e.getOrderpay().setTradeNo("tradeNoTest");		e.getOrderpay().setPaystatus(Orderpay.orderpay_paystatus_y);// 假设支付成功		orderpayService.insert(e.getOrderpay());		RequestHolder.getRequest().getSession().setAttribute("optionMsg", "添加支付记录成功！");		insertOrderlog(e.getId(), "【增加支付记录】增" + e.getOrderpay().getPayamount() + "￥;");		Order oInfo = new Order();		oInfo.setId(e.getId());		oInfo.setPaystatus(Order.order_paystatus_y);// 全额支付		orderService.update(oInfo);		// toEdit2();		return "forward:toEdit?id=" + e.getId();	}	/**	 * 设置订单为审核通过	 * 	 * @return	 * @throws IOException	 */	@RequestMapping(value = "updateOrderStatus", method = RequestMethod.GET)	public String updateOrderStatus(ModelMap model, Order e) throws IOException {		logger.info("updateOrderStatus id = " + e.getId() + ",status=" + e.getStatus());		if (StringUtils.isBlank(e.getId()) || StringUtils.isBlank(e.getStatus())) {			throw new NullPointerException(ManageContainer.OrderAction_param_null);		}		Order orderInfo = orderService.selectById(e.getId());		if (orderInfo == null) {			throw new UpdateOrderStatusException(ManageContainer.OrderAction_selectById_null);		}		/**		 * 订单流程控制		 */		if (orderInfo.getStatus().equals(Order.order_status_cancel)) {// 已取消的订单不能再进行任何操作了			throw new NullPointerException(ManageContainer.OrderAction_updateOrderStatus_alreadyCancel);		} else {			/*			 * 未被取消的订单的状态只能往前推进，不可后撤。			 */			if (e.getStatus().equals(Order.order_status_cancel)) {				if (!(orderInfo.getStatus().equals(Order.order_status_init)						|| orderInfo.getStatus().equals(Order.order_status_pass))) {					throw new NullPointerException(ManageContainer.OrderAction_updatePayMonery_cancel);				}			} else if (orderInfo.getStatus().equals(Order.order_status_init)) {				if (!e.getStatus().equals(Order.order_status_pass)) {					throw new RuntimeException(ManageContainer.OrderAction_updateOrderStatus_statusException);				}			} else if (orderInfo.getStatus().equals(Order.order_status_pass)) {				if (!e.getStatus().equals(Order.order_status_send)) {					throw new RuntimeException(ManageContainer.OrderAction_updateOrderStatus_statusException);				}			} else if (orderInfo.getStatus().equals(Order.order_status_send)) {				if (!e.getStatus().equals(Order.order_status_sign)) {					throw new RuntimeException(ManageContainer.OrderAction_updateOrderStatus_statusException);				}			} else if (orderInfo.getStatus().equals(Order.order_status_sign)) {				if (!e.getStatus().equals(Order.order_status_file)) {					throw new RuntimeException(ManageContainer.OrderAction_updateOrderStatus_statusException);				}			}		}		if (e.getStatus().equals(Order.order_status_send)) {			// if(orderInfo.getStatus().equals(Order.order_status_pass)){			// //非法请求			// throw new			// NullPointerException(ManageContainer.RoleAction_update_error);			// }			// 检查此订单是否【已发货】。如果已经发货，则直接跳转到订单明细接口。			if (StringUtils.isNotBlank(orderInfo.getExpressNo())) {				// toEdit2();				return "forward:toEdit?id=" + e.getId();			}			/**			 * 转到发货页面			 */			Orderpay orderpay = new Orderpay();			orderpay.setOrderid(e.getId());			orderpay.setPaystatus(Orderpay.orderpay_paystatus_y);			orderpay = orderpayService.selectOne(orderpay);			// 检查订单是否已经支付成功			if (orderpay == null || StringUtils.isBlank(orderpay.getTradeNo())) {				// 非法请求				throw new NullPointerException(ManageContainer.RoleAction_update_error);			}			e.setTradeNo(orderpay.getTradeNo());			/*			 * 转到发货页面==》请求支付宝发货接口，如果成功支付宝会将此订单的状态设置为【已发货】			 * ***注意：如果是财付通或其他的支付接口，则需要调对应的发货接口才行。			 */			model.addAttribute("orderpay", orderpay);			return page_toSendProduct;		}		// 修改订单状态		Order order = new Order();		order.setStatus(e.getStatus());		order.setId(e.getId());		orderService.update(order);		// 记录日志		if (e.getStatus().equals(Order.order_status_pass)) {			insertOrderlog(e.getId(), "【审核通过】");		} else if (e.getStatus().equals(Order.order_status_send)) {			insertOrderlog(e.getId(), "【已发货】");		} else if (e.getStatus().equals(Order.order_status_sign)) {			insertOrderlog(e.getId(), "【已签收】");		} else if (e.getStatus().equals(Order.order_status_file)) {			insertOrderlog(e.getId(), "【已归档】");		} else if (e.getStatus().equals(Order.order_status_cancel)) {			insertOrderlog(e.getId(), "【取消订单】");		}		return "forward:toEdit?id=" + e.getId();	}	/**	 * 更新订单为发货状态	 * @return	 */	@RequestMapping(value = "doOrderSend", method = RequestMethod.POST)	@ResponseBody	public String doOrderSend(String orderId, String expressNo,							  String expressCompanyName) {		Order order = new Order();		order.setId(orderId);		order.setStatus("send");		order.setExpressNo(expressNo);		order.setExpressCompanyName(expressCompanyName);		orderService.update(order);		return "{\"success\":1}";	}	/**	 * 插入订单操作日志	 * 	 * @param orderid	 *            订单ID	 * @param content	 *            日志内容	 */	private void insertOrderlog(String orderid, String content) {		User user = LoginUserHolder.getLoginUser();		Orderlog orderlog = new Orderlog();		orderlog.setOrderid(orderid);// 订单ID		orderlog.setAccount(user.getUsername());// 操作人账号		orderlog.setContent(content);// 日志内容		orderlog.setAccountType(Orderlog.orderlog_accountType_m);		orderlogService.insert(orderlog);	}	/**	 * 设置订单为取消	 * 	 * @return	 * @throws IOException	 */	// public String cancel() throws IOException{	// if(StringUtils.isBlank(e.getId())){	// throw new NullPointerException();	// }	//	// Order order = new Order();	// order.setStatus(Order.order_status_cancel);	// order.setId(e.getId());	// orderService.update(order);	//	// insertOrderlog(e.getId(),"【取消订单】");	//	// toEdit2();	// return null;	// }	/**	 * 设置订单为已发货	 * 	 * @return	 * @throws IOException	 */	// public String setSend() throws IOException{	// if(StringUtils.isBlank(e.getId())){	// throw new NullPointerException();	// }	//	// Order order = new Order();	// order.setStatus(Order.order_status_send);	// order.setId(e.getId());	// orderService.update(order);	//	// insertOrderlog(e.getId(),"【已发货】");	//	// toEdit2();	// return null;	// }	/**	 * 设置订单为已签收	 * 	 * @return	 * @throws IOException	 */	// public String setSign() throws IOException{	// if(StringUtils.isBlank(e.getId())){	// throw new NullPointerException();	// }	//	// Order order = new Order();	// order.setStatus(Order.order_status_sign);	// order.setId(e.getId());	// orderService.update(order);	//	// insertOrderlog(e.getId(),"【已签收】");	//	// toEdit2();	// return null;	// }	/**	 * 设置订单为已归档	 * 	 * @return	 * @throws IOException	 */	// public String setFile() throws IOException{	// if(StringUtils.isBlank(e.getId())){	// throw new NullPointerException();	// }	//	// Order order = new Order();	// order.setStatus(Order.order_status_file);	// order.setId(e.getId());	// orderService.update(order);	//	// insertOrderlog(e.getId(),"【已归档】");	//	// toEdit2();	// return null;	// }	/**	 * 修改订单的各种状态	 * 	 * @return	 * @throws Exception	 */	// @Deprecated	// public String changeOrderStatus() throws Exception {	// logger.error(">>>changeOrderStatus...");	//// String aaa = getRequest().getParameter("aaa");	//// log.error(">>>changeOrderStatus...aaa="+this.aaa);	// return null;	// }	/**	 * 后台修改订单总金额	 * 	 * @return	 * @throws Exception	 */	@RequestMapping(value = "updatePayMonery", method = RequestMethod.POST)	public String updatePayMonery(ModelMap model, Order e) throws Exception {		checkStatus1(e);		logger.error("updatePayMonery = id = " + e.getId() + ",amount = " + e.getAmount());		User user = LoginUserHolder.getLoginUser();		orderService.updatePayMonery(e, user.getUsername());		return "forward:toEdit?id=" + e.getId();	}	/**	 * 后台编辑订单页面，添加支付记录、修改订单总金额 操作之前需要进行如下的判断，这2个按钮的操作必须是订单为未审核 且 订单未支付	 * 才可以，否则抛出异常。	 */	private void checkStatus1(Order e) {		Order orderInfo = orderService.selectById(e.getId());		if (orderInfo == null) {			throw new NullPointerException(ManageContainer.OrderAction_selectById_null);		}		/**		 * 订单流程控制		 */		if (!orderInfo.getStatus().equals(Order.order_status_init)) {			throw new UpdateOrderStatusException(ManageContainer.OrderAction_updatePayMonery_update);		}		if (!orderInfo.getPaystatus().equals(Order.order_paystatus_n)) {			throw new UpdateOrderStatusException("未支付的订单才支持此操作！");		}	}	/**	 * 查询订单的配送地址信息-->然后后台工作人员可以进行修改	 * 	 * @return	 */	@RequestMapping(value = "selectOrdership")	public String selectOrdership(ModelMap model, Order e) {		String orderid = RequestHolder.getRequest().getParameter("orderid");		if (StringUtils.isBlank(orderid)) {			throw new NullPointerException("非法请求！");		}		Ordership ordership = new Ordership();		ordership.setOrderid(orderid);		ordership = ordershipService.selectOne(ordership);		if (ordership == null) {			throw new NullPointerException("根据订单ID查询不到该订单的配送信息！");		}		e.setOrdership(ordership);		// 获取区域列表		Map<String, Area> areaMap = SystemManager.getInstance().getAreaMap();		model.addAttribute("provinces", areaMap.values());		if (StringUtils.isNotBlank(ordership.getProvinceCode()) && areaMap.get(ordership.getProvinceCode()) != null) {			Area city = areaMap.get(ordership.getProvinceCode());			model.addAttribute("cities", areaMap.get(ordership.getProvinceCode()).getChildren());			if (city != null && city.getChildren() != null && city.getChildren().size() > 0) {				for (int i = 0; i < city.getChildren().size(); i++) {					Area item = city.getChildren().get(i);					if (item.getCode().equals(ordership.getCityCode())) {						if (item.getChildren() != null && item.getChildren().size() > 0) {							model.addAttribute("areas", item.getChildren());						}					}				}			}		} else {			model.addAttribute("cities", new ArrayList<Area>());		}		model.addAttribute("e", e);		return page_updateOrdership;	}	/**	 * 修改订单配送地址信息	 * 	 * @return	 * @throws IOException	 */	@RequestMapping(value = "updateOrdership", method = RequestMethod.POST)	public String updateOrdership(ModelMap model, Order e) throws IOException {		logger.error("updateOrdership...");		if (StringUtils.isBlank(e.getOrdership().getShipname())) {			throw new NullPointerException("收货人不能为空！");		} else if (StringUtils.isBlank(e.getOrdership().getShipaddress())) {			throw new NullPointerException("收货人街道地址不能为空！");		} else if (StringUtils.isBlank(e.getOrdership().getTel())) {			throw new NullPointerException("收货人手机号码！");		} else if (StringUtils.isBlank(e.getOrdership().getProvince())) {			throw new NullPointerException("省份人不能为空！");		} else if (StringUtils.isBlank(e.getOrdership().getCity())) {			throw new NullPointerException("城市人不能为空！");		}		if (StringUtils.isBlank(e.getId())) {			throw new NullPointerException(ManageContainer.OrderAction_param_null);		}		Order order = orderService.selectById(e.getId());		if (order == null) {			throw new NullPointerException("查询不到订单信息!");		}		if (!order.getStatus().equals(Order.order_status_init)) {			throw new RuntimeException("只有【未审核】的订单才能修改收货人配送地址信息!");		}		ordershipService.update(e.getOrdership());		return "forward:toEdit?id=" + e.getId();	}	/**	 * 根据省份编码获取城市列表	 * 	 * @return	 * @throws IOException	 */	@RequestMapping(value = "selectCitysByProvinceCode")	@ResponseBody	public String selectCitysByProvinceCode() throws IOException {		logger.error("selectCitysByProvinceCode...");		String provinceCode = RequestHolder.getRequest().getParameter("provinceCode");		logger.error("selectCitysByProvinceCode...provinceCode=" + provinceCode);		if (StringUtils.isBlank(provinceCode)) {			throw new NullPointerException("provinceCode is null");		}		// Area area = new Area();		// area.setCode(provinceCode);		Map<String, Area> areaMap = SystemManager.getInstance().getAreaMap();		if (areaMap != null && areaMap.size() > 0) {			net.jeeshop.services.front.area.bean.Area areaInfo = areaMap.get(provinceCode);			logger.error("areaInfo = " + areaInfo);			if (areaInfo != null && areaInfo.getChildren() != null && areaInfo.getChildren().size() > 0) {				String jsonStr = JSON.toJSONString(areaInfo.getChildren());				logger.error("jsonStr=" + jsonStr);				return (jsonStr);			}		}		return "{}";	}	/**	 * 根据城市编码获取区域列表	 * 	 * @return	 * @throws IOException	 */	@RequestMapping(value = "selectAreaListByCityCode")	@ResponseBody	public String selectAreaListByCityCode() throws IOException {		logger.error("selectAreaListByCityCode...");		String provinceCode = RequestHolder.getRequest().getParameter("provinceCode");		String cityCode = RequestHolder.getRequest().getParameter("cityCode");		logger.error("selectAreaListByCityCode...provinceCode=" + provinceCode + ",cityCode=" + cityCode);		if (StringUtils.isBlank(provinceCode) || StringUtils.isBlank(cityCode)) {			throw new NullPointerException("provinceCode or cityCode is null");		}		Map<String, Area> areaMap = SystemManager.getInstance().getAreaMap();		if (areaMap != null && areaMap.size() > 0) {			net.jeeshop.services.front.area.bean.Area city = areaMap.get(provinceCode);			logger.error("areaInfo = " + city);			if (city != null && city.getChildren() != null && city.getChildren().size() > 0) {				for (int i = 0; i < city.getChildren().size(); i++) {					net.jeeshop.services.front.area.bean.Area item = city.getChildren().get(i);					if (item.getCode().equals(cityCode)) {						if (item.getChildren() != null && item.getChildren().size() > 0) {							String jsonStr = JSON.toJSONString(item.getChildren());							logger.error("jsonStr=" + jsonStr);							return (jsonStr);						}					}				}			}		}		return "{}";	}	@RequestMapping("toCEB311Generate")	public String toCEB311Generate(Order e, ModelMap model) throws Exception {		if (StringUtils.isBlank(e.getId())) {			throw new NullPointerException("订单ID不能为空！");		}		// 加载指定的订单信息		e = orderService.selectById(e.getId());		// 加载收货人地址信息		Ordership ordership = new Ordership();		ordership.setOrderid(e.getId());		ordership = ordershipService.selectOne(ordership);		if (ordership == null) {			throw new NullPointerException("系统查询不到收货人地址信息！");		}		e.setOrdership(ordership);		// 加载订单项列表 以及 产品信息		Orderdetail orderdetail = new Orderdetail();		orderdetail.setOrderID(Integer.valueOf(e.getId()));		List<Orderdetail> orderdetailList = orderdetailService.selectList(orderdetail);		if (orderdetailList == null) {			throw new NullPointerException("查询不到订单明细信息！");		}		for(Orderdetail detail : orderdetailList){			Product product = productService.selectById(detail.getProductID() + "");			detail.setProduct(product);		}		e.setOrderdetail(orderdetailList);		model.addAttribute("e", e);		SystemSetting systemSetting = SystemManager.getInstance().getSystemSetting();		model.addAttribute("ss", systemSetting);		model.addAttribute("uid", getUid());		return page_toCeb311Generate;	}	private String getUid(){		//用字符数组的方式随机		String uid = "";		String model = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";		char[] m = model.toCharArray();		for (int j = 0;j < 36 ;j++ )		{			char c = m[(int)(Math.random()*26)];			uid = uid + c;		}		return uid;	}	@RequestMapping("toCEB621Generate")	public String toCEB621Generate(Order e, ModelMap model) throws Exception {		if (StringUtils.isBlank(e.getId())) {			throw new NullPointerException("订单ID不能为空！");		}		// 加载指定的订单信息		e = orderService.selectById(e.getId());		// 加载收货人地址信息		Ordership ordership = new Ordership();		ordership.setOrderid(e.getId());		ordership = ordershipService.selectOne(ordership);		if (ordership == null) {			throw new NullPointerException("系统查询不到收货人地址信息！");		}		e.setOrdership(ordership);		// 加载订单项列表 以及 产品信息		Orderdetail orderdetail = new Orderdetail();		orderdetail.setOrderID(Integer.valueOf(e.getId()));		List<Orderdetail> orderdetailList = orderdetailService.selectList(orderdetail);		if (orderdetailList == null) {			throw new NullPointerException("查询不到订单明细信息！");		}		for(Orderdetail detail : orderdetailList){			Product product = productService.selectById(detail.getProductID() + "");			detail.setProduct(product);		}		e.setOrderdetail(orderdetailList);		model.addAttribute("e", e);		SystemSetting systemSetting = SystemManager.getInstance().getSystemSetting();		model.addAttribute("ss", systemSetting);		model.addAttribute("uid", getUid());		return page_toCeb621Generate;	}	@RequestMapping("toCEB623Generate")	public String toCEB623Generate(Order e, ModelMap model) throws Exception {		if (StringUtils.isBlank(e.getId())) {			throw new NullPointerException("订单ID不能为空！");		}		// 加载指定的订单信息		e = orderService.selectById(e.getId());		// 加载收货人地址信息		Ordership ordership = new Ordership();		ordership.setOrderid(e.getId());		ordership = ordershipService.selectOne(ordership);		if (ordership == null) {			throw new NullPointerException("系统查询不到收货人地址信息！");		}		e.setOrdership(ordership);		// 加载订单项列表 以及 产品信息		Orderdetail orderdetail = new Orderdetail();		orderdetail.setOrderID(Integer.valueOf(e.getId()));		List<Orderdetail> orderdetailList = orderdetailService.selectList(orderdetail);		if (orderdetailList == null) {			throw new NullPointerException("查询不到订单明细信息！");		}		for(Orderdetail detail : orderdetailList){			Product product = productService.selectById(detail.getProductID() + "");			detail.setProduct(product);		}		e.setOrderdetail(orderdetailList);		model.addAttribute("e", e);		SystemSetting systemSetting = SystemManager.getInstance().getSystemSetting();		model.addAttribute("ss", systemSetting);		model.addAttribute("uid", getUid());		return page_toCeb623Generate;	}}