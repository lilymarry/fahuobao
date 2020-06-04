//
//  PartnerConfig.h
//  AlipaySdkDemo
//
//  Created by ChaoGanYing on 13-5-3.
//  Copyright (c) 2013年 RenFei. All rights reserved.
//
//  提示：如何获取安全校验码和合作身份者id
//  1.用您的签约支付宝账号登录支付宝网站(www.alipay.com)
//  2.点击“商家服务”(https://b.alipay.com/order/myorder.htm)
//  3.点击“查询合作者身份(pid)”、“查询安全校验码(key)”
//

#ifndef MQPDemo_PartnerConfig_h
#define MQPDemo_PartnerConfig_h

//合作身份者id，以2088开头的16位纯数字
#define PartnerID @"2088511412949912"

//收款支付宝账号
#define SellerID  @"173393349@qq.com"

//安全校验码（MD5）密钥，以数字和字母组成的32位字符
#define MD5_KEY @"zong5qir65wzpzxfk6jor1lp3nu64d4t"

//商户私钥，自助生成
#define PartnerPrivKey @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMGmlI7VJP/70h5yWZFeLqfCU2vHTI2A5RgURFoOg5E9iyanpOE/pv4gm7DsPF4CrFJRbyhtH4hWdVALvrQYYdb795kqn8TcaazGLsdBYsXj1mhzf3Ae7sBwJeQoELgOwVGycfDd4bm9zhDZArrHad/87ZJSO57Kcd0G6Dx6lVLpAgMBAAECgYAwCiUccd/l6RCtIOz7VQP59gk/2YcyK2Gp4Y07UhJte3kDs98BSgshS/GTqGcpYzxgh3ct7jQ+XERqAR/kCZBrl7QqB/sIOVtxukIO6yhsHhMfvCJqKwEg5MrRfBNf7Jovq8K1/qm1yvjt50MhpGkdgemHq1yUNV7za6L58sSdCQJBAPbEkaBkQGEQn3JHx2JQLFvZNXTWI5OKT4AbJYmHjGgDr41b7U1XqCd0Tqp1cHf+7C+UKXvhuGHMx4oTrWpC0qsCQQDI5UeHoiW3OEBpqrR1vd2cB7BoiSQF8IUgGoSQqm0fu2SkNsUH7k0Yx6cIVemq/DIT2AvTq6EIQrCb4Bdt0FC7AkEA5Wfscg2BBDut31H3e+BIvMJ7PbjtrfXA3rld9jL7Rp9WjrXNMD+zZapsj29KNWPaMoks36wB+3mibyzH5KdmrQJAHVUk4Y/yU9M5zHPpT3u+fMa+ojTL9rYMqghVLM5FiqmQ400/7Y2E4kZchCIPMTELmswjxe88Xvll0gyhPx54ewJBAJQGpAY8aUnATEaenbYVqdtCDjf8Ttapox4DXKKuKxCRw6zsoHKTntPm1gjAqz0PZAzKVyQdXK/HEI3VfJYR1Mk="
//支付宝公钥
#define AlipayPubKey   @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB"

#endif
