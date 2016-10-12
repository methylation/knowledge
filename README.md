###GDC下载工具
####1. download.py
利用tsv文件从GDC Portal批量下载数据。

```
python download.py tsv_file outdir
```
tsv_file 从GDCd下载的tsv文件
outdir 输出文件夹，如果不存在将创建。
####2. parse_json.pl
将json文件转换成列表格式
```
perl parse_json.pl meta.json meta.txt
```

meta.json 从GDC下载的meta文件
meta.txt 输出文件名


####3. [GDC_TCGA数据下载说明](http://fromwiz.com/share/s/1-7RP62s-QrJ2Vbofn13TuxT2mbrss3fwAwJ2yYclx3aphjB)
