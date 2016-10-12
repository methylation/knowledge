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
