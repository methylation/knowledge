#!/usr/bin/perl
use warnings;
use strict;

die "
This script help you parse json file from GDC Portal.
Usgae:perl parse_json.pl meta.json meta.txt
" unless @ARGV;
my ($json_file, $outfile) =  @ARGV;

open IN,"<","$json_file" or die;
open OUT,">",$outfile or die;

my %case_hs = ();
my @arr = qw(barcode project_id data_category data_type RNA-seq platform gender sample_type_id sample_type tumor_stage vital_status days_to_last_follow_up file_name);

print OUT join "\t",@arr;
print OUT "\n";
while(<IN>){
	s/[\r\n]$//g;
	if(/^    "metadata_files"/){
		if(exists $case_hs{"barcode"}){
			my @value = ();
			foreach my $feature(@arr){
				push @value, $case_hs{$feature};
			}
			print OUT join "\t",@value;
			print OUT "\n";
		}
		
		foreach my $feature(@arr){ #initialize
			$case_hs{$feature} = "null";	
		}
	}
	
	if(/^    "data_type"/){
		$case_hs{"data_type"} = value_of($_);
	}
	if(/^        "submitter_id"/){ #TCGA submitter
		$case_hs{"barcode"} = value_of($_);
	}
	if(/^    "tags"/){
		<IN>;
		my $v = <IN>;
		$v =~ s/[\r\n]$//g;
		$case_hs{"RNA-seq"} = (split /"/, $v)[1];
	}
	if(/^    "platform"/){
		$case_hs{"platform"} = value_of($_);
	}
	if(/^    "data_category"/){
		$case_hs{"data_category"} = value_of($_);
	}
	if(/^          "project_id"/){
		$case_hs{"project_id"} = value_of($_);
	}
	if(/^          "gender"/){
		$case_hs{"gender"} = value_of($_);
	}
	if(/^            "sample_type_id"/){
		$case_hs{"sample_type_id"} = value_of($_);
	}
	if(/^            "sample_type"/){
		$case_hs{"sample_type"} = value_of($_);
	}
	if(/^            "days_to_last_follow_up"/){
		s/\s//g;
		s/,//g;
		my @a = split /\:/;
		$case_hs{"days_to_last_follow_up"} = $a[1];
	}
	if(/^            "vital_status"/){
		$case_hs{"vital_status"} = value_of($_);
	}
	if(/^    "file_name"/){
		$case_hs{"file_name"} = value_of($_);
	}
	if(/^            "tumor_stage"/){
		$case_hs{"tumor_stage"} = value_of($_);
	}
}
if(exists $case_hs{"barcode"}){
	my @value = ();
	foreach my $feature(@arr){
		push @value, $case_hs{$feature};
	}
	print OUT join "\t",@value;
	print OUT "\n";
}


close IN;
close OUT;

sub value_of{
	my ($key_value) = @_;
	
	my @arr = split /"/,$key_value;
	return $arr[3];
}