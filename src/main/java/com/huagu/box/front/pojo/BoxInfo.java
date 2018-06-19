package com.huagu.box.front.pojo;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/*
 * 前台展示的柜组详情
 */
public class BoxInfo implements java.io.Serializable {
    
    private static final long serialVersionUID = 1L;
    
    private Set<String> images = new HashSet<String>(); // 轮播图片
    private String communityName;
    private String communityNum;
    private String address;
    private List<Goods> goods = new ArrayList<Goods>();
    public Set<String> getImages() {
        return images;
    }
    public void setImages(Set<String> images) {
        this.images = images;
    }
    public String getCommunityName() {
        return communityName;
    }
    public void setCommunityName(String communityName) {
        this.communityName = communityName;
    }
    public String getCommunityNum() {
        return communityNum;
    }
    public void setCommunityNum(String communityNum) {
        this.communityNum = communityNum;
    }
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }
    public List<Goods> getGoods() {
        return goods;
    }
    public void setGoods(List<Goods> goods) {
        this.goods = goods;
    }
    @Override
    public String toString() {
        return "BoxInfo [images=" + images + ", communityName=" + communityName
                + ", communityNum=" + communityNum + ", address=" + address
                + ", goods=" + goods + "]";
    }
    
}
