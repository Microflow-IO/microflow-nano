![logo](https://raw.githubusercontent.com/Microflow-IO/microflow.sentinel/main/github_microflow.png)

![functions](https://raw.githubusercontent.com/Microflow-IO/microflow.sentinel/main/microflow_function_B.png)

# Where Microflow Sentinel Shines

**Feather-weight Probe. Heavy-weight Security.**



In this document, we will briefly introduce the highlight applications of microflow Sentinel in the direction of cloud security, data security, observability/PM, and zero trust, which we believe will make your eyes shine.



## 📠 Attack Context in SOC/XDR/AISEC Cloud Environment

The context of the alarm is crucial for XDR/AISEC to detect risks. SOC's ability to analyze the effectiveness of the alarm is also seriously affected because it is difficult to have blind spots and intrusion free in the cloud environment, and low-cost access to the context communication content, especially the header and body;

How to obtain high-quality contextual content has become the key to the success or failure of projects such as XDR/AISEC/SOC in the cloud environment. This problem can be easily solved through the microflow.



## 🎃 Global Perspective East-West Lateral Attack Detection

How to effectively deal with the east-west horizontal attack in the cloud has always been a vague issue in the industry, lacking a recognized professional method;

The microflow and ModSecurity for microflow (docker) perfectly solve this problem, providing detailed attack context and alerts from ModSecurity;

More importantly, because of the distributed collection and centralized risk detection scheme, the global analysis capability of the internal horizontal risk of the cloud is truly realized. Obviously, its effect is better than that of a single-point cloud WAF.



## 🔍 Fine-grained Observability of Cloud/Native Traffic

Granular traffic data observability is the foundation of cloud security and monitoring. It not only assists us in detecting multiple security risks but also in swiftly implementing comprehensive performance monitoring solutions.

But let's consider this thoroughly. Is there a product that has achieved large-scale, production-level, granular cloud/native traffic observability? It can promptly alert us to anomalies in every communication and performance metric, drill down and pinpoint each interaction, even down to individual L7 sessions; or, perform statistical analysis of the TOP N IPs for each metric to identify potential risks and emerging trends in a timely manner?



## ⛳ Micro isolation based on application layer capability

Obviously, the micro isolation method based on the network layer has come to an end, and the micro isolation capability of the application layer is imperative. On the one hand, the user attributes carried by the application layer are more abundant, which is more conducive to the construction of a zero-trust system. On the other hand, the proportion of east-west attacks on the application layer is far more than that of network attacks, which is also more difficult to prevent,

The microflow is almost a one-step application layer micro isolation front-end. It not only has real-time parsing capabilities up to header/body, but also provides communication interception capabilities based on the host firewall.

We look forward to partners taking the lead in implementing micro isolation of the application layer based on microflow!



## 📊 Sensitive Data Behavior Monitoring in Cloud/Native

In traditional architectures, DLP effectively monitored sensitive data behaviors. However, in cloud and native environments, DLP has been replaced by DDR (Data Detection and Response) based on micro- technology.

By leveraging microflow s as the DDR frontend, organizations can achieve non-intrusive monitoring of specific business processes. This includes comprehensive data lineage tracking, from initial HTTP requests through API calls and SQL queries, even down to granular PCAP data for forensic analysis. This approach provides a one-stop solution that addresses the challenges of implementing effective DDR.



## 🛠 Hybrid Performance Management XPM

When using APM, you are worried about the impact on the business. When using NPM, you cannot effectively monitor the application layer;

Is there a way to monitor the application layer without affecting the business? Hybrid performance management - XPM, a solution that will not affect the business at all, but can also realize the whole stack performance monitoring;

Features: 100% no need to modify and restart the host and business; 100% real-time application performance anomaly warning capability; 100% records the content and performance of each access, call and query, and covers network delay and retransmission.

