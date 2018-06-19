/**
 * Created by Administrator on 2016/11/3 0003.
 */
// 基于准备好的dom，初始化echarts实例
function tabUser(history,day) {
    var myChart = echarts.init(document.getElementById('main_user'));

// 指定图表的配置项和数据
    var option = {
        title: {
            show:true,
            subtextStyle:{
                color:"#4c4c4c"
            },
            left:"50%",
            top:"-9%"
        },
        tooltip : {
            axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                type : 'shadow'        // 默认为直线，可选为'line' | 'shadow'
            }
        },
        legend: {
            data:['本月',"今天"],
            top: '0%',
            left:"20px",
            selectedMode:false,
        },
        toolbox:{

        },
        grid: {
            left: '3%',
            right: '4%',
            top: '16%',
            bottom:'18%',
            containLabel: true
        },
        xAxis: {
            data: ["注册用户数","登录用户数","绑定卡数","解绑卡数"],
            splitLine: {show: false,//X中间轴线
                lineStyle:{
                    color:"#333"
                }
            },
            axisLine:{
                show:true,
                lineStyle:{
                    color:'#ccc',//X轴底部线条颜色
                    borderColor:"#666",
                    width: 1,
                }
            },
            axisLabel:{//底部文字颜色
                show:true,
                textStyle:{
                    color:'#333',
                },
                lineStyle:{
                    color:'#333',
                    borderColor:"#666",
                    width: 1,
                }
            },
            axisTick:{
                show:false,
            }
        },
        yAxis: [
            {
                type : 'value',
                splitLine: {show: false,//中间部分轴线
                    lineStyle:{
                        color:"#E1E1E1"
                    }
                },
                axisLine:{
                    show:false,
                    lineStyle:{
                        color:'#333',
                        width: 1,

                    }
                },
                axisLabel:{
                    show:false,//Y轴数字值显示
                    textStyle:{
                        color:'#333',
                        borderColor:"#999"
                    }
                },
                axisTick:{show:false}//树杈显示
            }
        ],
        series: [
            {
                name: '本月',
                type: 'bar',
                data: history == ""?"":JSON.parse(history),
                itemStyle: {        // 系列级个性化样式，纵向渐变填�?
                    normal: {
                        color: "#488abd",
                        label: {
                            show: true ,
                            position: 'top',
                            normal: {
                                textStyle : {
                                    fontSize : '20',
                                    color:"#333",
                                    fontWeight : 'bold'
                                }
                            }
                        }
                    }
                },
                barWidth:20
            },
            {
                name: '今天',
                type: 'bar',
                data: day == ""?"":JSON.parse(day),
                itemStyle: {        // 系列级个性化样式，纵向渐变填�?
                    normal: {
                        color: "#48b2bd",
                        label: {
                            show: true ,
                            position: 'top',
                            normal: {
                                textStyle : {
                                    fontSize : '20',
                                    color:"#333",
                                    fontWeight : 'bold'
                                }
                            }
                        }
                    }
                },
                barWidth: 20
            }
        ]
    };

// 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);
}

function tabMesg(history,day) {
    var myChart = echarts.init(document.getElementById('main_mesg'));
    
// 指定图表的配置项和数据
    var option = {
        title: {
            show:true,
            subtextStyle:{
                color:"#4c4c4c"
            },
            left:"50%",
            top:"-9%"
        },
        tooltip : {
            axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                type : 'shadow'        // 默认为直线，可选为�?line' | 'shadow'
            }
        },
        legend: {
            data:['历史',"今天"],
            top: '0%',
            left:"20px",
            selectedMode:false,
        },
        toolbox:{

        },
        grid: {
            left: '3%',
            right: '4%',
            top: '16%',
            bottom:'18%',
            containLabel: true
        },
        xAxis: {
            data: ["推送数量","点击数量"],
            splitLine: {show: false,//X中间轴线
                lineStyle:{
                    color:"#333"
                }
            },
            axisLine:{
                show:true,
                lineStyle:{
                    color:'#ccc',//X轴底部线条颜色
                    borderColor:"#666",
                    width: 1,
                }
            },
            axisLabel:{//底部文字颜色
                show:true,
                textStyle:{
                    color:'#333',
                },
                lineStyle:{
                    color:'#333',
                    borderColor:"#666",
                    width: 1,
                }
            },
            axisTick:{
                show:false,
            }
        },
        yAxis: [
            {
                type : 'value',
                splitLine: {show: false,//中间部分轴线
                    lineStyle:{
                        color:"#E1E1E1"
                    }
                },
                axisLine:{
                    show:false,
                    lineStyle:{
                        color:'#333',
                        width: 1,

                    }
                },
                axisLabel:{
                    show:false,//Y轴数字值显示
                    textStyle:{
                        color:'#333',
                        borderColor:"#999"
                    }
                },
                axisTick:{show:false}//树杈显示
            }
        ],
        series: [
            {
                name: '历史',
                type: 'bar',
                data:history == ""?"":JSON.parse(history),
                itemStyle: {        // 系列级个性化样式，纵向渐变填�?
                    normal: {
                        color: "#488abd",
                        label: {
                            show: true ,
                            position: 'top',
                            normal: {
                                textStyle : {
                                    fontSize : '20',
                                    color:"#333",
                                    fontWeight : 'bold'
                                }
                            }
                        }
                    }
                },
                barWidth:20
            },
            {
                name: '今天',
                type: 'bar',
                data: day == ""?"":JSON.parse(day),
                itemStyle: {        // 系列级个性化样式，纵向渐变填�?
                    normal: {
                        color: "#48b2bd",
                        label: {
                            show: true ,
                            position: 'top',
                            normal: {
                                textStyle : {
                                    fontSize : '20',
                                    color:"#333",
                                    fontWeight : 'bold'
                                }
                            }
                        }
                    }
                },
                barWidth: 20
            }
        ]
    };

// 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);
}

function tabOrder(history,day) {
    var myChart = echarts.init(document.getElementById('main_all'));

// 指定图表的配置项和数据
    var option = {
        title: {
            show:true,
            subtextStyle:{
                color:"#4c4c4c"
            },
            left:"50%",
            top:"-9%"
        },
        tooltip : {
            axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                type : 'shadow'        // 默认为直线，可选为�?line' | 'shadow'
            }
        },
        legend: {
            data:['历史',"今天"],
            top: '0%',
            left:"20px"
        },
        toolbox:{

        },
        grid: {
            left: '3%',
            right: '4%',
            top: '16%',
            bottom:'18%',
            containLabel: true
        },
        xAxis: {
            data: ["创建订单","支付订单"],
            splitLine: {show: false,//X中间轴线
                lineStyle:{
                    color:"#333"
                }
            },
            axisLine:{
                show:true,
                lineStyle:{
                    color:'#ccc',//X轴底部线条颜色
                    borderColor:"#666",
                    width: 1,
                }
            },
            axisLabel:{//底部文字颜色
                show:true,
                textStyle:{
                    color:'#333',
                },
                lineStyle:{
                    color:'#333',
                    borderColor:"#666",
                    width: 1,
                }
            },
            axisTick:{
                show:false,
            }
        },
        yAxis: [
            {
                type : 'value',
                splitLine: {show: false,//中间部分轴线
                    lineStyle:{
                        color:"#E1E1E1"
                    }
                },
                axisLine:{
                    show:false,
                    lineStyle:{
                        color:'#333',
                        width: 1,

                    }
                },
                axisLabel:{
                    show:false,//Y轴数字值显示
                    textStyle:{
                        color:'#333',
                        borderColor:"#999"
                    }
                },
                axisTick:{show:false}//树杈显示
            }
        ],
        series: [
            {
                name: '历史',
                type: 'bar',
                data: history == ""?"":JSON.parse(history),
                itemStyle: {        // 系列级个性化样式，纵向渐变填�?
                    normal: {
                        color: "#ccc",
                        label: {
                            show: true ,
                            position: 'top',
                            normal: {
                                textStyle : {
                                    fontSize : '20',
                                    color:"#333",
                                    fontWeight : 'bold'
                                }
                            }
                        }
                    }
                },
                barWidth:20
            },
            {
                name: '今天',
                type: 'bar',
                data: day == ""?"":JSON.parse(day),
                itemStyle: {        // 系列级个性化样式，纵向渐变填�?
                    normal: {
                        color: "#48b2bd",
                        label: {
                            show: true ,
                            position: 'top',
                            normal: {
                                textStyle : {
                                    fontSize : '20',
                                    color:"#333",
                                    fontWeight : 'bold'
                                }
                            }
                        }
                    }
                },
                barWidth: 20
            }
        ]
    };

// 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);
}
