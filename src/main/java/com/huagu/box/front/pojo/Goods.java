package com.huagu.box.front.pojo;

public class Goods implements java.io.Serializable {

    private static final long serialVersionUID = 1L;
    
    private String num;
    private String proId;
    private String imageUrl;
    private String name;
    private String money;
	private String discountPrice;
    private String pledge;
    private String zhuCode;
    public String getZhuCode() {
		return zhuCode;
	}
	public void setZhuCode(String zhuCode) {
		this.zhuCode = zhuCode;
	}
	public String getNum() {
        return num;
    }
    public void setNum(String num) {
        this.num = num;
    }
    public String getProId() {
		return proId;
	}
	public void setProId(String proId) {
		this.proId = proId;
	}
	public String getImageUrl() {
        return imageUrl;
    }
    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getMoney() {
        return money;
    }
    public void setMoney(String money) {
        this.money = money;
    }
    public String getPledge() {
        return pledge;
    }
    public void setPledge(String pledge) {
        this.pledge = pledge;
    }
    public String getDiscountPrice() {
 		return discountPrice;
 	}
 	public void setDiscountPrice(String discountPrice) {
 		this.discountPrice = discountPrice;
 	}
    
  /*  @Override
    public String toString() {
        return "Goods [num=" + num + ", imageUrl=" + imageUrl + ", name="
                + name + ", money=" + money + ", pledge=" + pledge + "]";
    }*/
	@Override
	public String toString() {
		return "Goods [num=" + num + ", proId=" + proId + ", imageUrl=" + imageUrl + ", name=" + name + ", money="
				+ money + ", discountPrice=" + discountPrice + ",+  pledge=" + pledge + ", zhuCode=" + zhuCode + "]";
	}
    
}
