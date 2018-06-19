package com.huagu.common.util;

public class LocationUtils {
    
    private static double EARTH_RADIUS = 6378.137;  
    
    private static double rad(double d) {  
        return d * Math.PI / 180.0;  
    }  
  
    /** 
     * 逻辑距离
     * 通过经纬度获取距离(单位：米) 
     * @param lat1 
     * @param lng1 
     * @param lat2 
     * @param lng2 
     * @return 
     */  
    public static double getDistance(double lat1, double lng1, double lat2,  
                                     double lng2) {  
        double radLat1 = rad(lat1);  
        double radLat2 = rad(lat2);  
        double a = radLat1 - radLat2;  
        double b = rad(lng1) - rad(lng2);  
        double s = 2 * Math.asin(Math.sqrt(Math.pow(Math.sin(a / 2), 2)  
                + Math.cos(radLat1) * Math.cos(radLat2)  
                * Math.pow(Math.sin(b / 2), 2)));  
        s = s * EARTH_RADIUS;  
        s = Math.round(s * 10000d) / 10000d;  
        s = s*1000;  
        return s;  
    }
    
    public static void main(String[] args) {
        /*System.out.println(getDistance(113.873096, 22.580616, 113.875546, 22.581430)); 
        Distribution start = new Distribution();
        start.setLongitude(113.873096);
        start.setDimensionality(22.580616);
        Distribution end = new Distribution();
        end.setLongitude(113.875546);
        end.setDimensionality(22.581430);
        System.out.println(new Distribution().getDistance(start, end));*/
        
        int i = 0;
        if (++i >= 1 | ++i >=2) {
            // || 如果前面成立，第二个条件不会执行
            // | 如果前面成立，第二个条件也会执行
            System.out.println(i);
        }
        
        System.out.println(Double.parseDouble(""));
    }

}
