package com.huagu.common.ui.columns;

import java.util.List;

import cn.cerc.jpage.core.Component;

public class LinksColumn extends AbstractColumn {
    
    public LinksColumn(Component owner, String title) {
        super(owner);
        this.setTitle(title);
    }

    @Override
    public String format(Object value) {
        StringBuffer buffer = new StringBuffer();
        buffer.append("<td>");
        List<Component> lcs = getComponents();
        for (Component c : lcs) {
            LinkColumn lc = (LinkColumn) c;
            String oneLc = lc.format(value);
            oneLc = oneLc.replace("<td>", "").replace("</td>", "");
            buffer.append(oneLc + "<br/>");
        }
        buffer.substring(0, buffer.length() - 5);
        buffer.append("</td>");
        return buffer.toString();
    }
    
    public static void main(String[] args) {
        String str = "<td><a class='button' href='#' style='width:50px;'>变更GPS位置信息</a></td>";
        System.out.println(str.replace("<td>", "").replace("</td>", ""));
    }
    
}
