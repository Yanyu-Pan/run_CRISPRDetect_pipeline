#将公司返回来的序列统一改名，内部contig名统一改成其文件名_序号，如ST353_1，方便后续分析
for f in /media/epi-linux/8t/CRISPR/input/*.fasta; do b=`basename $f .fasta`; usearch11.0.667_i86linux32 -fastx_relabel $f -prefix ${b}_ -fastaout input/rename/${b}_rename.fasta; done
#合并所有输入序列，后续找crispr方便一条代码完成
cat input/rename/*.fasta > input/rename/merges.fasta
#移动至rename目录
cd input/rename/
#找crispr,虽然ecoli的repeat几乎都是29，但为了找全所以设置大了点，目前所有软件都找不全，后续还要再找剩下的crispr.
perl /home/epi-linux/CRISPRDetect_2.2/CRISPRDetect.pl -f /media/epi-linux/8t/CRISPR/input/rename/merges.fasta -o merges.crisprs -check_direction 1 -array_quality_score_cutoff 0 -left_flank_length 100 -right_flank_length 100
#crisprviz.sh -cx -b 25 -e 30 -f /media/epi-linux/8t/CRISPR/input/rename/merges.fasta -r 2
#移动回crispr目录
#cd ../../
#移动结果文件
cp /media/epi-linux/8t/CRISPR/input/rename/merges.crisprs /media/epi-linux/8t/CRISPR/output/
#利用awk数组的概念，panyanyu[$2]=$1是说关联列1和列2；后面打印panyanyu[$3]而不是$2，原理不清。(比对CRISPR1)(FNR是指当前文件中的记录号(通常是行号),NR表示总记录号.这意味着NR == FNR条件仅适用于第一个文件,因为每个文件的第一行FNR复位为1,但NR保持不断增加)
awk 'NR==FNR{panyanyu[$1]=$2;next}NR>FNR{if ($6 in panyanyu){print $0,panyanyu[$6]} else {print $0,"none"}}' /media/epi-linux/8t/CRISPR/CRISPR_db/spacerdb.txt /media/epi-linux/8t/CRISPR/output/merges.crisprs >/media/epi-linux/8t/CRISPR/output/compare_crispr1

#比对CRISPR2
awk 'NR==FNR{panyanyu[$3]=$4;next}NR>FNR{if ($6 in panyanyu){print $0 "\t" panyanyu[$6]} else {print $0 "\t" "none"}}' /media/epi-linux/8t/CRISPR/CRISPR_db/spacerdb.txt /media/epi-linux/8t/CRISPR/output/compare_crispr1 > /media/epi-linux/8t/CRISPR/output/output_compare_crispr
#处理中间文件
rm -r /media/epi-linux/8t/CRISPR/output/compare_crispr1
