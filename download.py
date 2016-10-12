#!/usr/bin/python
#encoding:utf-8
#this script download data from GDC Portal by using UUID and rename them.
#This script was inspired by [python download file - OPEN](http://www.open-open.com/lib/view/open1430982247726.html)

from sys import argv
import urllib
import os

if len(argv) < 2:
	print "This script download data from GDC Portal by using tsv file."
	print "Usage: python download.py tsv_file outdir"
	exit()

script, infile, outdir = argv

#outdir exists or not
if(not os.path.exists(outdir)):
	print outdir,"not exists, create"
	os.makedirs(outdir)

tsv = open(infile)
tsv.readline()

def Schedule(a,b,c):
	'''
	a:downloaded data
	b:size of downloaded data
	c:size of url file
	'''

	per = 100.0 * a * b / c
	if per > 100 :
		per = 100
	print '%.2f%%' % per

for line in tsv:
	arr = line.split('\t')
	UUID, filename = arr[0], arr[1]
	print filename, "is downloading..."
	url = os.path.join('https://gdc-api.nci.nih.gov/data/', UUID)
	local = os.path.join(outdir, filename)
	urllib.urlretrieve(url,local,Schedule)

