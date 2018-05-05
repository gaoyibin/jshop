package net.jeeshop.web.action.front.paygate;

/**
 * 支付宝的付款信息对象
 * 
 * @author huangf
 * 
 */
public class PayInfo {
	private String WIDseller_email;
	private String WIDout_trade_no;
	private String WIDsubject;
	private double WIDprice;
	private String WIDbody;
	// private String WIDshow_url;
	private String WIDreceive_name;
	private String WIDreceive_address;
	private String WIDreceive_zip;
	private String WIDreceive_phone;
	private String WIDreceive_mobile;
	private double logistics_fee;
	private String logistics_type;
	private String show_url;

	//富友支付时需要一下三个字段
	//名字
	private String ic_name;
	//身份证号
	private String ic_number;
	//电话
	private String payer_tel;


	public String getWIDseller_email() {
		return WIDseller_email;
	}

	public void setWIDseller_email(String wIDseller_email) {
		WIDseller_email = wIDseller_email;
	}

	public String getWIDout_trade_no() {
		return WIDout_trade_no;
	}

	public void setWIDout_trade_no(String wIDout_trade_no) {
		WIDout_trade_no = wIDout_trade_no;
	}

	public String getWIDsubject() {
		return WIDsubject;
	}

	public void setWIDsubject(String wIDsubject) {
		WIDsubject = wIDsubject;
	}

	public double getWIDprice() {
		return WIDprice;
	}

	public void setWIDprice(double wIDprice) {
		WIDprice = wIDprice;
	}

	public String getWIDbody() {
		return WIDbody;
	}

	public void setWIDbody(String wIDbody) {
		WIDbody = wIDbody;
	}

	public String getWIDreceive_name() {
		return WIDreceive_name;
	}

	public void setWIDreceive_name(String wIDreceive_name) {
		WIDreceive_name = wIDreceive_name;
	}

	public String getWIDreceive_address() {
		return WIDreceive_address;
	}

	public void setWIDreceive_address(String wIDreceive_address) {
		WIDreceive_address = wIDreceive_address;
	}

	public String getWIDreceive_zip() {
		return WIDreceive_zip;
	}

	public void setWIDreceive_zip(String wIDreceive_zip) {
		WIDreceive_zip = wIDreceive_zip;
	}

	public String getWIDreceive_phone() {
		return WIDreceive_phone;
	}

	public void setWIDreceive_phone(String wIDreceive_phone) {
		WIDreceive_phone = wIDreceive_phone;
	}

	public String getWIDreceive_mobile() {
		return WIDreceive_mobile;
	}

	public void setWIDreceive_mobile(String wIDreceive_mobile) {
		WIDreceive_mobile = wIDreceive_mobile;
	}

	public double getLogistics_fee() {
		return logistics_fee;
	}

	public void setLogistics_fee(double logistics_fee) {
		this.logistics_fee = logistics_fee;
	}

	public String getLogistics_type() {
		return logistics_type;
	}

	public void setLogistics_type(String logistics_type) {
		this.logistics_type = logistics_type;
	}

	public String getShow_url() {
		return show_url;
	}

	public void setShow_url(String show_url) {
		this.show_url = show_url;
	}

	public String getIc_name() {
		return ic_name;
	}

	public void setIc_name(String ic_name) {
		this.ic_name = ic_name;
	}

	public String getIc_number() {
		return ic_number;
	}

	public void setIc_number(String ic_number) {
		this.ic_number = ic_number;
	}

	public String getPayer_tel() {
		return payer_tel;
	}

	public void setPayer_tel(String payer_tel) {
		this.payer_tel = payer_tel;
	}

	@Override
	public String toString() {
		return "PayInfo [WIDseller_email=" + WIDseller_email
				+ ", WIDout_trade_no=" + WIDout_trade_no + ", WIDsubject="
				+ WIDsubject + ", WIDprice=" + WIDprice + ", WIDbody="
				+ WIDbody + ", WIDreceive_name=" + WIDreceive_name
				+ ", WIDreceive_address=" + WIDreceive_address
				+ ", WIDreceive_zip=" + WIDreceive_zip + ", WIDreceive_phone="
				+ WIDreceive_phone + ", WIDreceive_mobile=" + WIDreceive_mobile
				+ ", logistics_fee=" + logistics_fee + ", logistics_type="
				+ logistics_type + ", show_url=" + show_url + "]";
	}

}
