# run_CRISPRDetect_pipeline  
批量查找CRISPR，并与现有spacer数据库比对分配序号  
## Author  
Yanyu-Pan  
## 注意：仅做记录，仅适用本人linxu环境  
所需软件：    
[CRISPRDetect](https://github.com/ambarishbiswas/CRISPRDetect_2.2)  
[usearch](http://www.drive5.com/usearch/)  

方式：使用CRISPRDetect找出可能的CRISPR序列，然后将其结果文件与本地STEC CRISPR spacer数据库比较,最终生成含有spacer序列号的CRISPR结果文件，后续考虑添加           
           1.寻找最保守spacer功能       
           2.自动生成菌株名 + spacer号排列(简单)        
           3.自动更新本地CRISPR spacer数据库  
           

## usage  

```
# run
sh run_CRISPRDetect_popeline.sh
```
## Output
File | Description
----------|--------------
merges.cirsprs | 原始结果
output_compare_crispr | 匹配数据库后结果

效果：

![image](https://github.com/Yanyu-Pan/run_CRISPRDetect_pipeline/blob/master/example.png)


